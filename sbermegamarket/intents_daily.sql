WITH
(
    'sys.start',
    'intent-34518'

    ) as system_intents
SELECT date, intent_name, count(intent_name) as events_count
FROM (
    SELECT toDate(timestamp, 'Europe/Moscow') as date,
           arrayJoin(intents) as intent,
           splitByChar('-', intent)[1] as intent_type,
           toUInt64OrZero(splitByChar('-', intent)[2]) as intent_id,
           multiIf(
               like(intent, 'sys.%'), intent,
               intent_type = 'intent', dictGetOrDefault('intents_dict', 'name', intent_id, 'UNKNOWN'),
               intent_type = 'qa', dictGetOrDefault('qa_dict', 'name', intent_id, 'UNKNOWN'),
               'INVALID_INTENT_TYPE'
           ) as intent_name
    FROM events_parsed
    WHERE toDateTime(timestamp, 'Europe/Moscow') >= toStartOfMonth(now(), 'Europe/Moscow')
        AND toDateTime(timestamp, 'Europe/Moscow') < toDateTime(now(), 'Europe/Moscow')
        AND project_id = 'prod-111'
        AND intent not in system_intents
    ORDER BY ts_ns DESC
    LIMIT 1 BY event_id
)
GROUP BY date, intent_name
HAVING events_count > 100
ORDER BY date, events_count DESC