SELECT
    *
FROM events_parsed
WHERE
    project_id = 'prod-303'
    AND toDate(timestamp) >= '2022-12-12'
    AND user_id = '1498149'
ORDER BY ts_ms
;