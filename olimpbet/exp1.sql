WITH
poper as (
    SELECT user_id
    FROM events_parsed
    WHERE project_id = 'prod-405'
      AND user_id like '%3S'
      AND date_trunc('month', timestamp) = '2022-10-01'
    LIMIT 1000
)
SELECT
       timestamp, user_id
FROM events_parsed
WHERE
    project_id = 'prod-405'
    AND user_id in poper
    AND date_trunc('month', timestamp) = '2022-10-01'
LIMIT 100
;


(
    SELECT user_id
    FROM events_parsed
    WHERE project_id = 'prod-405'
      AND user_id like '%3S'
      AND date_trunc('month', timestamp) = '2022-10-01'
    LIMIT 1000
)



SELECT *
from events_parsed
WHERE user_id = 'RK3OB63UJ8'
and project_id = 'prod-405'
and toDate(timestamp) > '2022-09-10'
ORDER BY ts_ms
;