SELECT
    intent,
    count() as cnt
FROM events_parsed
ARRAY JOIN intents as intent
WHERE
    project_id = 'prod-182'
    AND toDate(timestamp) >= '2023-01-01'
    AND toDate(timestamp) < '2023-02-01'
    AND intents != []
GROUP BY intent

;


SELECT
    type,
    count() as cnt
FROM events_parsed
ARRAY JOIN intents as intent
WHERE
    project_id = 'prod-182'
    AND toDate(timestamp) >= '2023-01-01'
    AND toDate(timestamp) < '2023-02-01'
    AND incoming = 1
GROUP BY type
;


SELECT
    *
FROM events_parsed
WHERE
    project_id = 'prod-182'
    AND toDate(timestamp) > '2023-01-01'
ORDER BY ts_ms
LIMIT 1000
;