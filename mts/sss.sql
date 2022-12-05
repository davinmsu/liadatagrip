-- q1
DROP VIEW temp.petuh;
CREATE VIEW temp.petuh AS
SELECT
    user_id as ticket_id,
    JSONExtract(facts, 'client_id_usedesk', 'String') as client_id,
    toDate(timestamp) as date,
    toInt8OrNull(ntext) as ans_q1
FROM
(SELECT neighbor(text, 1) as ntext,
        neighbor(user_id, 1) as nuser,
        *
 FROM (SELECT timestamp,
              reaction,
              text,
              facts,
              meta,
              user_id,
              incoming
       FROM events_parsed
       WHERE project_id = 'prod-303'
         AND toDate(timestamp) > '2022-11-20'
       ORDER BY user_id, ts_ms
          ))
WHERE
    nuser = user_id
    AND reaction in ('48af8d6f-7951-49c9-a689-e215c7ff567e', '23a8dd70-28e5-4948-be99-82e5e2a90fad')
    AND toInt8OrNull(ntext) BETWEEN 0 AND 10
    AND client_id = '1043019'

;
SELECT * FROM temp.petuh;

SELECT * FROM temp.petuh
FULL OUTER JOIN
(SELECT
    user_id as ticket_id,
    JSONExtract(facts, 'client_id_usedesk', 'String') as client_id,
    toDate(timestamp) as date,
    toInt8OrNull(ntext) as ans_q2
FROM
(SELECT neighbor(text, 1) as ntext,
        neighbor(user_id, 1) as nuser,
        *
 FROM (SELECT timestamp,
              reaction,
              text,
              facts,
              meta,
              user_id,
              incoming
       FROM events_parsed
       WHERE project_id = 'prod-303'
         AND toDate(timestamp) > '2022-11-20'
       ORDER BY user_id, ts_ms
          ))
WHERE
    nuser = user_id
    AND reaction IN ('004c2c1e-c952-4280-a34f-45cab44bffcf',
                     '3298faa3-f609-4b71-874d-acf5df6f4ea2',
                     '92cb4fb8-3c28-4e8e-b84e-a394150305d0',
                     'f84f96f1-ba1b-4ab5-98c6-d0049c35c32f',
                     '51a48386-59d1-48b5-aeb9-a8b26541f7b3',
                     '2e67f3dd-36cf-4470-8760-8d93d9e2edef')
    AND toInt8OrNull(ntext) BETWEEN 1 AND 3
    AND client_id = '1043019')
    as petuh2 ON petuh.date = petuh2.date
    AND petuh.client_id = petuh2.client_id
    AND petuh.ticket_id = petuh2.ticket_id


;



-- q3
SELECT
    user_id as ticket_id,
    JSONExtract(facts, 'client_id_usedesk', 'String') as client_id,
    timestamp,
    ntext as ans_q3
FROM
(SELECT neighbor(text, 1) as ntext,
        neighbor(user_id, 1) as nuser,
        *
 FROM (SELECT timestamp,
              reaction,
              text,
              facts,
              meta,
              user_id,
              incoming
       FROM events_parsed
       WHERE project_id = 'prod-303'
         AND toDate(timestamp) > '2022-11-20'
       ORDER BY user_id, ts_ms
          ))
WHERE
    nuser = user_id
    AND reaction IN (
    '8c3d82c4-7bc2-4c47-b931-fc01433a4b54',
    '9b8cfb2b-3ed6-409c-b621-99490fd13c0a',
    'c4eed267-306d-4129-a533-10c792b56d1a'
)
;



-- q3 phone
SELECT
    user_id as ticket_id,
    JSONExtract(facts, 'client_id_usedesk', 'String') as client_id,
    timestamp,
    ntext as ans_q3_phone
FROM
(SELECT neighbor(text, 1) as ntext,
        neighbor(user_id, 1) as nuser,
        *
 FROM (SELECT timestamp,
              reaction,
              text,
              facts,
              meta,
              user_id,
              incoming
       FROM events_parsed
       WHERE project_id = 'prod-303'
         AND toDate(timestamp) > '2022-11-20'
       ORDER BY user_id, ts_ms
          ))
WHERE
    nuser = user_id
    AND reaction IN (
    '09faacb7-e6d6-489a-8d59-9abfb0193d87',
    'f3f5c414-3eb8-49c1-b3c0-0ba7f11ed4ed',
    '7361fa30-3f49-4559-a99b-06d06b2072ef'
)
;



-- q4
SELECT
    user_id as ticket_id,
    JSONExtract(facts, 'client_id_usedesk', 'String') as client_id,
    timestamp,
    ntext as ans_q4
FROM
(SELECT neighbor(text, 1) as ntext,
        neighbor(user_id, 1) as nuser,
        *
 FROM (SELECT timestamp,
              reaction,
              text,
              facts,
              meta,
              user_id,
              incoming
       FROM events_parsed
       WHERE project_id = 'prod-303'
         AND toDate(timestamp) > '2022-11-20'
       ORDER BY user_id, ts_ms
          ))
WHERE
    nuser = user_id
    AND reaction IN (
    '423cfc62-0f41-4be5-93ec-1c820adfdeb3',
    '55a79218-bf5e-486c-a8f5-e7e29dcacbfb',
    'af91e2cc-6ceb-4e7f-bbc4-f3b3c04a4ed0'
)
;


-- ticketclosed
SELECT
    timestamp,
    user_id as ticket_id,
    JSONExtractString(JSONExtractRaw(facts, 'transfer_params'), 'client_id') as client_id,
    JSONExtractString(JSONExtractRaw(facts, 'transfer_params'), 'assignee_email') as assignee_email,
    JSONExtractString(JSONExtractRaw(facts, 'transfer_params'), 'assignee_name') as assignee_name
FROM events_parsed
   WHERE project_id = 'prod-303'
     AND toDate(timestamp) > '2022-11-20'
     AND text = 'ticketclosed'
   ORDER BY user_id, ts_ms
;

