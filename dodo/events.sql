(
    1476115,
    1476167,
    1476206,
    1476465,
    1476526,
    1476545,
    1476370,
    1476260
)

(   1476714,
    1476783,
    1075282
)



SELECT
    JSONExtractString(JSONExtractRaw(facts, 'session'), 'id') as sid,
    *
from events_parsed
WHERE
    project_id = 'prod-428'
    AND
    toDate(timestamp) > '2022-12-06'
    AND sid in
(   1476714,
    1476783,
    1075282
)
ORDER BY user_id, ts_ms
LIMIT 1000
;


-- {"chat": {"id": "7466706"}, "clientData": {"data": {"name": "\u041a\u0430\u0440\u0438\u043d\u0430 \u041a\u0430\u0440\u0438\u043d\u0430", "topic": null, "locale": "ru-RU", "phone": "+79689837191", "email": null}}, "session": {"id": "1504109"}, "question": {"index": 3}}
-- clientData data phone

SELECT
    JSONExtractString(JSONExtractRaw(JSONExtractRaw(facts, 'clientData'), 'data'), 'phone') as phone
--     facts
FROM events_parsed
WHERE
    project_id = 'prod-428'
    AND toDate(timestamp) >= '2023-04-18'
--     AND text = 'DODO_CLOSE_THREAD'
LIMIT 1000
;



SELECT
--     fact_keys
    JSONExtractString(JSONExtractRaw(facts, 'session'), 'id') as session_id
--     facts
FROM events_parsed
WHERE
    project_id = 'prod-428'
    AND toDate(timestamp) >= toDate(now())
--     AND text = 'DODO_CLOSE_THREAD'
LIMIT 1000
;




SELECT
    user_id,
    timestamp,
    facts
FROM events_parsed
WHERE
    project_id = 'prod-428'
    AND toDate(timestamp) = toDate(now())
--     AND text = 'DODO_CLOSE_THREAD'
ORDER BY ts_ms DESC
LIMIT 100
;


SELECT
    *
FROM events_parsed
WHERE
    project_id = 'prod-428'
    AND user_id = '3459161'
--     AND toDate(timestamp) >= '2023-04-01'
--     AND has(intents, 'intent-41303')
--     AND length(intents) = 1
ORDER BY ts_ms

;

SELECT
    timestamp,
    user_id,
    text,
    n_text,
    n2_text
FROM (
         SELECT timestamp,
                ts_ms,
                user_id,
                incoming,
                text,
                intents,
                neighbor(text, 1)     as n_text,
                neighbor(text, 2)     as n2_text,
                neighbor(incoming, 1) as n_incoming,
                neighbor(ts_ms, 1)    as n_ts_ms,
                neighbor(user_id, 1)  as n_user_id,
                neighbor(user_id, 2)     as n2_user_id
         FROM events_parsed
         WHERE project_id = 'prod-428'
           AND toDate(timestamp) >= '2023-05-01'
         ORDER BY ts_ms
         )
WHERE
    n_user_id = user_id
    AND n2_user_id = n_user_id
    AND intents = ['intent-41303']



-- intent-41303


-- 4289513


