SELECT
    timestamp,
    user_id,
    text,
    n_text,
    n2_text
FROM (
         SELECT timestamp,
                ts_ms,
                user_id,
                incoming,
                text,
                intents,
                neighbor(text, 1)     as n_text,
                neighbor(text, 2)     as n2_text,
                neighbor(incoming, 1) as n_incoming,
                neighbor(ts_ms, 1)    as n_ts_ms,
                neighbor(user_id, 1)  as n_user_id,
                neighbor(user_id, 2)     as n2_user_id
         FROM events_parsed
         WHERE project_id = 'prod-428'
           AND toDate(timestamp) >= '2023-04-01'
         ORDER BY ts_ms
         )
WHERE
    n_user_id = user_id
    AND n2_user_id = n_user_id
    AND intents = ['intent-41303']


