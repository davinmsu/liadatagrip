SELECT
    type,
    count() as cnt
FROM events_parsed
WHERE
    project_id = 'prod-140'
    AND dateTrunc('month', timestamp) = '2021-12-01'
GROUP BY type
;




SELECT
    *
FROM events_parsed
WHERE
    project_id = 'prod-140'
    AND dateTrunc('month', timestamp) = '2022-12-01'
LIMIT 1000
;
