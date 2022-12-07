SELECT
    timestamp, incoming, type, text
--     *
FROM events_parsed
WHERE
--     project_id = 'prod-528'
    toDate(timestamp) >= '2022-10-28'
    AND user_id = '115271455'
--     AND text like '%не грузит тест%'
--     AND incoming = 1
ORDER BY ts_ms
;



