/*
Урок 4. SQL – работа с несколькими таблицами
    1.  Создайте представление с произвольным SELECT-запросом из прошлых уроков [CREATE VIEW]		
    2.  Выведите данные, используя написанное представление [SELECT]
    3.  Удалите представление [DROP VIEW]
    4*  Сколько новостей (записей в таблице media) у каждого пользователя?
		Вывести поля: news_count (количество новостей), user_id (номер пользователя), user_email (email пользователя).
		Попробовать решить с помощью CTE или с помощью обычного JOIN.
*/
use vk;

-- 1.  Создайте представление с произвольным SELECT-запросом из прошлых уроков [CREATE VIEW]		
CREATE OR REPLACE VIEW  view_males_bb AS
SELECT * FROM users
JOIN profiles on users.id = profiles.user_id 
WHERE profiles.gender ='m'
ORDER BY profiles.birthday;

-- 2.  Выведите данные, используя написанное представление [SELECT]
SELECT id, firstname, lastname, phone, email, gender, birthday, hometown, photo_id 
FROM view_males_bb vmb
WHERE hometown LIKE 'b%'
ORDER BY hometown;

-- 3.  Удалите представление [DROP VIEW]
DROP VIEW view_males_bb;


-- 4.  Сколько новостей (записей в таблице media) у каждого пользователя?
	-- Вывести поля: news_count (количество новостей), user_id (номер пользователя), user_email (email пользователя).
	-- Попробовать решить с помощью CTE или с помощью обычного JOIN.

-- JOIN
-- вариант с показом тех у кого 0 новостей
SELECT count(media.id) as news_count, users.id as user_id, users.email 
FROM users
LEFT JOIN media ON users.id = media.user_id 
GROUP BY users.id;
-- вариант с показом только тех у кого больше 0 новостей
SELECT count(media.id) as news_count, users.id as user_id, users.email 
FROM users
JOIN media ON users.id = media.user_id 
GROUP BY users.id;

-- CTE ??
WITH
	cte1 AS (SELECT count(id) as news_count, user_id FROM media GROUP BY user_id),
	cte2 AS (SELECT id, email FROM users)
SELECT news_count, cte2.id, email
FROM cte1
JOIN cte2 on cte1.user_id = cte2.id