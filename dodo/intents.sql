SELECT
    intents,
    count(intents) as cnt
from events_parsed
ARRAY JOIN intents
WHERE project_id = 'prod-428'
and toDate(timestamp) > '2022-10-06'
AND length(intents) > 0
GROUP BY intents
ORDER BY cnt DESC
LIMIT 1000
;



SELECT *
FROM events_parsed
WHERE project_id = 'prod-428'
AND toDate(timestamp) > '2022-11-06'
ORDER BY ts_ms DESC
LIMIT 1000
;

