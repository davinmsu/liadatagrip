-- CREATE TABLE temp.smm_keypoints
-- (
--     uuid String,
--     name String
-- ) ENGINE = MergeTree ORDER BY uuid
-- ;
--
--
-- INSERT INTO temp.smm_keypoints (uuid, name)
-- VALUES
-- ('12e0a7a7-00a4-4ad7-b0a3-9109f322eb90', 'get phone'),
-- ('c0842945-26f8-4585-a7ae-58e55df5ad8c', 'wrong phone'),
-- ('198cf9c5-16d3-4222-9995-14fe143d9903', 'error again'),
-- ('05976661-2914-4037-916d-904cf4902a34', 'get order'),
-- ('15f84979-7aea-4feb-8201-8bd65030078b', 'wrong order N'),
-- ('cdca0fca-5137-44a2-a1ad-4c1402e9e1be', 'operator'),
-- ('5102e350-7182-4559-80c7-061fc4148b13', 'success'),
-- ('b2dd2ab9-09de-4527-884d-d850f16a8a47', 'questions')
--
-- ;







WITH
(
    '12e0a7a7-00a4-4ad7-b0a3-9109f322eb90',
    'c0842945-26f8-4585-a7ae-58e55df5ad8c',
    '198cf9c5-16d3-4222-9995-14fe143d9903',
    '05976661-2914-4037-916d-904cf4902a34',
    '15f84979-7aea-4feb-8201-8bd65030078b',
    'cdca0fca-5137-44a2-a1ad-4c1402e9e1be',
    '5102e350-7182-4559-80c7-061fc4148b13',
    'b2dd2ab9-09de-4527-884d-d850f16a8a47'
) as common_reactions

SELECT
       reactions[1] as stage1,
       reactions[2] as stage2,
       reactions[3] as stage3,
       reactions[4] as stage4,
       reactions[5] as stage5,
       cnt as value
FROM
    (
        SELECT arrayResize(reactions, 5, NULL) as reactions,
               count(reactions) as cnt
        FROM (
              SELECT user_id,
                     groupArray(reaction_name) as reactions
              FROM (
                    SELECT timestamp,
                           user_id,
--                       visitor_id,
                           t2.name as reaction_name,
                           JSONExtractString(meta, 'reaction') as reaction
                    FROM default.events_parsed
                    INNER JOIN temp.smm_keypoints as t2
                    ON reaction = t2.uuid
                    WHERE project_id = 'prod-111'
                      AND toDate(timestamp) > toStartOfMonth(now())
                      AND JSONExtractString(meta, 'reaction') in common_reactions
                    ORDER BY user_id, ts_ms
                       )
              GROUP BY user_id
--               HAVING reactions != ['cdca0fca-5137-44a2-a1ad-4c1402e9e1be']
                 )
        GROUP BY reactions
    )
WHERE
    stage1 !='operator'
;
