SELECT
    quantilesExactExclusive(0.25, 0.5, 0.75, 0.9, 0.95, 0.99, 0.999)(length(text))
FROM events_parsed
WHERE
    project_id = 'prod-544'
    AND toDate(timestamp) >= '2023-04-20'
    AND incoming=1
    AND type = 'text'
;
