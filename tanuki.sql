SELECT
    *
FROM events_parsed
WHERE
    text like '%Рады были помочь%'
--     user_id = '1287970'
--     AND project_id = 'prod-131'
    AND (( incoming = 1 AND meta !='{}') OR (incoming = 0))
    AND timestamp BETWEEN '2022-10-14 00:00:00' AND '2022-10-30 00:00:00'
ORDER BY user_id, timestamp
;