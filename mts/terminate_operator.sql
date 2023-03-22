SELECT
    JSONExtractString(facts, 'client_id_usedesk') as client_id,
    JSONExtractString(facts, 'ticket_id_usedesk') as ticket_id,
    fact_keys,
    *
FROM events_parsed
WHERE
    project_id = 'prod-303'
    AND toDate(timestamp) >= '2022-12-27'
    AND user_id = '1481805'
LIMIT 1000
;


{"transfer_params": {"ticket_id": "1481805", "client_id": "1043019", "assignee_email": "damiron2@mts.ru", "assignee_name": "\u041c\u0438\u0440\u043e\u043d\u043e\u0432 \u0414\u043c\u0438\u0442\u0440\u0438\u0439", "assignee_id": "24"}}



