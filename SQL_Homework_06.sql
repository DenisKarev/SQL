/*
Урок 6. SQL – Транзакции. Временные таблицы, управляющие конструкции, циклы

    1.	Написать функцию, которая удаляет всю информацию об указанном пользователе из БД vk.
	Пользователь задается по id.
	Удалить нужно все сообщения, лайки, медиа записи, профиль и запись из таблицы users.
	Функция должна возвращать номер пользователя.

    2.	Предыдущую задачу решить с помощью процедуры и обернуть используемые команды в транзакцию внутри процедуры.

    3.*	Написать триггер, который проверяет новое появляющееся сообщество. Длина названия сообщества (поле name)
	должна быть не менее 5 символов. Если требование не выполнено, то выбрасывать исключение с пояснением.
*/

use vk;

/* 1.	Написать функцию, которая удаляет всю информацию об указанном пользователе из БД vk.
	Пользователь задается по id.
	Удалить нужно все сообщения, лайки, медиа записи, профиль и запись из таблицы users.
	Функция должна возвращать номер пользователя.	*/

DROP FUNCTION IF EXISTS delete_user_by_id;

DELIMITER //

CREATE FUNCTION delete_user_by_id (user_id_to_delete BIGINT UNSIGNED) RETURNS bigint unsigned
    MODIFIES SQL DATA DETERMINISTIC

BEGIN
	DELETE FROM users_communities
	WHERE user_id = user_id_to_delete;

	DELETE FROM friend_requests
	WHERE initiator_user_id = user_id_to_delete
		OR target_user_id = user_id_to_delete;

	DELETE FROM messages
	WHERE from_user_id = user_id_to_delete
		OR to_user_id = user_id_to_delete;

	DELETE FROM profiles
	WHERE user_id = user_id_to_delete;

	DELETE  FROM likes
	WHERE user_id = user_id_to_delete;

	DELETE FROM media
	WHERE user_id = user_id_to_delete;

	DELETE FROM users
	WHERE id = user_id_to_delete;

RETURN user_id_to_delete;
END//

DELIMITER ;

-- 2.  Предыдущую задачу решить с помощью процедуры и обернуть используемые команды в транзакцию внутри процедуры.
DROP PROCEDURE IF EXISTS f_delete_user_by_id;

DELIMITER //
CREATE PROCEDURE f_delete_user_by_id(user_id_to_delete BIGINT UNSIGNED)
BEGIN
START TRANSACTION;

	DELETE FROM users_communities
	WHERE user_id = user_id_to_delete;

	DELETE FROM friend_requests
	WHERE initiator_user_id = user_id_to_delete OR
			target_user_id = user_id_to_delete;

	DELETE FROM messages
	WHERE from_user_id = user_id_to_delete OR
			to_user_id = user_id_to_delete;

	DELETE  FROM likes
	WHERE user_id = user_id_to_delete;

	DELETE FROM profiles
	WHERE user_id = user_id_to_delete;

	DELETE FROM media
	WHERE user_id = user_id_to_delete;

	DELETE FROM users
	WHERE id = user_id_to_delete;
COMMIT;
END//

DELIMITER ;

/*	3*.  Написать триггер, который проверяет новое появляющееся сообщество. Длина названия сообщества (поле name)
	должна быть не менее 5 символов. Если требование не выполнено, то выбрасывать исключение с пояснением.	*/
DROP VIEW view_males_bb;

DROP TRIGGER IF EXISTS check_communities_name;

DELIMITER //

CREATE TRIGGER IF NOT EXISTS check_communities_name
BEFORE INSERT ON communities
FOR EACH ROW
BEGIN
    IF (CHAR_LENGTH(NEW.communities.name) < 5) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Название сообщества должно быть более 5 символов';
    END IF;
END//

DELIMITER ;

-- Проверка?

SELECT delete_user_by_id(4);

CALL f_delete_user_by_id(5);

SELECT * FROM users;