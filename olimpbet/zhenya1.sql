SELECT
    *
FROM events_parsed
WHERE
    project_id = 'prod-405'
    AND user_id = 'RL4OGYWDIB'
--     AND text = 'О'
    AND toDate(timestamp) > '2022-10-20'
ORDER BY ts_ms
;
