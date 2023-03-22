SELECT
    user_id,
    count() as cnt
        FROM (
                 SELECT timestamp as ts,
                        user_id   as user,
                        incoming  as inc,
                        text      as txt,
                        *
                 FROM events_parsed
                 WHERE project_id = 'prod-344'
                   AND toDate(timestamp) = '2022-08-15'
                   AND text like '%же передала вопрос в поддержку%'
                 ORDER BY user_id, ts_ms
                 )
GROUP BY user_id
ORDER BY cnt DESC
;



SELECT toTimeZone(timestamp, 'Europe/Moscow') as ts,
                        if(incoming, 'user', 'bot')  as from,
                        text      as txt
                 FROM events_parsed
                 WHERE project_id = 'prod-344'
                   AND toDate(timestamp) = '2022-08-15'
                   AND user_id = '221907449'
                 ORDER BY user_id, ts_ms