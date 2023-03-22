SELECT
    *
FROM events_parsed
WHERE
    project_id = 'prod-303'
    AND toDate(timestamp) >= '2023-01-23'
    AND type = 'terminate'
ORDER BY ts_ms DESC
;
