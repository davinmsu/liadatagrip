SELECT
    *
FROM default.events_parsed
WHERE
    project_id = 'prod-111'
    AND timestamp > toStartOfHour(now())



