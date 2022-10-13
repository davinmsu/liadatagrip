-- Запрос без корректировки на пользователя
SELECT
    sum(has_cancel) as count_has_cancel,
    sum(has_get_order_status) as count_has_order,
    sum(neighbor(has_yes, 1, 0)*has_cancel) as count_has_cancel_yes,
    sum(neighbor(has_no, 1, 0)*has_cancel) as count_has_cancel_no,
    sum(neighbor(has_yes, 1, 0)*has_get_order_status) as count_has_order_yes,
    sum(neighbor(has_no, 1, 0)*has_get_order_status) as count_has_order_no
FROM
(
    SELECT
        has(intents, 'intent-14789') as has_cancel,
        has(intents, 'intent-14803') as has_get_order_status,
        has(intents, 'intent-14801') as has_yes,
        has(intents, 'intent-14788') as has_no
    FROM events_parsed
    WHERE project_id = 'prod-336'
        AND ts_ns >= 1663113943170631936
        AND ts_ns <= 1663248551338291200
        AND incoming = 1
        AND (( incoming = 1 AND meta !='{}') OR (incoming = 0))
    ORDER BY user_id, ts_ns
)
;


-- Запрос с корректировкой на сдвиг пользователя. Корректный, совпадает с Pandas
SELECT
    sum(has_cancel) as count_has_cancel,
    sum(has_get_order_status) as count_has_order,
    sum(neighbor(has_yes, 1, 0)*has_cancel*same_user) as count_has_cancel_yes,
    sum(neighbor(has_no, 1, 0)*has_cancel*same_user) as count_has_cancel_no,
    sum(neighbor(has_yes, 1, 0)*has_get_order_status*same_user) as count_has_order_yes,
    sum(neighbor(has_no, 1, 0)*has_get_order_status*same_user) as count_has_order_no
FROM
(
    SELECT
        user_id = neighbor(user_id, 1, '0') as same_user,
        has(intents, 'intent-14789') as has_cancel,
        has(intents, 'intent-14803') as has_get_order_status,
        has(intents, 'intent-14801') as has_yes,
        has(intents, 'intent-14788') as has_no
    FROM
    (
        SELECT user_id,
               intents
        FROM events_parsed
        WHERE project_id = 'prod-336'
          AND ts_ns BETWEEN 1663113943170631936 AND 1663248551338291200
          AND incoming = 1
          AND meta != '{}'
        ORDER BY user_id, ts_ns
    )
)
;


SELECT project_id, uniqExact(user_id)
FROM events_parsed
WHERE project_id in ('prod-188', 'prod-189', 'prod-363', 'prod-364')
      AND timestamp between '2022-09-01 00:00:00' and '2022-10-01 00:00:00'
GROUP BY project_id
;

