SELECT
    fact_keys, facts
FROM events_parsed
WHERE project_id ='prod-336'
    AND toDate(timestamp) >= '2023-02-08'
ORDER BY ts_ms DESC
LIMIT 1000
;

"channelInfo": {"id": 2, "channelType": "MOBILE", "authorized": true}