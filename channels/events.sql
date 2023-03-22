SELECT
    DISTINCT channel_id
FROM events_parsed
WHERE
    toDate(timestamp) >= '2023-01-01'
ORDER BY channel_id
LIMIT 1000;


SELECT
    DISTINCT project_id
FROM events_parsed
WHERE
    toDate(timestamp) >= '2023-01-01'
    AND channel_id = 'jivochat-1'
-- ORDER BY channel_id
LIMIT 1000;
