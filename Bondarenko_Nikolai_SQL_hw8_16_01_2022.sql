-- 1) пусть задан пользователь, из всех друзей найдите, кто больше всего с ним общался

SELECT m.from_user_id, count(m.from_user_id) as cnt 
FROM messages m 
join users u on u.id = m.from_user_id
join friend_requests fr on u.id = fr.initiator_user_id OR u.id = fr.target_user_id
where u.id IN ( 
 SELECT initiator_user_id FROM friend_requests WHERE (target_user_id = 1) AND status='approved' -- ИД друзей, заявку которых я подтвердил
 union
 SELECT target_user_id FROM friend_requests WHERE (initiator_user_id = 1) AND status='approved' -- ИД друзей, подтвердивших мою заявку
) and to_user_id = 1
group by m.from_user_id 
order by cnt desc
limit 1;

-- 2) подсчитайте общее количество лайков, которые получили пользователи младше 11 лет

select
count(l.id) as younger_11
from likes l 
join users u on l.user_id = u.id 
join profiles p on p.user_id = u.id and timestampdiff(YEAR, birthday, NOW()) < 11;

-- 3) посчитать кто больше всего поставил лайков, мужчины или женщины
select
count(l.id) as cnt_of_like, p.gender 
from likes l
join users u on l.user_id = u.id 
join profiles p on u.id  = p.user_id 
group by p.gender
limit 1;
