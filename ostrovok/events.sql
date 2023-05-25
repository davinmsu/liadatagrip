SELECT
    *
FROM
    events_parsed
WHERE
    project_id = 'prod-355'
    AND toDate(timestamp) = '2023-03-13'
    AND user_id = '404775'
--     AND text like '%раздельные%'
LIMIT 1000
;

-- 404775

