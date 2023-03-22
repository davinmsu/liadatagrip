SELECT
     *
 FROM events_parsed
 WHERE project_id = 'prod-316'
    AND toDate(timestamp) > '2022-12-01'
    AND text like '%Подарок%'
    AND incoming = 0
--     AND reaction in ('977cd92a-b47c-44b3-a2e8-8258c2675296', 'fa3657c8-b9c9-48f8-b552-860cbf2300c5')
 LIMIT 1000

;


WITH
    'prod-316' as required_project_id,
    (date_trunc('month', timestamp) == '2022-12-01') as required_time_clause,
    user_filter_clause as (
        SELECT
     DISTINCT user_id
 FROM events_parsed
 WHERE project_id = required_project_id
   AND required_time_clause
    AND text like '%Подарок%'
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






-- 977cd92a-b47c-44b3-a2e8-8258c2675296
-- fa3657c8-b9c9-48f8-b552-860cbf2300c5


{"jivo_event": "CLIENT_MESSAGE", "jivo_client_id": "870182", "user_token": "990564"}

{"jivo_event": "CLIENT_MESSAGE", "jivo_client_id": "643967", "user_token": "60106"}













WITH users as
     (  SELECT user_id FROM
             (SELECT groupArray(JSONExtractString(facts, 'user_token')) as user_token,
                    user_id,
                    has(user_token, '')                                as has_empty_tokens,
                    arrayUniq(user_token) - has_empty_tokens           as uniq
             FROM events_parsed
             WHERE project_id = 'prod-316'
               AND toDate(timestamp) > '2022-12-01'
               AND incoming = 1

             GROUP BY user_id
             HAVING has_empty_tokens
             ))
SELECT
    DISTINCT JSONExtractString(facts, 'channel_id')
FROM events_parsed
WHERE
    project_id = 'prod-316'
    AND toDate(timestamp) > '2022-12-01'
    AND user_id not in users
;

SELECT user_id FROM (
                        SELECT groupArray(JSONExtractString(facts, 'user_token')) as user_token,
                               user_id,
                               has(user_token, '')                                as has_empty_tokens,
                               arrayUniq(user_token) - has_empty_tokens           as uniq
                        FROM events_parsed
                        WHERE project_id = 'prod-316'
                          AND toDate(timestamp) > '2022-12-01'
                          AND incoming = 1

                        GROUP BY user_id
                        HAVING has_empty_tokens
                        )
;


SELECT
    DISTINCT JSONExtractString(facts, 'channel_id') as chid
             FROM events_parsed
             WHERE project_id = 'prod-316'
               AND toDate(timestamp) > '2022-12-01'
;