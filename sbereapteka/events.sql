SELECT
    *
FROM events_parsed
WHERE project_id ='prod-336'
    AND toDate(timestamp) >= '2023-03-10'
ORDER BY ts_ms DESC
LIMIT 1000
;