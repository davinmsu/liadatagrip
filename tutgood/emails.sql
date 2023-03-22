SELECT
    timestamp,
    JSONExtractString(facts, 'client_email') as email,
    fact_keys,
    facts
FROM events_parsed
WHERE
    timestamp >= '2023-02-03 11:00:00'
    AND project_id in ('prod-528', 'prod-527')
    AND incoming = 1
ORDER BY ts_ms DESC
LIMIT 1000
;