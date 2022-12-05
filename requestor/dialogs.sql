-- Fast Dialogs NEW CLICK
SELECT concat(
               '_________________________\n', 'user: ', user_id, '\n',
               arrayStringConcat(gr, '\n'), '\n'
           ) as user
FROM (SELECT groupArray(
                     concat(
                             formatDateTime(timestamp, '%F %T') as datetime, ' ',
                             if(incoming, 'user', 'lia') as who, ': ',
                             arrayStringConcat(intents, ', ') as intents,
--                              arrayStringConcat(intent_names, ', ') as intent_names,
                             '\n',-- Заменить на имена
                             if(type = 'text', text, type), '\n'
                         ) as str
                 ) as gr,
             user_id
      FROM (SELECT *
--                    arrayMap((x) -> concat(x, ': ', dictGetOrDefault('intents_dict', 'name', toUInt64(splitByChar('-', x)[2]), '')), intents) as intent_names
            FROM events_parsed
            WHERE project_id = 'prod-111'
              AND timestamp BETWEEN '2022-09-01 00:00:00' AND '2022-09-01 05:00:00'
            ORDER BY user_id, ts_ns
               )
      GROUP BY user_id
         )
;













-- Fast Dialogs
SELECT concat(
               '_________________________\n', 'user: ', user_id, '\n',
               arrayStringConcat(gr, '\n'), '\n'
           ) as user
FROM (SELECT groupArray(
                     concat(
                             formatDateTime(timestamp, '%F %T') as datetime, ' ',
                             if(incoming, 'user', 'lia') as who, ': ',
                             arrayStringConcat(intents, ', ') as intents, '\n',-- Заменить на имена
                             if(type = 'text', trim(BOTH '"' FROM text), type), '\n'
                         ) as str
                 ) as gr,
             user_id
      FROM (SELECT *
            FROM events_parsed
            WHERE project_id = 'prod-111'
              AND ((incoming = 1 AND meta != '{}') OR (incoming = 0))
              AND timestamp BETWEEN '2022-09-01 00:00:00' AND '2022-09-02 00:00:00'
            ORDER BY user_id, ts_ns
               )
      GROUP BY user_id
         )
;