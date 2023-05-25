CREATE TABLE temp.samokat_keypoints
(
    uuid String,
    name String
) ENGINE = MergeTree ORDER BY uuid
;


INSERT INTO temp.smm_keypoints (uuid, name)
VALUES
('12e0a7a7-00a4-4ad7-b0a3-9109f322eb90', 'get phone'),
('c0842945-26f8-4585-a7ae-58e55df5ad8c', 'wrong phone'),
('198cf9c5-16d3-4222-9995-14fe143d9903', 'error again'),
('05976661-2914-4037-916d-904cf4902a34', 'get order'),
('15f84979-7aea-4feb-8201-8bd65030078b', 'wrong order N'),
('cdca0fca-5137-44a2-a1ad-4c1402e9e1be', 'operator'),
('5102e350-7182-4559-80c7-061fc4148b13', 'success'),
('b2dd2ab9-09de-4527-884d-d850f16a8a47', 'questions')

;



-- Неверная квартира
-- https://app.lia.chat/app/137/flows/10525
INSERT INTO temp.samokat_keypoints (uuid, name) VALUES
('22fbc09f-843f-4158-b13c-0903d3659a11','Интент проверен, есть заказ'),
('5f4407a0-56ab-4588-b34c-94076d105133','Позвал человека в рабочее время'),
('436e8b7e-f295-4a7a-8067-6cb5a80ef51e','Позвал человека в нерабочее время'),
('db0fc70e-5c66-4f1c-8e3f-bb9e350d8124','Заказ есть, прочее'),
('d85721b9-e425-470a-b4df-6e77cd981821','Заказа нет, есть номер, позвал человека в рабочее время'),
('b34f9fb6-ae0b-4163-91ff-0484db7d6fca','Заказа нет, есть номер, позвал человека в нерабочее время'),
('a4b29b17-0ee3-44a1-a49f-4299fb832e36','Заказа нет, нет номера, позвал человека в рабочее время'),
('56dd4c5b-3ada-4f72-bd20-edd4d67f72f0','Заказа нет, нет номера, позвал человека в нерабочее время'),
('d4dd73c5-b296-40b5-8803-23ab2d2968ea','Прочее, заказа нет, номер есть'),
('d73147e4-f889-455b-be6e-57869fb7e743','Прочее, заказа нет, номера нет');


-- Быстрее
-- https://app.lia.chat/app/137/flows/14510
INSERT INTO temp.samokat_keypoints (uuid, name) VALUES
('c7d26f3a-ae9b-4447-a03c-36e7987607a1','Интент проверен'),
('4fb9dc34-1bda-41e0-b64c-403abbde2614','Вопрос решен'),
('6a8b7755-d015-4177-a0fc-4bae0fbf7399','Есть заказ, позвал человека в рабочее время'),
('836695e6-964c-4356-8278-b8201c801e06','Есть заказ, позвал человека в нерабочее время'),
('d9ddfa32-610b-4b20-9519-509368612353','Заказа нет, есть номер, позвал человека в рабочее время'),
('c2609a7f-bae6-432a-9adb-67d591fdc61c','Заказа нет, есть номер, позвал человека в нерабочее время'),
('fc0e285f-f04d-4025-8f19-4982be83ca09','Заказа нет, номера нет, позвал человека в рабочее время'),
('0b1eaccf-8ec7-4d06-824e-6772789da1a3','Заказа нет, номера нет, позвал человека в нерабочее время'),
('b5531d34-8c84-4c38-85c1-fe7fd8b80a33','Прочее');


-- Комментарий: срок годности
-- https://app.lia.chat/app/137/flows/12560
INSERT INTO temp.samokat_keypoints (uuid, name) VALUES
('9dac439f-abcc-4e31-a2c0-1ef28b829686','интент проверен'),
('934248ce-c6c0-4225-8c77-df6b84c4fe95','Есть заказ, позвал человека в рабочее время'),
('56246bc6-43da-4793-a5de-40a1f0056668','Есть заказ, позвал человека в нерабочее время'),
('efe04454-e1e5-4000-ac83-477422287c71','Нет заказа, есть номер телефона, позвал человека в рабочее время'),
('ef32f2ce-5297-49d3-a8da-bc6bf88cbbd9','Нет заказа, есть номер телефона, позвал человека в нерабочее время'),
('b8edb67e-cedb-499d-b300-80f6c2d917bf','Нет заказа, нет номера телефона, позвал человека в рабочее время'),
('0809792d-d666-4638-8057-bce66394d56a','Нет заказа, нет номера телефона, позвал человека в нерабочее время'),
('3191c97b-25a6-4274-9a06-dcfa74eab755','Прочее'),
('2ea41601-c20b-451d-8bf9-9e7d1b3ff216','Вопрос решен'),
('52bf238a-7a3b-419e-9de0-7425061852b2','Интент не проверен, позвал человека в рабочее время'),
('6f4c7c9b-6486-4267-a690-4589865657ca','Интент не проверен, позвал человека в нерабочее время');


-- Неверная квартира
-- https://app.lia.chat/app/137/flows/10525
-- '22fbc09f-843f-4158-b13c-0903d3659a11',
-- '5f4407a0-56ab-4588-b34c-94076d105133',
-- '436e8b7e-f295-4a7a-8067-6cb5a80ef51e',
-- 'db0fc70e-5c66-4f1c-8e3f-bb9e350d8124',
-- 'd85721b9-e425-470a-b4df-6e77cd981821',
-- 'b34f9fb6-ae0b-4163-91ff-0484db7d6fca',
-- 'a4b29b17-0ee3-44a1-a49f-4299fb832e36',
-- '56dd4c5b-3ada-4f72-bd20-edd4d67f72f0',
-- 'd4dd73c5-b296-40b5-8803-23ab2d2968ea',
-- 'd73147e4-f889-455b-be6e-57869fb7e743'

-- Быстрее
-- https://app.lia.chat/app/137/flows/14510
-- 'c7d26f3a-ae9b-4447-a03c-36e7987607a1',
-- '4fb9dc34-1bda-41e0-b64c-403abbde2614',
-- '6a8b7755-d015-4177-a0fc-4bae0fbf7399',
-- '836695e6-964c-4356-8278-b8201c801e06',
-- 'd9ddfa32-610b-4b20-9519-509368612353',
-- 'c2609a7f-bae6-432a-9adb-67d591fdc61c',
-- 'fc0e285f-f04d-4025-8f19-4982be83ca09',
-- '0b1eaccf-8ec7-4d06-824e-6772789da1a3',
-- 'b5531d34-8c84-4c38-85c1-fe7fd8b80a33'


-- Комментарий: срок годности
-- https://app.lia.chat/app/137/flows/12560
-- '9dac439f-abcc-4e31-a2c0-1ef28b829686',
-- '934248ce-c6c0-4225-8c77-df6b84c4fe95',
-- '56246bc6-43da-4793-a5de-40a1f0056668',
-- 'efe04454-e1e5-4000-ac83-477422287c71',
-- 'ef32f2ce-5297-49d3-a8da-bc6bf88cbbd9',
-- 'b8edb67e-cedb-499d-b300-80f6c2d917bf',
-- '0809792d-d666-4638-8057-bce66394d56a',
-- '3191c97b-25a6-4274-9a06-dcfa74eab755',
-- '2ea41601-c20b-451d-8bf9-9e7d1b3ff216',
-- '52bf238a-7a3b-419e-9de0-7425061852b2',
-- '6f4c7c9b-6486-4267-a690-4589865657ca'



WITH
(
'c7d26f3a-ae9b-4447-a03c-36e7987607a1',
'4fb9dc34-1bda-41e0-b64c-403abbde2614',
'6a8b7755-d015-4177-a0fc-4bae0fbf7399',
'836695e6-964c-4356-8278-b8201c801e06',
'd9ddfa32-610b-4b20-9519-509368612353',
'c2609a7f-bae6-432a-9adb-67d591fdc61c',
'fc0e285f-f04d-4025-8f19-4982be83ca09',
'0b1eaccf-8ec7-4d06-824e-6772789da1a3',
'b5531d34-8c84-4c38-85c1-fe7fd8b80a33'
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
                    INNER JOIN temp.samokat_keypoints as t2
                    ON reaction = t2.uuid
                    WHERE project_id = 'prod-137'
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
