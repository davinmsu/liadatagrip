-- Поиск удачных кейсов по задаче со сниппетом получить юзер инфо посредством...
SELECT
    user_id
FROM events_parsed
WHERE
    project_id = 'prod-182'
    AND toDate(timestamp) >= '2022-12-07'
    AND text = 'Направила запрос, чтобы курьер вам перезвонил, он сможет сориентировать по времени прибытия заказа'
--     AND user_id = '630052741'
ORDER BY ts_ns
;





SELECT
    distinct JSONExtract(facts,'transport_type', 'String') as transport_type
--     ,JSONExtract(facts,'transport_id', 'String') as transport_id
FROM events_parsed
WHERE
    project_id = 'prod-182'
    AND dateTrunc('month', timestamp) = '2022-11-01'
--     AND transport_type = 'external'
--     AND transport_id like '7__________'
ORDER BY ts_ms
;



SELECT
    JSONExtract(facts,'transport_type', 'String') as transport_type,
    JSONExtract(facts,'transport_id', 'String') as transport_id
FROM events_parsed
WHERE
    project_id = 'prod-182'
    AND dateTrunc('month', timestamp) = '2022-11-01'
    AND transport_type = 'external'
    AND transport_id like '7__________'
ORDER BY ts_ms
;


