-- 1503052

SELECT
    *
FROM events_parsed
WHERE
    project_id = 'prod-111'
    AND toDate(timestamp) > '2022-11-01'
--     AND type = 'intent'
--     AND text = 'привет 123'
    AND user_id = '1533862'
;