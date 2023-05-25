
-- медианное значение количества входящих сообщений по проектно (за март)
SELECT
    project_id,
    dictGetOrDefault('projects_dict', 'name', toUInt64OrZero(splitByChar('-', project_id)[2]), '') as project_name,
    median(cnt) as median_num_incomings
FROM (
         SELECT project_id,
                user_id,
                count() as cnt
         FROM events_parsed
         WHERE dateTrunc('month', timestamp) = '2023-03-01'
           AND incoming = 1
         GROUP BY project_id, user_id
         )
GROUP BY project_id
ORDER BY sum(cnt) DESC
LIMIT 1000
;


-- медианное значение промежутков между входящих сообщений по проектно (за март)
SELECT
    project_id,
    dictGetOrDefault('projects_dict', 'name', toUInt64OrZero(splitByChar('-', project_id)[2]), '') as project_name,
    round(median(diff_ms)/1000) as med_timeout_s
FROM (
         SELECT *,
                neighbor(ts_ms, 1) as nbr,
                neighbor(project_id, 1) as n_pid,
                neighbor(user_id, 1) as n_uid,
                (nbr - ts_ms)      as diff_ms
         FROM (
                  SELECT project_id,
                         user_id,
                         ts_ms
                  FROM events_parsed
                  WHERE dateTrunc('month', timestamp) = '2023-03-01'
                    AND incoming = 1
                  ORDER BY project_id, user_id, ts_ns
                  )
         )
WHERE
    project_id = n_pid
    AND user_id = n_uid
GROUP BY project_id
ORDER BY count() DESC
LIMIT 1000
;

