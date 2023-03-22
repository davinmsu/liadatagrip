SELECT
    timestamp,
    user_id,
    project_id
FROM events_parsed
WHERE
    timestamp > '2023-03-03 10:26:00'
--     AND project_id in ('prod-355')
    AND hasAny(intents, ['intent-42383', 'intent-42380'])
;


-- 42380 островок
-- 42383 смм