SELECT
    DISTINCT JSONExtractString(facts, 'channel_type') as channel_type
FROM events_parsed
WHERE
    project_id = 'prod-137'
    AND toDate(timestamp) >= '2022-01-01'
LIMIT 1000
;



SELECT
    uniqExact(user_id) as uniq_users,
    uniqExact(visitor_id) as uniq_visitors,
    countIf(incoming = 1) as incoming_messages,
    uniq_visitors/incoming_messages as uniq_visitors_per_incoming,
    uniq_users/incoming_messages as uniq_users_per_incoming,
    dateTrunc('month', timestamp) as month
FROM events_parsed
WHERE
    project_id = 'prod-111'
    AND toDate(timestamp) >= '2023-01-01'
GROUP BY month
ORDER BY month
LIMIT 1000
;