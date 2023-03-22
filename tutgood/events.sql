
SELECT
    user_id as chat_id,
    first_value(JSONExtractString(facts, 'client_email')) as email
--     text,
--     intents,
--     timestamp, user_id, incoming, type, text, params
--     *
FROM events_parsed
WHERE
    project_id = 'prod-528'
    AND toDate(timestamp) >= '2023-02-22'
--     AND text like '%тэги%'
--     AND incoming = 1
GROUP BY user_id
LIMIT 1000
;





SELECT
    text,
--     intents,
--     timestamp, user_id, incoming, type, text, params
    *
FROM events_parsed
WHERE
    project_id = 'prod-528'
    AND toDate(timestamp) >= '2023-02-22'
    AND text like '%тэги%'
--     AND incoming = 1
ORDER BY ts_ms
LIMIT 1000
;

{"lia_request_track_id": "0c0039265bf349e69176cc1c9a27f1a3", "client_id_usedesk": "62717019", "ticket_id_usedesk": "125815317", "phones": "", "client_email": ""}



SELECT
    JSONExtractRaw(facts, 'client_email')
    ,
    *
FROM events_parsed
WHERE
    project_id = 'prod-528'
    AND toDate(timestamp) >= '2023-02-21'
    AND user_id = '125743668'
ORDER BY ts_ms
LIMIT 1000
;

{"lia_request_track_id": "baeeab3074b7494c8dd28b574bbd8cfe", "client_id_usedesk": "108113189", "ticket_id_usedesk": "125743668", "phones": "", "client_email": "", "channel_id": "usedesk-990e77cb-c6fc-4e0d-8d03-bc5bd3763cc3"}


SELECT
    timestamp, user_id, incoming, type, text, params
--     *
FROM events_parsed
WHERE
    project_id = 'prod-528'
    AND toDate(timestamp) >= '2022-10-28'
    AND user_id = '117595268'
--     AND text like '%не грузит тест%'
--     AND incoming = 1
ORDER BY ts_ms
LIMIT 1000
;


SELECT
    timestamp, user_id, incoming, type, text, params
--     *
FROM events_parsed
WHERE
    project_id = 'prod-528'
    AND toDate(timestamp) >= '2022-10-28'
    AND text like '%Это тест перевода в группу "неназначенные"%'
--     AND incoming = 1
ORDER BY ts_ms
;



SELECT
    user_id, timestamp, incoming, type, text
--     *
FROM events_parsed
WHERE
    project_id = 'prod-528'
    AND timestamp >= '2022-12-08 20:00:00'
    AND timestamp < '2022-12-09 03:00:00'
    AND type = 'terminate'
--     AND text like '%не грузит тест%'
--     AND incoming = 1
ORDER BY ts_ms
;


SELECT
    *
FROM events_parsed
WHERE
    timestamp >= '2022-12-07 20:00:00'
    AND user_id = 'liatest2022-12-09-02'
    AND incoming = 1
ORDER BY ts_ms
;



SELECT
    *
FROM events_parsed
WHERE
    timestamp >= '2022-12-07 20:00:00'
    AND project_id = 'prod-527'
    AND incoming = 1
ORDER BY ts_ms
LIMIT 1000
;




SELECT
    *
FROM events_parsed
WHERE
    timestamp >= '2022-12-07 20:00:00'
    AND project_id = 'prod-527'
    AND user_id = '123575991'
ORDER BY ts_ms
LIMIT 1000
;





SELECT
    timestamp, user_id, incoming, type, text, params
--     *
FROM events_parsed
WHERE
    project_id = 'prod-528'
    AND length(text) > 1000
    AND toDate(timestamp) >= '2022-10-28'
    AND user_id = '34430068'
--     AND text like '%не грузит тест%'
    AND incoming = 1
ORDER BY ts_ms
;

