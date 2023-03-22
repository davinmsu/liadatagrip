SELECT
    DISTINCT user_id
FROM events_parsed
WHERE
    project_id = 'prod-131'
    AND toDate(timestamp) >= '2022-12-12'
    AND reaction = '27302bd7-2fa2-4bd5-9d24-0e881ed65a3c'
;

-- Dialogs reactions
WITH
    'prod-131' as required_project_id,
    (date_trunc('day', timestamp) == '2022-12-01') as required_time_clause,
    user_filter_clause as (
    SELECT
        DISTINCT user_id
    FROM events_parsed
    WHERE
        project_id = required_project_id
        AND required_time_clause
        AND reaction = '27302bd7-2fa2-4bd5-9d24-0e881ed65a3c'
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
