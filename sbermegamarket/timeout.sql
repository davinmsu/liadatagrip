SELECT
       tsn,
       visitor_id,
       round(diff/60) as diff_minutes
FROM
(
SELECT
    visitor_id,
    timestamp,
    event_id,
    neighbor(event_id, 1) as ev,
    neighbor(timestamp, 1) as tsn,
    neighbor(visitor_id, 1) as tsu,
    (tsn - timestamp) as diff
FROM
(
    SELECT *
    FROM default.events_parsed
    WHERE project_id = 'prod-111'
      AND timestamp > toStartOfWeek(now())
      AND incoming = 1
      AND meta != '{}'
    ORDER BY visitor_id, ts_ms
)
)
WHERE
    visitor_id = tsu
    AND  diff > 1*60*60
ORDER BY tsn
;





















SELECT
*
--        distinct length(visitor_id)
FROM events_parsed
WHERE
    project_id = 'prod-111'
    AND visitor_id = '"01ef45bde9c61a3850552563866cd846"'
    AND incoming = 1
    AND meta != '{}'
AND timestamp > toStartOfWeek(now())

ORDER BY user_id, ts_ms