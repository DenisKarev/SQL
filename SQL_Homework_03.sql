/*
Урок 3. SQL – выборка данных, сортировка, агрегатные функции
    1.  Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке. [ORDER BY]
    2.  Выведите количество мужчин старше 35 лет [COUNT].
    3.  Сколько заявок в друзья в каждом статусе? (таблица friend_requests) [GROUP BY]
    4.  Выведите номер пользователя, который отправил больше всех заявок в друзья (таблица friend_requests) [LIMIT].
    5*. Выведите названия и номера групп, имена которых состоят из 5 символов [LIKE].
*/
use vk;

-- 1.  Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке. [ORDER BY]

SELECT DISTINCT firstname FROM users
order by firstname;

-- 2.  Выведите количество мужчин старше 35 лет [COUNT].
SELECT COUNT(birthday) AS count FROM `profiles`
WHERE (birthday + INTERVAL 35 YEAR) > NOW();

-- 3.  Сколько заявок в друзья в каждом статусе? (таблица friend_requests) [GROUP BY]
SELECT COUNT(`status`) AS count, `status` FROM friend_requests
GROUP BY `status`;

-- 4.  Выведите номер пользователя, который отправил больше всех заявок в друзья (таблица friend_requests) [LIMIT].
SELECT count(initiator_user_id) AS count, initiator_user_id  FROM friend_requests
group by initiator_user_id
-- where `status` IN ('requested','approved')
LIMIT 1;


-- 5*. Выведите названия и номера групп, имена которых состоят из 5 символов [LIKE].
SELECT name, id from communities
where name LIKE '_____';