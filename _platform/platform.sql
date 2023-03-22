
SELECT
    email, totp_secret

from web_user
where email in (
'romanbolshakov.90@gmail.com',
'rybak+growfood@lia.chat',
'rybak+foodband@lia.chat',
'rybak+tutgood@lia.chat',
'k.dutieva@gmail.com',
'beresneva.irina.s@gmail.com',
'tulakovaalina0@gmail.com'
)
;









SELECT * from web_user
where email like '%rybak+gr%'
;


SELECT *
FROM web_activity
WHERE project_id = 303
-- AND date BETWEEN '2022-08-10 00:00:00' AND
AND item like '%по тариф%'
ORDER BY date DESC