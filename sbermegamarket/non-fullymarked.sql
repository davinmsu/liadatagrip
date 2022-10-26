SELECT
    timestamp,
       user_id,
    text,
    intents
FROM default.events_parsed
WHERE
    project_id = 'prod-111'
    AND toDate(timestamp) > toStartOfWeek(now())
    AND incoming = 1
    AND fully_marked = 0
ORDER BY ts_ms
;