SELECT
   uniqExact(user_id),
   uniqExact(visitor_id)
FROM events_parsed
WHERE
    project_id = 'prod-111'
--     AND ((incoming = 1 AND meta != '{}') OR (incoming = 0))
    AND timestamp BETWEEN '2022-09-01 00:00:00' AND '2022-09-02 00:00:00'
-- ORDER BY user_id, ts_ns
;


WITH
    '2022-09-01 00:00:00' as startTime,
    '2022-10-01 00:00:00' as endTime,
    'prod-363' as project
SELECT
     countIf(type = 'terminate') = 0                                   as is_a,
     countIf(fully_marked = 0) = 0 AND countIf(type = 'terminate') > 0 as is_b,
     countIf(fully_marked = 0) > 0 AND countIf(type = 'terminate') > 0 as is_c
FROM events_parsed
WHERE timestamp BETWEEN startTime AND endTime
    AND project_id = project
GROUP BY user_id
;


-- events, user_events, lia_events, users, sessions, terminates
WITH
    '2022-09-01 00:00:00' as startTime,
    '2022-10-01 00:00:00' as endTime,
    'prod-363' as project,
    ('prod-188', 'prod-189', 'prod-363', 'prod-364') as special_projects
SELECT
       countIf(DISTINCT event_id, type = 'terminate') as terminates,
       uniqExact(event_id) as events,
       countIf(DISTINCT event_id, incoming = 1) as user_events,
       countIf(DISTINCT event_id, incoming = 0) as lia_events,
       uniqExact(visitor_id)      as v,
       uniqExact(user_id)         as sessions,
       if(v > 1 AND v <= sessions AND project NOT IN special_projects, v, sessions) as users
FROM events_parsed
WHERE
    timestamp BETWEEN startTime AND endTime
    AND project_id = project
;



-- Coverage
WITH
    '2022-09-01 00:00:00' as startTime,
    '2022-10-01 00:00:00' as endTime
SELECT
    v,
    u,
    project_name,
    project_id,
    user_identifier,
    cov_a,
    cov_a + cov_b as coverage,
    coverage*user_identifier
--        *,
--        round(user_identifier*cov_pct/100) as cov_users
FROM
(
    SELECT project_id,
           dictGetOrDefault('projects_dict', 'name', toUInt64(splitByChar('-', project_id)[2]), '') AS project_name,
           count()                                                                                  as cnt,
           round(sum(is_a) / cnt * 100, 2)                                                          as cov_a,
           round(sum(is_b) / cnt * 100, 2)                                                          as cov_b,
           round(sum(is_c) / cnt * 100, 2)                                                          as cov_c,
           round(cov_a + cov_b, 2)                                                                  as cov_pct
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
           uniqExact(visitor_id)      as v,
           uniqExact(user_id)         as u,
           if(v > 1 AND v <= u, v, u) as user_identifier
    FROM events_parsed
    WHERE timestamp BETWEEN startTime AND endTime
    GROUP BY project_id
)
AS users ON coverage.project_id = users.project_id
-- WHERE project_id in ('prod-364', 'prod-188', 'prod-189', 'prod-363')
;
