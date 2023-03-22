SELECT
    text,
    facts,
    *
FROM events_parsed
WHERE
    project_id = 'prod-528'
    AND toDate(timestamp) >= '2023-02-13'
    AND user_id = '124752668'
--     AND text like '%помогите изменить реквизит%'
ORDER BY ts_ms DESC
LIMIT 1000
;

