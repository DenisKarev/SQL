/*Задача 1
-- Создать БД vk, исполнив скрипт _vk_db_creation.sql (в материалах к уроку)

! Написать скрипт, добавляющий в созданную БД vk 2-3 новые таблицы
(с перечнем полей, указанием индексов и внешних ключей) (CREATE TABLE) */

DROP TABLE IF EXISTS photo_albums;
CREATE TABLE photo_albums(
	id SERIAL,
	name VARCHAR(255),
	user_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (user_id) REFERENCES users(id)	
);

DROP TABLE IF EXISTS photoes;
CREATE TABLE photoes(
	id SERIAL,
--	name VARCHAR(255),
	album_id BIGINT UNSIGNED,
	media_id BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (album_id) REFERENCES photo_albums(id),
	FOREIGN KEY (media_id) REFERENCES media(id)
);


DROP TABLE IF EXISTS cities;
CREATE TABLE cities(
	id SERIAL,
	name VARCHAR(255) NOT NULL
);

-- ALTER TABLE vk.profiles CHANGE hometown city_id BIGINT UNSIGNED NULL AFTER photo_id;
-- ALTER TABLE vk.profiles DROP COLUMN hometown;
-- ALTER TABLE vk.profiles ADD city_id BIGINT UNSIGNED NULL AFTER photo_id
-- ALTER TABLE vk.profiles ADD FOREIGN KEY (city_id) REFERENCES vk.cities(id);

/*Задача 2.
Заполнить 2 таблицы БД vk данными (до 10 записей в каждой таблице).
!! поскольку заполнял используя filldb.info -- заполнить пришлось все ))
*/
--# insert media
INSERT INTO `media` (`id`, `media_type_id`, `user_id`, `body`, `filename`, `size`, `metadata`, `created_at`, `updated_at`)
VALUES ('1', '1', '11', ' ', 'facere', 3, NULL, '1990-11-16 11:56:59', '2020-02-27 20:18:34'),
('2', '2', '12', ' ', 'totam', 8, NULL, '1996-01-30 19:37:58', '1999-09-22 23:39:05'),
('3', '3', '13', ' ', 'quisquam', 24, NULL, '1972-06-26 06:28:49', '1977-02-16 15:41:59'),
('4', '4', '14', ' ', 'autem', 2535495, NULL, '2018-10-19 14:10:37', '2004-06-29 22:24:48'),
('5', '5', '16', ' ', 'est', 1055, NULL, '2020-12-22 10:28:25', '2003-07-29 19:11:08'),
('6', '1', '17', ' ', 'aut', 2, NULL, '1998-04-19 08:03:17', '1992-09-20 10:09:00'),
('7', '2', '11', ' ', 'qui', 8269, NULL, '1982-12-29 19:36:51', '2011-07-03 09:04:34'),
('8', '3', '12', ' ', 'atque', 5676, NULL, '1997-06-02 16:22:14', '2014-10-08 06:52:58'),
('9', '4', '13', ' ', 'quae', 219, NULL, '1992-08-29 01:44:41', '1992-05-03 12:24:46'),
('10', '5', '14', ' ', 'esse', 771, NULL, '2007-07-06 02:49:55', '2002-08-23 16:29:17');

--# insert media_types
INSERT INTO `media_types` (`id`, `name`, `created_at`, `updated_at`) VALUES ('1', 'mp3', '1987-12-13 18:51:07', '1989-09-17 09:14:16'),
('2', 'jpg', '2014-05-18 08:53:13', '1989-11-18 20:58:50'),
('3', 'avi', '2013-01-01 02:34:54', '1982-03-30 04:32:58'),
('4', 'txt', '2013-02-10 21:35:33', '2008-10-07 21:13:23'),
('5', 'md', '1996-10-10 15:30:11', '1970-10-25 13:07:54');


--# insert photo_albums
INSERT INTO `photo_albums` (`id`, `name`, `user_id`) VALUES ('1', 'eum', '11'),
('2', 'perspiciatis', '12'),
('3', 'delectus', '13');


--# insert photoes
INSERT INTO `photoes` (`id`, `album_id`, `media_id`) VALUES ('1', '1', '1'),
('2', '2', '2'),
('3', '3', '3'),
('4', '1', '4'),
('5', '2', '5');

-- # insert profiles

INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `created_at`, `hometown`)
VALUES ('11', 'u', '2018-02-28', '1', '1976-08-22 01:24:04', NULL),
('12', 'x', '1975-11-03', '2', '2016-06-15 14:11:39', NULL),
('13', 'f', '1978-11-05', '3', '1971-12-31 02:08:25', NULL),
('14', 't', '1988-06-10', '4', '2009-06-09 23:47:15', NULL),
('16', 'p', '2019-06-14', '5', '1983-04-10 07:51:04', NULL),
('17', 'p', '2019-01-01', '6', '1970-08-21 15:23:38', NULL);

--# insert users
INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `password_hash`, `phone`)
VALUES ('11', 'Clare', 'Kutch', 'alene79@example.net', 'e9b83ad3520339e0339ae32ec3061b9519fb401c', '91'),
('12', 'Kim', 'Hessel', 'fmedhurst@example.org', '1dcf13df37067bb23e79cf27c0ae9764cdbcc200', '771'),
('13', 'Marley', 'Wiegand', 'wmohr@example.net', 'ac05fd2583f9248c8b898f818ad0b5a181982481', '81'),
('14', 'Duane', 'Fisher', 'isaac73@example.net', 'd29f651d81a0d2883e741837b7751670130142f2', '1'),
('16', 'Payton', 'Reilly', 'lilly06@example.org', '2bdae52a6abbaba43f0dbd27cc4c04b2d82c7d52', '688'),
('17', 'Tiara', 'Olson', 'dolson@example.net', '35746c77fa34b7da939bd8d136715c61474a2e99', '0');


Задача 3.
/*
Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false).
При необходимости предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)
*/
/* ALTER TABLE vk.profiles
ADD COLUMN active BIT NOT NULL DEFAULT 1 AFTER created_at;

UPDATE profiles
SET is_active = 0
WHERE (birthday + INTERVAL 18 YEAR) > NOW();
*/