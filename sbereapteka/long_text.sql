SELECT
    user_id,
    lengthUTF8(replaceAll(text, ' ', '')) as len1,
    length(text),
    intents,
    timestamp,
    text

FROM events_parsed
WHERE project_id ='prod-336'
    AND toDate(timestamp) >= '2022-12-07'
    AND incoming = 1
    AND len1 >= 200
ORDER BY ts_ms DESC
;


SELECT
    *
FROM events_parsed
WHERE project_id ='prod-336'
    AND type = 'intent'
    AND toDate(timestamp) >= '2023-02-01'
ORDER BY ts_ms
LIMIT 1000
;


SELECT
    incoming, text,
    *
FROM events_parsed
WHERE project_id ='prod-336'
    AND user_id = '402485'
--     AND toDate(timestamp) >= '2022-12-07'
--     AND incoming = 1
--     AND length(text) >= 200
ORDER BY ts_ms
;


-- 356464
-- 568071
-- 543838

