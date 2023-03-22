SELECT
    timestamp,
    user_id,
    text,
    ntext
FROM (
    SELECT
        timestamp,
        reaction,
        user_id,
        text,
        neighbor(text, 1) as ntext,
        neighbor(user_id, 1) as nuser
    FROM events_parsed
    WHERE
    project_id = 'prod-182'
    AND toDate(timestamp) >= '2023-01-01'
    ORDER BY user_id, ts_ms
     )
WHERE
    user_id = nuser
    AND
    reaction in (
        'a81220a2-6bf6-4e35-bdcc-a90b6f923573',
        '90bcf835-6799-4f9d-8d1f-8ddcad544158',
        'c27da166-fffe-4840-83aa-e4c90b7d77af',
        'bf8690b4-9abf-4857-bfeb-9f4fe5f5bc08',
        'fb47d1df-ef83-4530-89d4-12b3c6dfde37',
        'a4685acf-2d6a-4745-9d38-029b750e8229',
        'f51fd0e0-8d91-445a-8985-0d580427fe06',
        'e47ba3ec-d814-40ec-a82e-48622d5a742a',
        '65313514-0d3f-4e16-85e0-acda31d81dfc',
        '04e4e559-662e-4c73-8845-314d9353c22f',
        'ee263ed7-c806-44da-ac3c-2ab85892c1f3',
        'e71a0515-c755-4462-bfe9-e2210ecdc234',
        '0654a06b-7573-4109-9df7-cd265d8235d8',
        'dd391c13-bbd5-47a0-9261-880ffa67708d',
        '78620f50-a0f5-4a25-9a5e-18a03440c1ca',
        'f366ddc5-a3da-4291-b4c9-18fdf9f0df96'
        )