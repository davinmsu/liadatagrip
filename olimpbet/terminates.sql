-- расстояние между первым и вторым терминейтом

SELECT

    formatDateTime(timestamp, '%F %T') as datetime,
       user_id,
     if(incoming, 'user', 'lia') as who,
       type,
     arrayStringConcat(intents, ', ') as intents,
     text
--      if(type = 'text', trim(BOTH '"' FROM text), type), '\n'
FROM events_parsed
WHERE user_id in
(SELECT
--        *
user_id
--        quantilesTiming(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.91)(delta_min)
 FROM (
       SELECT *
       FROM (
             SELECT *
                     ,
                    neighbor(ts_ms, 1)                     ts_ms_shifted,
                    neighbor(user_id, 1)                as user_id_shifted,
                    (ts_ms_shifted - ts_ms) / 1000 / 60 as delta_min
             FROM (SELECT timestamp,
                          ts_ms,
                          user_id
                   FROM events_parsed
                   WHERE project_id = 'prod-405'
                     AND type = 'terminate'
                     AND date_trunc('month', timestamp) == '2022-10-01'
                   ORDER BY user_id, ts_ms
                   LIMIT 2 BY user_id
                      )
                )
       WHERE
--     user_id = 'RD3T3TJD8O'
user_id = user_id_shifted
          )
    WHERE delta_min <= 60
)
ORDER BY user_id, ts_ms
;







SELECT
    user_id,
    countIf(type='terminate') as terminate_cnt,
    max(timestamp) - min(timestamp) as ts_diff_seconds
FROM events_parsed
WHERE
    project_id = 'prod-405'
    AND timestamp > toStartOfWeek(now())
GROUP BY user_id
HAVING terminate_cnt > 1
ORDER BY terminate_cnt DESC
;


SELECT numbers(10)
FROM system.numbers
    ;


SELECT
--        quantilesExactExclusive(0.1, 0.15, 0.16, 0.18, 0.2, 0.25, 0.5, 0.75, 0.9, 0.95, 0.99, 0.999)(ts_diff_seconds),
--        quantilesTiming(0.1, 0.15, 0.16, 0.18, 0.2, 0.25, 0.5, 0.75, 0.9, 0.95, 0.99, 0.999)(ts_diff_seconds)
       quantilesTiming(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.91)(ts_diff_seconds)
--        quantilesTiming(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9)(ts_diff_seconds/60)
--        quantilesTiming(0.25, 0.5, 0.75, 0.9, 0.99)(ts_diff_seconds/60)
--        *
FROM (
      SELECT user_id,
             count()                         as terminate_cnt,
             round((max(timestamp) - min(timestamp))/60) as ts_diff_seconds
      FROM events_parsed
      WHERE project_id = 'prod-405'
        AND timestamp > toStartOfMonth(subtractMonths(now(), 1))
        AND type = 'terminate'
      GROUP BY user_id
      HAVING terminate_cnt > 1
      ORDER BY ts_diff_seconds DESC
         )
;

-- -- 8400
-- >0 4400
-- >1 855
-- >2 265
-- >3 100
-- >4 47
-- >5 24
-- >6 13
-- >7 8
-- >8 2


SELECT *
    FROM events_parsed
        WHERE toDate(timestamp) > '2022-10-01'
AND project_id = 'prod-405'
AND text like '%при%'
;




SELECT
--        date_add(1000, now() )
--     now() as n,
--     toTimeZone(n, 'Europe/Moscow'),
--     toTimeZone(n, 'Asia/Tbilisi')
;

SELECT date_add(YEAR, 3, now());

SELECT dateDiff('minute', toDateTime('2018-01-01 22:00:00'), toDateTime('2018-01-02 23:00:00'))


