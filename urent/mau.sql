SELECT
    dateTrunc('month', timestamp) as month,
    uniq(user_id) as uid
FROM events_parsed
WHERE
    project_id = 'prod-248'
    AND toDate(timestamp) >= '2022-01-01'
GROUP BY month
;