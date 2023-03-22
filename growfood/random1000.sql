SELECT
    *
FROM events_parsed
WHERE
    project_id = 'prod-182'
    AND dateTrunc('month', timestamp) = '2022-11-01'
;