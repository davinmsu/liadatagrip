WITH
(
    '12e0a7a7-00a4-4ad7-b0a3-9109f322eb90',
    '05976661-2914-4037-916d-904cf4902a34',
    'b2dd2ab9-09de-4527-884d-d850f16a8a47'
) as pip_reactions

SELECT
    JSONExtractString(meta, 'reaction') as reaction,
    count(reaction) as cnt
FROM events_parsed
WHERE
    project_id = 'prod-111'
    AND reaction in pip_reactions
AND timestamp > toStartOfWeek(now())
GROUP BY reaction

