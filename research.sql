SELECT
    DISTINCT toDate(timestamp)  as date
FROM events_parsed
WHERE
    project_id = 'prod-137'
ORDER BY date
--     AND timestamp > '2021-04-01 00:00:00'
--     AND timestamp < '2021-05-01 00:00:00'
;





-- Fast Dialogs
SELECT
    timestamp,
    user_id,
    if(incoming,'user','lia') as who,
    text
FROM events_parsed
WHERE
    project_id = 'prod-137'
--     AND user_id = '105620064'
    AND (( incoming = 1 AND meta !='{}') OR (incoming = 0))
    AND timestamp BETWEEN '2022-10-11 12:07:00' AND '2022-10-30 00:00:00'
ORDER BY user_id, timestamp
;


-- MAU
SELECT
    uniqExact(user_id) as mau
FROM events_parsed
WHERE
    project_id = 'prod-137'
    AND toDate(timestamp) >= '2022-08-01'
    AND toDate(timestamp) < '2022-09-01'
;



-- MAU of all projects > 100
SELECT
    project_id,
    dictGetOrDefault('projects_dict', 'name', toUInt64(splitByChar('-', project_id)[2]), '') AS project_name,
    uniqExact(user_id) as mau
FROM events_parsed
WHERE
    toDate(timestamp) >= '2021-12-01'
    AND toDate(timestamp) < '2022-01-01'
    AND project_name = 'Urent'
GROUP BY project_id
HAVING mau > 1
ORDER BY mau DESC
;



-- MAU All Monthly
SELECT
       project_id,
       dictGetOrDefault('projects_dict', 'name', toUInt64(splitByChar('-', project_id)[2]), '') AS project_name,
       month,
       users
FROM
(
    SELECT project_id,
           toStartOfMonth(toTimeZone(timestamp, 'Europe/Moscow')) as month,
--        uniqExact(user_id) as users,
           uniqExact(user_id)                                     as u,
           uniqExact(visitor_id)                                  as v,
           if(v > 1 AND v <= u, v, u)                             as users
--        uniqExact(visitParamExtractRaw(facts, 'conversation_id')) as conversations
    FROM events_parsed
    WHERE timestamp BETWEEN '2022-01-01 00:00:00' AND '2022-10-01 00:00:00'
--     AND project_id = 'prod-137'
    GROUP BY project_id, month
)
WHERE users > 100
ORDER BY project_id, month
;






-- Events by user with expanded intents
SELECT timestamp, user_id, type, incoming, intents, not fully_marked as prochee,
       dictGetOrDefault('intents_dict', 'name', toUInt64(splitByChar('-', intents)[2]), '') AS intent_name,
       text
FROM events_parsed
ARRAY JOIN intents
WHERE user_id = '104605799' and timestamp > '2022-09-10 00:00:00'
AND (( incoming = 1 AND meta !='{}') OR (incoming = 0))
ORDER BY ts_ms
;


-- Events by user
SELECT
    *
FROM events_parsed
WHERE
    project_id = 'prod-303'
    AND (( incoming = 1 AND meta !='{}') OR (incoming = 0))
    AND timestamp BETWEEN '2022-10-14 00:00:00' AND '2022-10-30 00:00:00'
    AND user_id = '123123123123123'
-- ORDER BY user_id, timestamp ASC
;






SELECT
*
--     timestamp,
--     user_id,
--     project_id,
--     type,
--        incoming,
--        text,
--        intents,
--        fact_keys,
--        facts
FROM events_parsed
WHERE
    timestamp between '2022-08-24 10:15:00' AND '2022-11-24 10:16:00'
    and project_id = 'prod-316'
--     and user_id = '56875'
    and text like '%мы уже передаём его курьеру. Доставим к%'
--     AND timestamp > toStartOfYear(now())
ORDER BY ts_ms
;



SELECT
    toStartOfMonth(timestamp) as month,
    uniqExact(user_id)
FROM events_parsed
WHERE
--     timestamp > toStartOfYear(now())
    project_id in ('prod-258', 'prod-365', 'prod-428', 'prod-502')
GROUP BY month
ORDER BY month






SELECT *
FROM events_parsed
WHERE project_id = 'prod-405'
and timestamp > toStartOfDay(now())
;


