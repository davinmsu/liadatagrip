SELECT
    *
FROM events_parsed
WHERE
    project_id = 'prod-111'
    AND toDate(timestamp) > 'q022-12-01'
    AND user_id = '1771978'
ORDER BY ts_ms
;


