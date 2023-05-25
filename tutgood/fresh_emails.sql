SELECT
    user_id as chat_id,
    first_value(JSONExtractString(facts, 'client_email')) as email
--     text,
--     intents,
--     timestamp, user_id, incoming, type, text, params
--     *
FROM events_parsed
WHERE
    project_id = 'prod-527'
    AND toDate(timestamp) >= '2023-03-30'
--     AND text like '%тэги%'
--     AND incoming = 1
GROUP BY user_id
LIMIT 1000
;