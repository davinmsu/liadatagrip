SELECT
    *
FROM events_parsed
WHERE
    project_id = 'prod-248'
    AND toDate(timestamp) > '2022-11-01'
    AND text like '%Мы можем ещё чем-нибудь помочь?%'
;


