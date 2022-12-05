SELECT
    *
FROM events_parsed
WHERE
    project_id = 'prod-182'
    AND toDate(timestamp) >= '2022-11-28'


;