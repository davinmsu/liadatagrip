SELECT
    user_id,
    count() as files_cnt
FROM events_parsed
WHERE
    project_id = 'prod-111'
    AND toDate(timestamp) > '2022-12-01'
    AND type = 'file'
GROUP BY user_id
HAVING files_cnt > 1
LIMIT 1000
;


SELECT
    *
FROM events_parsed
WHERE
    project_id = 'prod-111'
    AND toDate(timestamp) > '2022-12-01'
    AND user_id = '1811430'
ORDER BY ts_ms
LIMIT 1000
;
