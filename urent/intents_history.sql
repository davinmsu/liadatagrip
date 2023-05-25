SELECT
    *
FROM default.intents_history
WHERE project_id = 248
;

SELECT
    name,
    arraySlice(arrayReverseSort(arrayDistinct(ids)), 1, 2) as ids,
    ids[1] as a,
    ids[2] as b
FROM (
         SELECT name,
                groupArray(id)    as ids,
                groupArray(texts) as texts
         FROM default.intents_history
         WHERE project_id = 248
         GROUP BY name
         )
;

SELECT
    name,
    ids[1] as now,
    ids[2] as then
        FROM (
                 SELECT name,
                        arraySlice(arrayReverseSort(arrayDistinct(groupArray(id))), 1, 2) as ids
                 FROM default.intents_history
                 WHERE project_id = 248
                 GROUP BY name
                 )
;


