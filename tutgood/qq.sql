-- 527 528


SELECT
    quantilesExactExclusive(0.25, 0.5, 0.75, 0.9, 0.95, 0.99, 0.999)(length(text))
FROM events_parsed
WHERE
    project_id in ('prod-528', 'prod-527')
    AND toDate(timestamp) >= '2023-01-01'
    AND incoming = 1
;



SELECT
    count()
FROM events_parsed
WHERE
    project_id in ('prod-528', 'prod-527')
    AND toDate(timestamp) >= '2022-10-01'
    AND incoming = 1
--     AND text like '%userAgent%'
-- limit 1000
;
