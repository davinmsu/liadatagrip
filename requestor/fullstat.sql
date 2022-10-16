-- fullstat
WITH
    '2022-09-01 00:00:00' as startTime,
    '2022-10-01 00:00:00' as endTime,
    ('prod-188', 'prod-189', 'prod-363', 'prod-364') as special_projects
SELECT
    project_id,
    project_name,
    user_identifier as mau,
    cov_pct,
    cov,
    round(dictGetOrDefault('pricing_dict', 'fixed', (project_id), 0) +
    mau * dictGetOrDefault('pricing_dict', 'per_mau', (project_id), 0) +
    cov * dictGetOrDefault('pricing_dict', 'per_cov_mau', (project_id), 0)  +
    user_events * dictGetOrDefault('pricing_dict', 'per_events_users', (project_id), 0),2) as revenue,
    cov_a, cov_b, cov_c, cov_a_pct, cov_b_pct, cov_c_pct,
    sessions,
    events, lia_events, user_events
FROM
(
    SELECT project_id,
           dictGetOrDefault('projects_dict', 'name', toUInt64(splitByChar('-', project_id)[2]), '') AS project_name,
           count()                                                                                  as cnt,
           sum(is_a) as cov_a,
           sum(is_b) as cov_b,
           sum(is_c) as cov_c,
           cov_a + cov_b as cov,
           round(cov_a / cnt * 100, 2)                                                          as cov_a_pct,
           round(cov_b / cnt * 100, 2)                                                          as cov_b_pct,
           round(cov_c / cnt * 100, 2)                                                          as cov_c_pct,
           round(cov_a_pct + cov_b_pct, 2)                                                      as cov_pct
    FROM (
          SELECT project_id,
                 countIf(type = 'terminate') = 0                                   as is_a,
                 countIf(fully_marked = 0) = 0 AND countIf(type = 'terminate') > 0 as is_b,
                 countIf(fully_marked = 0) > 0 AND countIf(type = 'terminate') > 0 as is_c
          FROM events_parsed
          WHERE timestamp BETWEEN startTime AND endTime
          GROUP BY project_id, user_id
          ORDER BY project_id
             )
    GROUP BY project_id
) AS coverage
JOIN
(
-- Determine user_identifier
    SELECT project_id,
           countIf(event_id, incoming=1) as user_events,
           countIf(event_id, incoming=0) as lia_events,
           user_events + lia_events as events,
           uniqExact(visitor_id)      as v,
           uniqExact(user_id)         as sessions,
           if(v > 1 AND v <= sessions AND project_id NOT IN special_projects, v, sessions) as user_identifier
    FROM events_parsed
    WHERE timestamp BETWEEN startTime AND endTime
    AND ((incoming = 1 AND meta != '{}') OR (incoming = 0))
    GROUP BY project_id
)
AS users ON coverage.project_id = users.project_id
;
