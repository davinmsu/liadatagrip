-- Диалоги, в которых старт не первый, но идет через 5 сек и менее после старта
SELECT
    user_id,
    min(timestamp) as first_event,
    minIf(timestamp, type = 'start') as first_start,
    first_start - first_event as timedelta
FROM
(
    SELECT *
    from events_parsed
    WHERE project_id = 'prod-405'
      AND toDate(timestamp) >= '2022-10-01'
    ORDER BY user_id, ts_ms
)
GROUP BY user_id
HAVING
    timedelta < 60
    AND timedelta > 0
;






-- Fast Dialogs with late starts
WITH
    'prod-405' as required_project_id,
    (date_trunc('month', timestamp) >= '2022-06-01') as required_time_clause,
    user_filter_clause as (
        SELECT user_id
            FROM
        (
        SELECT user_id,
               min(timestamp)                   as first_event,
               minIf(timestamp, type = 'start') as first_start,
               first_start - first_event        as timedelta
        FROM (
              SELECT *
              from events_parsed
              WHERE project_id = 'prod-405'
                AND required_time_clause
              ORDER BY user_id, ts_ms
                 )
        GROUP BY user_id
        HAVING timedelta < 5
           AND timedelta > 0
    )
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

