SELECT
    DISTINCT user_id
FROM events_parsed
WHERE
    project_id = 'prod-303'
    AND toDate(timestamp) >= '2022-11-22'
    AND user_id != '1381598'
    AND text = '/опросОП'
ORDER BY ts_ms
;

-- 1381528
-- 1381988
-- 1381771
-- 1381187
-- 1382004
-- 1382031
-- 1378271
-- 1382355
-- 1382404
-- 1382267
-- 1379728


SELECT
    *
FROM events_parsed
WHERE
    project_id = 'prod-303'
    AND toDate(timestamp) >= '2022-11-22'
    AND user_id = '1381528'
ORDER BY ts_ms
;

