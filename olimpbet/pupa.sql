
-- К сожалению, в настоящий момент

SELECT
    user_id
FROM events_parsed
WHERE
    project_id = 'prod-405'
    AND toDate(timestamp) = '2023-02-24'
    AND text = 'К сожалению, в настоящий момент на сайте ведутся технические работы. Ориентировочные сроки — 30 минут. Приносим извинения за неудобства.'
ORDER BY ts_ms
LIMIT 1000
;



