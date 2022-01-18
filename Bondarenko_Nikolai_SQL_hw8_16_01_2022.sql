-- 1) пусть задан пользователь, из всех друзей найдите, кто больше всего с ним общался

SELECT m.from_user_id, count(m.from_user_id) as cnt, m.to_user_id 
FROM messages m 
 join friend_requests fr on m.from_user_id IN ( 
 SELECT fr.initiator_user_id FROM friend_requests WHERE (fr.target_user_id = 1) AND fr.status='approved' -- ИД друзей, заявку которых я подтвердил
 union
 SELECT fr.target_user_id FROM friend_requests WHERE (fr.initiator_user_id = 1) AND fr.status='approved' -- ИД друзей, подтвердивших мою заявку
) and m.to_user_id = 1 
group by m.from_user_id, m.to_user_id 
order by cnt desc;

-- 2) подсчитайте общее количество лайков, которые получили пользователи младше 11 лет

select
count(l.id) as younger_11
from likes l
JOIN media m ON m.id = l.media_id 
join users u on u.id = m.user_id 
join profiles p on p.user_id = u.id and timestampdiff(YEAR, birthday, NOW()) < 11;

-- 3) посчитать кто больше всего поставил лайков, мужчины или женщины
select
count(l.id) as cnt_of_like, p.gender 
from likes l
join users u on l.user_id = u.id 
join profiles p on u.id  = p.user_id 
group by p.gender
limit 1;
