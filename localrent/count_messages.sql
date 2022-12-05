-- localrent
SELECT
    dateTrunc('month', timestamp) as month,
    countIf(incoming = 1 AND type = 'text') as user_messages,
    round(countIf(incoming = 1 AND type = 'text')/1000*2.3) as sum_microsoft_eur,
    uniqExact(user_id) as MAU
FROM events_parsed
WHERE
    project_id = 'prod-344'
    AND toDate(timestamp) >= '2021-11-01'
GROUP BY month
;


--



-- indriver
SELECT
    dateTrunc('month', timestamp) as month,
    countIf(incoming = 1 AND type = 'text') as user_messages,
    uniqExact(user_id) as MAU
FROM events_parsed
WHERE
    project_id in ('prod-363', 'prod-364')
    AND toDate(timestamp) >= '2021-11-01'
GROUP BY month
;



SELECT
    text
FROM events_parsed
WHERE
    project_id in ('prod-363', 'prod-364')
    AND toDate(timestamp) >= '2021-11-01'
    AND type = 'text'
;

