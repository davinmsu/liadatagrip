SELECT
    dateTrunc('month', timestamp) as month,
    uniq(visitor_id) as visitors
FROM events_parsed
WHERE
    project_id = 'prod-111'
    AND toDate(timestamp) >= '2022-01-01'
GROUP BY month
LIMIT 100