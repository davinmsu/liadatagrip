WITH
    project_id = 111 as clause
SELECT concat('intent-', toString(id))                   as id,
        name,
        if(is_active = 1, 'active', 'inactive')           as active,
        arrayStringConcat(arraySlice(texts, 1, 5), ' | ') as texts
FROM intents_history
WHERE clause
ORDER BY timestamp DESC
LIMIT 1 BY id


UNION ALL

SELECT concat('qa-', toString(id))                           as id,
       name,
       if(is_active = 1, 'active', 'inactive')               as active,
       arrayStringConcat(arraySlice(questions, 1, 5), ' | ') as texts
FROM qa_history
WHERE clause
ORDER BY timestamp DESC
LIMIT 1 BY id
;