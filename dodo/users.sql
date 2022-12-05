SELECT *
FROM events_parsed
WHERE project_id = 'prod-428'
AND toDate(timestamp) > '2022-11-20'
ORDER BY ts_ms DESC
LIMIT 1000
;

{"chat": {"id": "7250581"}, "clientData": {"data": {"name": "\u041c\u0430\u0440\u0438\u044f", "topic": null, "locale": "ru-RU", "phone": "+79323003090", "email": null}}, "session": {"id": "1361758"}, "question": {"index": 1}, "channel_id": "edna-1"}