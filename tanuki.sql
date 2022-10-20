WITH
(
    project_id = 'prod-131'
    AND timestamp BETWEEN '2022-10-10 00:00:00' AND '2022-10-20 10:17:00'
    AND (( incoming = 1 AND meta !='{}') OR (incoming = 0))
) as clause,
'"Примите извинения за доставленные неудобства! Ожидайте в течение 15 минут. Все последующие Ваши заказы, ресторан будет дополнительно контролировать, при передаче на доставку. В качестве извинений и компенсации на Ваш бонусный счёт будут начислены 300 бонусных баллов."'
as sorry_text

SELECT
    order_number,
    phone,
    '' as status,
    '300' as bonus,
    timestamp
FROM
(
SELECT
       timestamp, ts_ms,
       user_id,
     JSONExtractString(JSONExtractRaw(JSONExtractRaw(JSONExtractRaw(meta, 'entities'), 'order_number')),
                       'str')                                                                            as order_number,
     JSONExtractString(JSONExtractRaw(JSONExtractRaw(JSONExtractRaw(meta, 'entities'), 'phone')),
                       'str')                                                                            as phone,
     if(order_number != '', order_number, phone)                                                         as pp
FROM events_parsed
WHERE clause
    AND order_number != ''
ORDER BY ts_ms DESC
LIMIT 1 BY timestamp
) as t1
JOIN
(
SELECT
    user_id
FROM events_parsed
WHERE text = sorry_text
  AND clause
ORDER BY ts_ms
) as t2
ON t1.user_id = t2.user_id
order by ts_ms
;



SELECT
    *
FROM events_parsed
WHERE
      text = '"Примите извинения за доставленные неудобства! Ожидайте в течение 15 минут. Все последующие Ваши заказы, ресторан будет дополнительно контролировать, при передаче на доставку. В качестве извинений и компенсации на Ваш бонусный счёт будут начислены 300 бонусных баллов."'
      AND project_id = 'prod-131'
      AND ((incoming = 1 AND meta != '{}') OR (incoming = 0))
      AND timestamp BETWEEN '2022-10-10 00:00:00' AND '2022-10-18 10:17:00'
;



"27302bd7-2fa2-4bd5-9d24-0e881ed65a3c"

SELECT
    *
FROM events_parsed
WHERE
  user_id in ('622957', '622967', '622977', '622983', '623012', '623017',
    '623035', '623072', '623074', '623137', '623316',
    '623283', '623280', '623261', '623258', '623223', '623554')
  AND project_id = 'prod-131'
  AND ((incoming = 1 AND meta != '{}') OR (incoming = 0))
  AND timestamp BETWEEN '2022-10-17 00:00:00' AND '2022-10-18 10:17:00'
ORDER BY user_id, ts_ms
;







SELECT
--     *
    timestamp, user_id, type, incoming, text
FROM events_parsed
WHERE
    text like '%Рады были помочь%'
    AND project_id = 'prod-131'
    AND (( incoming = 1 AND meta !='{}') OR (incoming = 0))
    AND timestamp BETWEEN '2022-10-17 00:00:00' AND '2022-10-18 10:17:00'
ORDER BY ts_ms
;




    user_id in ('622957', '622967', '622977', '622983', '623012', '623017',
    '623035', '623072', '623074', '623137', '623316',
    '623283', '623280', '623261', '623258', '623223', '623554')