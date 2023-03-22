SELECT
    dateTrunc('month', timestamp) as month,
--     uniq(visitor_id) as vid,
    uniq(user_id) as uid
FROM events_parsed
WHERE
    project_id = 'prod-167'
    AND dateTrunc('year', timestamp) = '2022-01-01'
GROUP BY month
ORDER BY month
LIMIT 100
;