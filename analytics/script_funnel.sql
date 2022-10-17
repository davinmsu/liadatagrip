DROP TABLE temp.trigger_intents_131;

CREATE TABLE temp.trigger_intents_131
            (id integer, intent_name String, script_name String, group_name String, active String)
ENGINE=URL('http://192.168.0.13:8080/trigger_intents_131.csv', CSV);




SELECT
    intent_name, script_name, id
FROM default.intents_history
INNER JOIN temp.trigger_intents_131
ON temp.trigger_intents_131.intent_name = default.intents_history.name
WHERE
    temp.trigger_intents_131.active = 'ACTIVE'
    AND default.intents_history.project_id = 131
    --     Надо учесть поле intents_history.is_active
ORDER BY timestamp DESC
LIMIT 1 BY id
;





SELECT
    timestamp, ts_ms, user_id,
    type, text, incoming, meta, JSONExtractString(meta, 'reaction') as reaction
FROM events_parsed
WHERE
    project_id = 'prod-131'
    AND reaction = ''
    AND incoming = 0
    AND ((incoming = 1 AND meta != '{}') OR (incoming = 0))
    AND timestamp BETWEEN '2022-10-17 11:00:00' AND '2022-11-02 00:00:00'
ORDER BY user_id, ts_ms
LIMIT 1 BY text