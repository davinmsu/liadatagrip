SELECT
    user_id,
    facts
FROM events_parsed
WHERE
    project_id = 'prod-248'
    AND toDate(timestamp) >= '2023-03-28'
;


-- 79991234567

-- {"lia_request_track_id": "0543aff6135c4a8f9849ae31d74bc628", "client_id_usedesk": "112069454", "ticket_id_usedesk": "130268673", "phones": "", "client_email": "", "channel_id": "usedesk-1"}

