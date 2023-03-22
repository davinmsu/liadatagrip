-- Было

WITH t1 as (SELECT dateTrunc('month', timestamp) as month,
                   user_id,
                   ntext
            FROM (
                     SELECT timestamp,
                            reaction,
                            user_id,
                            text,
                            neighbor(text, 1)    as ntext,
                            neighbor(user_id, 1) as nuser
                     FROM events_parsed
                     WHERE project_id = 'prod-279'
                       AND dateTrunc('year', timestamp) = '2022-01-01'
                     ORDER BY user_id, ts_ns
                     )
            WHERE user_id = nuser
              AND reaction = '4bb23d6c-c1d0-4ed5-86d4-02a95bf453dd'),
     t2 as (SELECT dateTrunc('month', timestamp) as month,
                   user_id,
                   ntext
            FROM (
                     SELECT timestamp,
                            reaction,
                            user_id,
                            text,
                            neighbor(text, 1)    as ntext,
                            neighbor(user_id, 1) as nuser
                     FROM events_parsed
                     WHERE project_id = 'prod-279'
                       AND dateTrunc('year', timestamp) = '2022-01-01'
                     ORDER BY user_id, ts_ns
                     )
            WHERE user_id = nuser
              AND reaction = '14e512ac-377d-4192-9b76-cb9815442bbc')
SELECT t1.month   as month,
       t1.user_id as user_id,
       t1.ntext   as a1,
       t2.ntext   as a2
FROM t1
         LEFT JOIN t2 ON t1.user_id = t2.user_id
;



-- Стало

WITH shift_table as (
    SELECT *,
        neighbor(text, 1)    as ntext,
        neighbor(user_id, 1) as nuser
         FROM (
             SELECT *
             FROM events_parsed
             WHERE project_id = 'prod-279'
             AND dateTrunc('year', timestamp) = '2022-01-01'
             ORDER BY user_id, ts_ns
              )
),
t1 as (
    SELECT *,
        dateTrunc('month', timestamp) as month
    FROM shift_table
    WHERE user_id = nuser
    AND reaction = '4bb23d6c-c1d0-4ed5-86d4-02a95bf453dd'
),
t2 as (
    SELECT *,
        dateTrunc('month', timestamp) as month
    FROM shift_table
    WHERE user_id = nuser
    AND reaction = '14e512ac-377d-4192-9b76-cb9815442bbc'
)
SELECT t1.month   as month,
       t1.user_id as user_id,
       t1.ntext   as a1,
       t2.ntext   as a2
FROM t1
         LEFT JOIN t2 ON t1.user_id = t2.user_id
;



-- Стало 2

WITH shift_table as (
    SELECT *,
        neighbor(text, 1)    as ntext,
        neighbor(user_id, 1) as nuser
         FROM (
             SELECT *
             FROM events_parsed
             WHERE project_id = 'prod-279'
             AND dateTrunc('year', timestamp) = '2022-01-01'
             ORDER BY user_id, ts_ns
              )
),
t1 as (
    SELECT *,
        dateTrunc('month', timestamp) as month
    FROM shift_table
    WHERE user_id = nuser
    AND reaction = '4bb23d6c-c1d0-4ed5-86d4-02a95bf453dd'
),
t2 as (
    SELECT *,
        dateTrunc('month', timestamp) as month
    FROM shift_table
    WHERE user_id = nuser
    AND reaction = '14e512ac-377d-4192-9b76-cb9815442bbc'
)
SELECT t1.month   as month,
       t1.user_id as user_id,
       t1.ntext   as a1,
       t2.ntext   as a2
FROM t1
         LEFT JOIN t2 ON t1.user_id = t2.user_id
;





-- Это все эксперименты

SELECT dateTrunc('month', timestamp) as month,
       reaction,
       user_id,
       text,
       ntext
FROM (
         SELECT timestamp,
                reaction,
                user_id,
                text,
                neighbor(text, 1)    as ntext,
                neighbor(user_id, 1) as nuser
         FROM events_parsed
         WHERE project_id = 'prod-279'
           AND dateTrunc('year', timestamp) = '2022-01-01'
         ORDER BY user_id, ts_ns
         )
WHERE user_id = nuser
  AND reaction in ('4bb23d6c-c1d0-4ed5-86d4-02a95bf453dd', '14e512ac-377d-4192-9b76-cb9815442bbc')
;



SELECT timestamp,
        reaction,
        user_id,
        text,
        neighbor(text, 1)    as ntext,
        neighbor(user_id, 1) as nuser
 FROM events_parsed
 WHERE project_id = 'prod-279'
   AND dateTrunc('day', timestamp) = '2022-06-01'
 ORDER BY user_id, ts_ns
;




SELECT *
FROM events_parsed
WHERE project_id = 'prod-279'
  AND dateTrunc('day', timestamp) >= '2022-01-01'
  AND reaction = '14e512ac-377d-4192-9b76-cb9815442bbc'
-- ORDER BY ts_ms
LIMIT 100
;


-- '4bb23d6c-c1d0-4ed5-86d4-02a95bf453dd'
-- Выберите, пожалуйста, цифру, которая соответствует вашему запросу на внесение изменений:
-- 1 - Гос. номер авто
-- 2 - Добавить водителя
-- 3 - Данные собственника/водителя (паспорт)
-- 4 - ВУ
-- 5 - Не тот собственник
-- 6 - Данные ПТС/СТС
-- 7 - Марка/модель авто
-- 8 - Добавить прицеп
-- 9 - Указать вин и кузов
-- 10 - ДНД
-- 11 - Убрать водителя


-- '14e512ac-377d-4192-9b76-cb9815442bbc'
-- И выберите цифру, которая соответствует вашей страховой компании:
-- 1 - Росгосстрах
-- 2 - Альфа Страхование
-- 3 - СОГАЗ
-- 4 - Согласие
-- 5 - Ренессанс
-- 6 - МАКС
-- 7 - Абсолют
-- 8 - Ингосстрах
-- 9 - Зетта
-- 10 - ОСК
-- 11 - ВСК
-- 12 - Совкомбанк Страхование
-- 13 - Мафин
-- 14 - Тинькоффстрахование
-- 15 - Югория
-- 16 - СберСтрахование
-- 17 - Гелиос
-- 18 - Спасские Ворота
-- 19 - Энергогарант