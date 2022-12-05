-- Оказалось, что девочка заболела,

SELECT
    timestamp, text,
    *
FROM events_parsed
WHERE
    project_id = 'prod-528'
    AND toDate(timestamp) >= '2022-10-28'
    AND user_id = '114313930'
--     AND text like '%Не могу посмотреть что за ученик у меня на сегодня%'
--     AND incoming = 1
ORDER BY ts_ms
;



