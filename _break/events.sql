SELECT
    *
FROM events_parsed
WHERE
    project_id = 'prod-303'
    AND user_id = '1758460'
    AND timestamp > '2023-03-12 14:30:00'
    AND timestamp < '2023-03-12 17:30:00'
;






SELECT
    distinct user_id
FROM events_parsed
WHERE
    project_id = 'prod-303'
    AND timestamp > '2023-03-12 14:30:00'
    AND timestamp < '2023-03-12 17:30:00'
;


SELECT
    project_id
       ,
    count() as cnt
FROM events_parsed
WHERE
    timestamp > '2023-03-11 16:00:00'
    AND timestamp < '2023-03-11 17:00:00'
GROUP BY project_id
ORDER BY cnt DESC
;