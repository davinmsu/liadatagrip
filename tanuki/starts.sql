SELECT
    dateTrunc('week', timestamp) as week,
    countIf(type = 'start') as starts,
    countIf(type = 'text') as texts
FROM events_parsed
WHERE project_id ='prod-131'
    AND dateTrunc('week', timestamp) >= '2021-11-01'
    AND incoming = 1
GROUP BY week
;

SELECT
    facts
FROM events_parsed
WHERE project_id ='prod-131'
    AND dateTrunc('week', timestamp) >= '2021-11-01'
    AND incoming = 1
LIMIT 1000
;


{"chat_id": 549159, "visitor": {"id": "e5f20a93f6af27ec228b8c9e739d0cb2", "fields": {"email": "21masha22@gmail.com", "id": "1935624", "name": "\u041c\u0430\u0440\u0438\u044f ", "phone": "79167563533"}}}

{"chat_id": 549156, "visitor": {"id": "d49118aaee4c9b01a59509bfdfc6ddb7", "fields": {"name": "\u041f\u043e\u0441\u0435\u0442\u0438\u0442\u0435\u043b\u044c"}}}