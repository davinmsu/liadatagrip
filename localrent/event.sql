SELECT
    *
FROM events_parsed
WHERE project_id = 'prod-344'
AND toDate(timestamp) = '2022-12-23'
AND user_id = '238620403'
ORDER BY ts_ms
LIMIT 100
;