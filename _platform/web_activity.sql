SELECT wa.*, wu.email
FROM web_activity wa
LEFT JOIN web_user wu on wu.id = wa.user_id
WHERE project_id = 248 and date between '2022-07-25 00:00:00' and '2022-08-03 00:00:00'
ORDER BY date
LIMIT 501