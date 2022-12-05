-- 1) диалоги, в которых в течение 10 минут после терминейта было входящее событие от пользователя (старт или сообщение),

SELECT
    date_trunc('day', timestamp) as time,
    count(user_id) as cnt
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
GROUP BY time
ORDER BY time
;



-- 2) диалоги, в которых в течение 10 минут после терминейта был еще один терминейт,


SELECT *,
       neighbor(user_id, 1)   as user_id_shift,
       neighbor(timestamp, 1) as timestamp_shift
FROM (
      SELECT user_id,
             timestamp
      FROM events_parsed
      WHERE project_id = 'prod-405'
        AND date_trunc('month', timestamp) >= '2022-10-01'
        AND type = 'terminate'
      ORDER BY user_id, ts_ms
     )








-- 2) диалоги, в которых в пределах 20 минут было 3 и больше терминейтов.