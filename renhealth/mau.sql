SELECT

    dateTrunc('month', toDateTime(timestamp, 'Europe/Moscow')) as month,
    uniqExact(user_id) as mau,
    uniqExact(JSONExtractString(facts, 'chat_id')) as uniq_chats
FROM events_parsed
WHERE
    project_id = 'prod-140'
    AND toDate(timestamp) >= '2022-01-01'
GROUP BY month
LIMIT 1000
;


SELECT
    *
FROM events_parsed
WHERE
    project_id = 'prod-140'
    AND toDate(timestamp) >= '2022-12-19'
;
