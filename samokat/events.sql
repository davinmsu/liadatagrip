SELECT
    DISTINCT JSONExtractString(facts, 'channel_type') as channel_type
FROM events_parsed
WHERE
    project_id = 'prod-137'
    AND toDate(timestamp) >= '2022-01-01'
LIMIT 1000
;