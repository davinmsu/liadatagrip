-- unique users by day

SELECT
    toString(toDayOfMonth(timestamp))as day,
    if(v > 1 AND v <= u, v, u) as user_identifier,
    uniqExact(visitor_id)      as v,
    uniqExact(user_id)         as u
FROM events_parsed
WHERE timestamp BETWEEN '2022-09-01 00:00:00' AND '2022-10-01 00:00:00'
AND project_id = 'prod-167'
GROUP BY day
ORDER BY day ASC
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
    round(coverage*user_identifier, 2) as cov_mau
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


-- Coverage mismatch
SELECT project_id,
       dictGetOrDefault('projects_dict', 'name', toUInt64(splitByChar('-', project_id)[2]), '') AS project_name,
       count()                                                                                     cnt,
       countIf(is_a + is_b = 2) / cnt * 100                                                        ab,
       countIf(is_a + is_c = 2) / cnt * 100                                                        ac,
       countIf(is_b + is_c = 2) / cnt * 100                                                        bc
FROM (
      SELECT project_id,
             user_id,
             countIf(type = 'terminate') = 0                                   as is_a,
             countIf(fully_marked = 0) = 0 AND countIf(type = 'terminate') > 0 as is_b,
             countIf(fully_marked = 0) > 0                                     as is_c
      FROM events_parsed
      WHERE timestamp BETWEEN '2022-09-01 00:00:00' AND '2022-10-01 00:00:00'
      GROUP BY project_id, user_id
      ORDER BY project_id
         )
GROUP BY project_id
ORDER BY ac DESC
;



