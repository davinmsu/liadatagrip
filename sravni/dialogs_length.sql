-- - **Средняя длительность диалога бота с пользователем**
--
-- Тут имеется в виду среднее количество реплик в диалоге (за сколько реплик в среднем у бота получается помочь человеку). Нужна соответствующая выгрузка.
--
-- -сделать выгрузку всех диалогов, которые закончились без терминейтов
-- -сделать выгрузку диалогов, которые закончились терминейтами
-- -посмотреть, когда начинались / когда заканчивались и те, и другие
--
-- -посчитать среднее количество минут, за которое происходил диалог. в случаях без терминейтов считать диалог завершенным, если перед следующим сообщением прошло не менее 24 часов
--
-- -посчитать среднее количество реплик пользователя. в случаях без терминейтов считать диалог завершенным, если перед следующим сообщением прошло не менее 24 часов
--
-- -исключить: диалоги, где не было ничего распознанного (fm=0)
--
-- Дополнительно: отдать данные самого долгого / самого быстрого диалога
-- Также диалога с наибольшим количеством сообщений / наименьшим количеством сообщений
--
-- период – 14 февраля 2023 - 14 марта 2023

SELECT
    *
FROM events_parsed
WHERE
    project_id = 'prod-279'
    AND toDate(timestamp) BETWEEN '2023-02-14' AND '2023-03-14'
ORDER BY user_id, ts_ms
LIMIT 1000
;

-- Длительность диалогов
SELECT
    user_id,
    round((max(ts_ms)-min(ts_ms))/1000/60/60) as len_hours
FROM events_parsed
WHERE project_id = 'prod-279'
    AND toDate(timestamp) BETWEEN '2023-02-14' AND '2023-03-14'
GROUP BY user_id
ORDER BY len_hours DESC
LIMIT 1000
;

-- Количество диалогов
SELECT
    uniqExact(user_id)
FROM events_parsed
WHERE project_id = 'prod-279'
    AND toDate(timestamp) BETWEEN '2023-02-14' AND '2023-03-14'
LIMIT 1000
;




-- Диалоги где не было ничего распознанного
SELECT count()
FROM (
         SELECT user_id
         FROM events_parsed
         WHERE project_id = 'prod-279'
           AND toDate(timestamp) BETWEEN '2023-02-14' AND '2023-03-14'
           AND incoming = 1
           AND type = 'text'
         GROUP BY user_id
         HAVING sum(fully_marked) = 0
         )
;



-- Количество терминейтов в диалогах
WITH
    excluded_dialogs as (
         SELECT user_id
         FROM events_parsed
         WHERE project_id = 'prod-279'
           AND toDate(timestamp) BETWEEN '2023-02-14' AND '2023-03-14'
           AND incoming = 1
           AND type = 'text'
         GROUP BY user_id
         HAVING sum(fully_marked) = 0
         )
SELECT
    n_terminates,
    count() as cnt
FROM
(SELECT user_id,
        countIf(type = 'terminate') as n_terminates
 FROM events_parsed
 WHERE project_id = 'prod-279'
   AND user_id not in excluded_dialogs
   AND toDate(timestamp) BETWEEN '2023-02-14' AND '2023-03-14'
 GROUP BY user_id)
GROUP BY n_terminates
ORDER BY n_terminates DESC
;



-- Диалоги, которые закончились без терминейтов
SELECT
    user_id
FROM events_parsed
WHERE project_id = 'prod-279'
    AND toDate(timestamp) BETWEEN '2023-02-14' AND '2023-03-14'
GROUP BY user_id
HAVING (any(type) = 'terminate') = 0
;


-- Диалоги с x терминейтами
SELECT
    user_id
FROM events_parsed
WHERE project_id = 'prod-279'
    AND toDate(timestamp) BETWEEN '2023-02-14' AND '2023-03-14'
GROUP BY user_id
HAVING countIf(type = 'terminate') = 0
;


-- среднее и медианное время, за которое происходил диалог
SELECT
    avg(len_s),
    median(len_s),
    min(len_s),
    max(len_s)
FROM (
         SELECT user_id,
                (max(ts_ms) - min(ts_ms)) / 1000 as len_s
         FROM events_parsed
         WHERE project_id = 'prod-279'
           AND toDate(timestamp) BETWEEN '2023-02-14' AND '2023-03-14'
         GROUP BY user_id
         )
;



-- Количество реплик пользователя
WITH
    excluded_dialogs as (
                 SELECT user_id
         FROM events_parsed
         WHERE project_id = 'prod-279'
           AND toDate(timestamp) BETWEEN '2023-02-14' AND '2023-03-14'
           AND incoming = 1
           AND type = 'text'
         GROUP BY user_id
         HAVING sum(fully_marked) = 0
    )
SELECT
    cnt_usermessages,
    count() as cnt_dialogs
FROM (
         SELECT user_id,
                count() as cnt_usermessages
         FROM events_parsed
         WHERE project_id = 'prod-279'
           AND toDate(timestamp) BETWEEN '2023-02-14' AND '2023-03-14'
           AND incoming = 1
           AND type = 'text'
            AND user_id not in excluded_dialogs
         GROUP BY user_id
         )
GROUP BY cnt_usermessages
ORDER BY cnt_usermessages DESC
;



-- Диалоги с количеством реплик пользователя = 1
WITH
    excluded_dialogs as (
                 SELECT user_id
         FROM events_parsed
         WHERE project_id = 'prod-279'
           AND toDate(timestamp) BETWEEN '2023-02-14' AND '2023-03-14'
           AND incoming = 1
           AND type = 'text'
         GROUP BY user_id
         HAVING sum(fully_marked) = 0
    )
SELECT
    user_id
FROM events_parsed
WHERE project_id = 'prod-279'
    AND toDate(timestamp) BETWEEN '2023-02-14' AND '2023-03-14'
    AND incoming = 1
    AND type = 'text'
    AND user_id not in excluded_dialogs
GROUP BY user_id
HAVING count() = 1
;




-- Выгрузка диалогов в читаемом виде
WITH
    'prod-279' as required_project_id,
    (toDate(timestamp) BETWEEN '2023-02-14' AND '2023-03-14') as required_time_clause,
    user_filter_clause as (
        SELECT
            user_id
        FROM events_parsed
        WHERE project_id = 'prod-279'
            AND toDate(timestamp) BETWEEN '2023-02-14' AND '2023-03-14'
            AND incoming = 1
            AND type = 'text'
        GROUP BY user_id
        HAVING count()  = 1
    ),
    excluded_dialogs as (
         SELECT user_id
         FROM events_parsed
         WHERE project_id = required_project_id
           AND required_time_clause
           AND incoming = 1
           AND type = 'text'
         GROUP BY user_id
         HAVING sum(fully_marked) = 0
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
                   arrayMap(x -> (dictGetOrDefault('intents_dict', 'name', toUInt64OrZero(splitByChar('-', x)[2]), '')),
                            intents) as intent_names
            FROM events_parsed
            WHERE project_id = required_project_id
              AND required_time_clause
              AND user_id in user_filter_clause
              AND user_id not in excluded_dialogs
            ORDER BY user_id, ts_ns
               )
      GROUP BY user_id
         )
;


-- Образец сырых данных за период

SELECT
    *
FROM events_parsed
WHERE project_id = 'prod-279'
    AND toDate(timestamp) BETWEEN '2023-02-14' AND '2023-03-14'
;