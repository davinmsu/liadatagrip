SELECT
    JSONExtractString(facts, 'user_phone') as phone,
    *
FROM events_parsed
WHERE
    project_id = 'prod-182'
    AND toDate(timestamp) >= '2023-04-07'
    AND incoming = 1
ORDER BY ts_ms DESC
;
