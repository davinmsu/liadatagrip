WITH
['intent-12839','intent-18130','intent-130152',
    'intent-14444','intent-12965','intent-19600','intent-15889',
    'intent-18128','intent-12129'] as wanted_intents,
'2022-10-26 18:40:00' as start_time

SELECT
        timestamp,
       user_id,
       type,
       incoming,
       text,
       intents,
       arrayMap(x -> (dictGetOrDefault('intents_dict', 'name', toUInt64(splitByChar('-', x)[2]), '')), intents) as intent_names,
       reaction,
       JSONExtractRaw(facts, 'user_token') as user_token,
       facts
FROM events_parsed
WHERE
    user_id in (
        SELECT user_id
FROM events_parsed
WHERE
    project_id = 'prod-316'
    AND timestamp > start_time
    AND hasAny(wanted_intents, intents)
        )
    AND timestamp > start_time
ORDER BY user_id, ts_ms


