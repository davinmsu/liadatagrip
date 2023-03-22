SELECT
    DISTINCT JSONExtractString(visitor, 'access_token')
--     ,
--     *
FROM default.events_parsed
WHERE
    project_id = 'prod-111'
    AND toDate(timestamp) > '2023-01-01'
    AND user_id = '1997710'

--     AND timestamp > toStartOfHour(now())

;


SELECT
    *
FROM default.events_parsed
WHERE
    project_id = 'prod-111'
    AND toDate(timestamp) = '2022-12-01'
LIMIT 100

--     AND timestamp > toStartOfHour(now())

;


SELECT
    round(count()/30) as events_per_day,
    project_id,
    dictGetOrDefault('projects_dict', 'name', toUInt64(splitByChar('-', project_id)[2]), '') AS project_name
FROM default.events_parsed
WHERE
    dateTrunc('month', timestamp) = '2022-12-01'
    AND project_id in ('prod-111', 'prod-428', 'prod-137')
GROUP BY project_id
;

