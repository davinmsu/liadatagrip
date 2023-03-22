SELECT
    text
FROM events_parsed
WHERE
    project_id = 'prod-131'
    AND toDate(timestamp) >= '2023-02-20'
    AND incoming = 1
ORDER BY ts_ms DESC
LIMIT 100
;

