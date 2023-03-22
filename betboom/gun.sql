SELECT
    user_id,
    text,
    intents
FROM events_parsed
WHERE
    project_id = 'prod-544'
    AND incoming = 1
    AND user_id like 'test4-%'
ORDER BY ts_ms DESC
LIMIT 1000


SELECT
    fully_marked,
    intents
FROM events_parsed
WHERE
    project_id = 'prod-544'
    AND incoming = 1
    AND user_id like 'test4-%'
ORDER BY ts_ms DESC
LIMIT 1000


SELECT
    intent,
    count() as cnt,
    dictGetOrDefault('intents_dict', 'name', toUInt64OrZero(splitByChar('-', intent)[2]), '') as intent_name
FROM events_parsed
array join intents as intent
WHERE
    project_id = 'prod-544'
    AND incoming = 1
    AND user_id like 'test4-%'
GROUP BY intent
ORDER BY cnt  DESC



SELECT
    fully_marked,
    text,
    intents,
    arrayMap(x -> (dictGetOrDefault('intents_dict', 'name', toUInt64OrZero(splitByChar('-', x)[2]), '')), intents) as intent_names
FROM events_parsed
WHERE
    project_id = 'prod-544'
    AND incoming = 1
    AND user_id like 'test4-%'
