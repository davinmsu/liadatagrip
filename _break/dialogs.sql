WITH
    'prod-303' as required_project_id,
    timestamp between '2023-03-12 14:30:00' and '2023-03-12 17:30:00' as required_time_clause,
--     (date_trunc('day', timestamp) == '2022-11-29') as required_time_clause,
    user_filter_clause as (
        SELECT user_id
        FROM events_parsed
        WHERE project_id = required_project_id
          AND required_time_clause

    )
SELECT concat(
               '_________________________\n', 'user: ', user_id, '\n',
               arrayStringConcat(gr, '\n'), '\n'
           ) as user
FROM (SELECT groupArray(
                     concat(
                             formatDateTime(timestamp, '%F %T') as datetime, ' ',
                             if(incoming, 'user', 'lia') as who, ' ',
                             arrayStringConcat(intents, ', ') as intents,
                             ' | ',
                             arrayStringConcat(intent_names, ', ') as intent_names,
                             if(not incoming, concat('reaction: ', toString(reaction)), ''),
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
