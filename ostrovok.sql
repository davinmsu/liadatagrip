SELECT
    *
FROM default.events_parsed
WHERE
    project_id = 'prod-355'
    AND toDate(timestamp) >= '2022-10-01'
ORDER BY ts_ms
;