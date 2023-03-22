(
    1476115,
    1476167,
    1476206,
    1476465,
    1476526,
    1476545,
    1476370,
    1476260
)

(   1476714,
    1476783,
    1075282
)



SELECT
    JSONExtractString(JSONExtractRaw(facts, 'session'), 'id') as sid,
    *
from events_parsed
WHERE
    project_id = 'prod-428'
    AND
    toDate(timestamp) > '2022-12-06'
    AND sid in
(   1476714,
    1476783,
    1075282
)
ORDER BY user_id, ts_ms
LIMIT 1000
;





SELECT
    *
FROM events_parsed
WHERE
--     project_id = 'prod-428'
    toDate(timestamp) > '2022-09-01'
    AND text = 'DODO_CLOSE_THREAD'
;



