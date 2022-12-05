-- диалогов по Олимпу,
-- в которых в течение 10 минут после терминейта было входящее событие от пользователя (старт или сообщение)?
-- За последние сутки

SELECT
    DISTINCT user_id
FROM
(
    SELECT *,
           neighbor(user_id, 1)   as user_id_shift,
           neighbor(type, 1)      as type_shift,
           neighbor(timestamp, 1) as timestamp_shift
    FROM (
          SELECT user_id,
                 type,
                 timestamp
          FROM events_parsed
          WHERE project_id = 'prod-405'
            AND date_trunc('month', timestamp) >= '2022-10-01'
            AND ( (incoming = 1 AND type in ('start', 'text') ) OR type = 'terminate')
            AND type in ('terminate', 'start', 'text')
          ORDER BY user_id, ts_ms
             )
)
WHERE
    user_id = user_id_shift
    AND type = 'terminate'
    AND type_shift != 'terminate'
    AND timestamp_shift - timestamp < 10*60
;

-- 'RKIX4NWA5V'

SELECT
    *
FROM events_parsed
WHERE
    project_id = 'prod-405'
    AND user_id = 'RL91RJVD9W'
;

-- Fast Dialogs with user events after terminate within 10 minutes
WITH
    'prod-405' as required_project_id,
    (date_trunc('month', timestamp) >= '2022-10-01') as required_time_clause,
    user_filter_clause as (

SELECT
    DISTINCT user_id
FROM
(
    SELECT *,
           neighbor(user_id, 1)   as user_id_shift,
           neighbor(type, 1)      as type_shift,
           neighbor(timestamp, 1) as timestamp_shift
    FROM (
          SELECT user_id,
                 type,
                 timestamp
          FROM events_parsed
          WHERE project_id = required_project_id
            AND required_time_clause
            AND ( (incoming = 1 AND type in ('start', 'text') ) OR type = 'terminate')
            AND type in ('terminate', 'start', 'text')
          ORDER BY user_id, ts_ms
             )
)
WHERE
    user_id = user_id_shift
    AND type = 'terminate'
    AND type_shift != 'terminate'
    AND timestamp_shift - timestamp < 10*60

    )
SELECT concat(
               '_________________________\n', 'user: ', user_id, '\n',
               arrayStringConcat(gr, '\n'), '\n'
           ) as user
FROM (SELECT groupArray(
                     concat(
                             formatDateTime(timestamp, '%F %T') as datetime, ' ',
                             if(incoming, 'user', 'lia') as who, ': ',
                             arrayStringConcat(intents, ', ') as intents,
                             ' | ',
                             arrayStringConcat(intent_names, ', ') as intent_names,
                             '\n',
                             if(type = 'text', text, type), '\n'
                         ) as str
                 ) as gr,
             user_id
      FROM (SELECT *,
            arrayMap(x -> (dictGetOrDefault('intents_dict', 'name', toUInt64OrZero(splitByChar('-', x)[2]), '')), intents) as intent_names
            FROM events_parsed
            WHERE project_id = required_project_id
              AND required_time_clause
              AND user_id in user_filter_clause
            ORDER BY user_id, ts_ns
               )
      GROUP BY user_id
         )

;
