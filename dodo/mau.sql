SELECT
    uniqExact(user_id) as users,
    date_trunc('month', timestamp) as month
FROM events_parsed
WHERE
    project_id in ('prod-428')
    AND toDate(timestamp) > '2022-01-01'
GROUP BY month