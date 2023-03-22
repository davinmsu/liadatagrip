SELECT
    dateTrunc('month', timestamp) as month,
    count(user_id) as cnt,
    uniq(user_id) as uniq
FROM events_parsed
WHERE
    project_id = 'prod-405'
    AND toDate(timestamp) >= '2022-01-01'
GROUP BY month
ORDER BY month
;