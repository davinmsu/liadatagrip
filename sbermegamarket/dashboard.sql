SELECT
    toDate(dateTrunc('day', timestamp))as day,
    uniq(visitor_id)
FROM default.events_parsed
WHERE
    project_id = 'prod-111'
    AND toDate(timestamp) > '2023-04-01'
GROUP BY day
ORDER BY day
;

SELECT
    toDate(dateTrunc('week', timestamp))as week,
    uniq(visitor_id)
FROM default.events_parsed
WHERE
    project_id = 'prod-111'
    AND toDate(timestamp) > '2023-04-01'
GROUP BY week
ORDER BY week
;

SELECT
    toDate(dateTrunc('month', timestamp))as month,
    uniq(visitor_id)
FROM default.events_parsed
WHERE
    project_id = 'prod-111'
    AND toDate(timestamp) > '2023-01-01'
GROUP BY month
ORDER BY month
;

-- Количество сообщений за период
SELECT
    count() as inc_nessages
FROM default.events_parsed
WHERE
    project_id = 'prod-111'
    AND toDate(timestamp) > '2023-01-01'
    AND incoming=1
;