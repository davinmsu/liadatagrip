SELECT *
FROM
(SELECT *,
        neighbor(text, 1) as ntext
 FROM (
          SELECT *
          FROM events_parsed
          WHERE project_id = 'prod-248'
            AND toDate(timestamp) >= '2022-11-28'
--             AND user_id = '114313930'
            AND incoming = 1
          ORDER BY ts_ms
          ))
WHERE text = ntext
AND text not in ('', '/start')
;



SELECT
    *
FROM events_parsed
WHERE project_id = 'prod-248'
AND toDate(timestamp) >= '2022-10-27'
AND user_id = '114740332'
-- AND text like '%Здравствуйте, не как не получается запустить приложение%'
ORDER BY ts_ms
;