/*
Урок 4. SQL – работа с несколькими таблицами
    1.  Подсчитать количество групп, в которые вступил каждый пользователь.
    2.  Подсчитать количество пользователей в каждом сообществе.
    3.  Пусть задан некоторый пользователь. Из всех пользователей соц.
        сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).
    4*  Подсчитать общее количество лайков, которые получили пользователи младше 18 лет..
    5*  Определить кто больше поставил лайков (всего): мужчины или женщины.
*/
use vk;

-- 1.  Подсчитать количество групп, в которые вступил каждый пользователь.
SELECT
    users.id,
	firstname,
	lastname,
	COUNT(user_id) as group_count
FROM users
LEFT JOIN users_communities
	ON users.id = users_communities.user_id
GROUP BY users.id
-- ORDER BY count(*) DESC

-- 2.  Подсчитать количество пользователей в каждом сообществе.
SELECT
	community_id,
	c.name,
	COUNT(*) AS uCount
FROM users_communities AS uc
    JOIN users AS u	ON u.id = uc.user_id
    JOIN communities c ON c.id = uc.community_id 
GROUP BY community_id
ORDER BY community_id;

-- 3.  Пусть задан некоторый пользователь.
--		Из всех пользователей соц. сети найдите человека,
--		который больше всех общался с выбранным пользователем (написал ему сообщений).

SELECT firstname, lastname, from_user_id, to_user_id, count(from_user_id) AS num_of_messages
FROM messages
LEFT JOIN users ON users.id = from_user_id
	WHERE to_user_id = 1
GROUP BY from_user_id
ORDER BY num_of_messages DESC
LIMIT 1;




-- 4.  Подсчитать общее количество лайков, которые получили пользователи младше 18 лет.
SELECT COUNT(*) as likes
FROM likes
	JOIN media ON likes.media_id = media.id 
	JOIN profiles ON media.user_id = profiles.user_id 
		WHERE YEAR(CURDATE()) - YEAR(birthday) < 18;


-- 5*. Определить кто больше поставил лайков (всего): мужчины или женщины.
SELECT  gender, COUNT(*)
from likes
join profiles on likes.user_id = profiles.user_id 
group by gender;


-- что-то из образца в примерах решения домашки было не правильно, так вроде правильно считает
SELECT gender FROM (
	SELECT gender, COUNT(likes.user_id) as glc FROM profiles, likes
	WHERE likes.user_id = profiles.user_id 
	GROUP BY gender
) AS T
GROUP BY gender
ORDER BY MAX(glc) DESC
LIMIT 1;