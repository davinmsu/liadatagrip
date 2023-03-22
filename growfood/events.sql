SELECT
    *
FROM events_parsed
WHERE
--     project_id = 'prod-182'
    toDate(timestamp) > '2023-02-01'
--     AND user_id = '630057874'
ORDER BY ts_ms DESC
LIMIT 100
;


SELECT
    user_id,
    count() as cnt
FROM events_parsed
WHERE
    project_id = 'prod-182'
    AND toDate(timestamp) >= '2022-10-01'
    AND text = 'Направила запрос, чтобы курьер вам перезвонил, он сможет сориентировать по времени прибытия заказа'
    AND incoming = 0
GROUP BY user_id
ORDER BY cnt DESC
;