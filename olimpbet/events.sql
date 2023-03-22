SELECT
    *
FROM events_parsed
WHERE
    project_id = 'prod-405'
    AND toDate(timestamp) >= '2022-12-27'
--     AND user_id != session_id
    AND user_id = 'RPE156HZLM'
ORDER BY ts_ms
LIMIT 1000
;



SELECT
    dateTrunc('day', timestamp) as day,
    uniq(user_id) as users

FROM events_parsed
WHERE
    project_id = 'prod-405'
    AND toDate(timestamp) >= '2022-12-27'
GROUP BY day
ORDER BY day
;



SELECT
    n_starts,
    count() as cnt
FROM (
         SELECT user_id,
                countIf(type = 'start') as n_starts
         FROM events_parsed
         WHERE project_id = 'prod-405'
           AND toDate(timestamp) > '2022-11-01'
           AND incoming = 1
         GROUP BY user_id
         )
GROUP BY n_starts
ORDER BY n_starts
;