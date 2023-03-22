SELECT
    dateTrunc('minute', timestamp) as tf,
    count(event_id)
FROM events_parsed
WHERE
    project_id = 'prod-111'
    AND toDate(timestamp) >= '2022-12-05'
GROUP BY tf
ORDER BY tf
;

WITH
    toStartOfDay(toDate('2021-01-01')) AS start,
    toStartOfDay(toDate('2021-01-02')) AS end
SELECT arrayJoin(arrayMap(x -> toDateTime(x), range(toUInt32(start), toUInt32(end), 60))) as hh
;


WITH
    dateSub(week, 1, now()) AS start,
    now() AS end
SELECT arrayJoin(arrayMap(x -> toDateTime(x), range(toUInt32(start), toUInt32(end), 60))) as hh
;

WITH
    dateTrunc('minute', dateSub(week, 1, now())) AS start,
    dateTrunc('minute', now()) AS end,
    t1 as (SELECT arrayJoin(arrayMap(x -> toDateTime(x), range(toUInt32(start), toUInt32(end), 60))) as hh)
SELECT
    t1.hh,
    t2.tf,
    t2.cnt
from t1
LEFT JOIN (
SELECT
    dateTrunc('minute', timestamp) as tf,
    count(event_id) as cnt
FROM events_parsed
WHERE
    project_id = 'prod-111'
--     AND toDate(timestamp) >= '2022-12-05'
    AND timestamp BETWEEN start and end
GROUP BY tf
ORDER BY tf
) as t2 ON t1.hh = t2.tf
;










WITH
t1 as (SELECT
    project_id,
    count() as cnt
FROM events_parsed
WHERE
    timestamp >= dateSub(month, 1, now())
    AND incoming = 1
GROUP BY project_id
HAVING cnt > 100
)
SELECT
    t1.project_id,
    t1.cnt as last_month,
    round(t1.cnt/(30*24), 2) as hour_avg,
    t2.cnt as last_hour
FROM t1
LEFT JOIN
(SELECT
    project_id,
    count() as cnt
FROM events_parsed
WHERE
    timestamp >= dateSub(hour, 1, now())
    AND incoming = 1
GROUP BY project_id
) as t2
ON t1.project_id = t2.project_id
ORDER BY last_hour ASC
;