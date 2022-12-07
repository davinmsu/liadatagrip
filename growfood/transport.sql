SELECT
    JSONExtract(facts,'transport_type', 'String') as transport_type,
    JSONExtract(facts,'transport_id', 'String') as transport_id
FROM events_parsed
WHERE
    project_id = 'prod-182'
    AND dateTrunc('month', timestamp) = '2022-11-01'
    AND transport_type = 'external'
    AND transport_id like '7__________'
ORDER BY ts_ms
;
