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









SELECT * FROM events_parsed
where project_id = 'prod-131' and user_id = '541595'



SELECT uniqExact(user_id), project_id
FROM events_parsed
WHERE
      timestamp between '2022-08-01 00:00:00' and '2022-09-01 00:00:00'
GROUP BY project_id;




SELECT uniqExact(user_id) as chats, uniqExact(JSONExtractString(JSONExtractRaw(facts, 'session'), 'id')) as sessions
from events_parsed
WHERE
      (timestamp between '2022-08-01 00:00:00' and '2022-09-01 00:00:00')
      and project_id = 'prod-336'
LIMIT 1000





SELECT DISTINCT arrayJoin(fact_keys) from events_parsed
WHERE
      (timestamp between '2022-08-20 00:00:00' and '2022-09-22 00:00:00')
      and project_id = 'prod-336'
LIMIT 1000



SELECT length(text), text, intents from events_parsed
WHERE
      (timestamp between '2022-08-20 00:00:00' and '2022-08-22 00:00:00')
      and project_id = 'prod-336'
        and fully_marked = 0
LIMIT 1000


SELECT text, timestamp, project_id from events_parsed
WHERE text like '%икак не оплатить заказ картой ми%';



SELECT JSONExtractString(params, 'text'), visitParamExtractRaw(meta, 'entities'), intents
FROM events_parsed
WHERE
user_id = 'RG7D52HPJ9';



--     (timestamp between '2022-08-20 00:00:00' and '2022-08-22 00:00:00')
--     and project_id = 'prod-336'


select arrayJoin(splitByString('\\n', text ))
        from events_parsed
        where toDateTime(timestamp, 'Europe/Moscow') BETWEEN '2022-08-10 00:00:00' AND '2022-08-11 00:00:00'
            AND project_id = 'prod-137'
        and incoming = 1
        and LENGTH(intents) = 0
        AND ( (`type` = 'terminate') or ((`type` = 'start') and (fully_marked != -1) ) or (fully_marked != -1)  or (incoming = 0) )
        and text like '%икак не оплатить заказ картой ми%'
        ORDER BY timestamp




SELECT * FROM events_parsed
WHERE project_id = 'prod-137' AND user_id in ('1104893240', '1008479175', '2004855167')
AND (( incoming = 1 AND meta !='{}') OR (incoming = 0))
ORDER BY ts_ms




