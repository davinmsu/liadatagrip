-- диалоги, в которых в одном сообщении пользователя было больше одного интента?


SELECT
    *
FROM events_parsed
WHERE user_id in   (
    SELECT user_id
        FROM
    (
        SELECT user_id,
               length(intents) as intent_len
        FROM events_parsed
        WHERE project_id = 'prod-405'
          AND date_trunc('month', timestamp) == '2022-10-01'
          AND intent_len > 1
    )
    )

;


-- Fast Dialogs with more then 1 intent in any message
WITH
    'prod-405' as required_project_id,
    (date_trunc('month', timestamp) == '2022-10-01') as required_time_clause,
    user_filter_clause as (
        SELECT user_id
        FROM events_parsed
        WHERE project_id = required_project_id
          AND required_time_clause
          AND length(intents) > 1

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

SELECT toUInt64(splitByChar('-', 'sys.start')[2]);
SELECT toUInt64('');


SELECT 1, 2, 3;
SELECT 1, 2, [3,4,5] FORMAT Vertical;
