SELECT
    DISTINCT channel_id
FROM events_parsed
WHERE
    toDate(timestamp) >= '2023-01-01'
ORDER BY channel_id
LIMIT 1000;