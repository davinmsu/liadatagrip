SELECT
       marking_entity.id as id,
       project_id,
       wp.name as project_name,
       wc.name as company_name,
       marking_entity.name as name,
       extractor_params,
       marking_entity.date_created as created,
       marking_entity.last_modified as midified
FROM marking_entity
JOIN marking_entitygroup me on marking_entity.entity_group_id = me.id
JOIN web_project wp on me.project_id = wp.id
JOIN web_company wc on wp.company_id = wc.id
WHERE
    extractor_params ->> 'regexp' like '%ogg%'

