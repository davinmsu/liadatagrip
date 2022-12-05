SELECT
    *
FROM events_parsed
WHERE
    project_id = 'prod-528'
    AND toDate(timestamp) >= '2022-11-28'
--     AND user_id = '114211609'
    AND text like '%И почему то кноп%'
    AND incoming = 1
ORDER BY ts_ms
;



