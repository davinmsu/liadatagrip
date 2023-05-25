SELECT
    text
FROM events_parsed
WHERE
    project_id = 'prod-527'
    AND toDate(timestamp) >= '2023-05-01'
    AND incoming=1
    AND type='text'
    AND text like '<%'
    AND text not like '<p>userAA%'
ORDER BY ts_ms
LIMIT 1000
;