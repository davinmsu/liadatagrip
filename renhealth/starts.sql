SELECT
    type,
    count() as cnt
FROM events_parsed
WHERE
    project_id = 'prod-140'
    AND dateTrunc('month', timestamp) = '2021-11-01'
GROUP BY type
;
