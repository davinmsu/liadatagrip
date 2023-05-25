SELECT
    timestamp,
    ts_ms,
    incoming,
    text,
    facts
FROM events_parsed
WHERE
    project_id = 'prod-182'
    AND toDate(timestamp) > '2023-03-16'
    AND user_id = '630087148'
ORDER BY ts_ms

-- LIMIT 100
;
