/* Задача 1
Создайте таблицу с мобильными телефонами, используя графический интерфейс.
Необходимые поля таблицы:
    product_name (название товара),
    manufacturer (производитель),
    product_count (количество),
    price (цена).
Заполните БД произвольными данными.
*/
-- создание таблицы
CREATE SCHEMA 'HW1';

CREATE TABLE 'HW1'.'cellphones' (
    'id' INT UNSIGNED NOT NULL AUTO_INCREMENT,
    'product_name' VARCHAR(45) NOT NULL,
    'manufacturer' VARCHAR(45) NOT NULL,
    'product_count' INT UNSIGNED NOT NULL,
    'price' DECIMAL(10) UNSIGNED NOT NULL,
    PRIMARY KEY ('id'));

-- наполнение таблицы
INSERT INTO `HW1`.`cellphones` (`manufacturer`, `product_name`, `product_count`, `price`)VALUES ('Apple', 'Iphone 5s', '3', '500.5');
INSERT INTO `HW1`.`cellphones` (`manufacturer`, `product_name`, `product_count`, `price`)VALUES ('Apple', 'Iphone 6plus', '3', '500.5');
INSERT INTO `HW1`.`cellphones` (`manufacturer`, `product_name`, `product_count`, `price`)VALUES ('Apple', 'Iphone 8', '1', '500.5');
INSERT INTO `HW1`.`cellphones` (`manufacturer`, `product_name`, `product_count`, `price`) VALUES ('Sony', 'Xperia', '5', '250.0');
INSERT INTO `HW1`.`cellphones` (`manufacturer`, `product_name`, `product_count`, `price`) VALUES ('ZTE', 'Blade', '2', '150.2');
INSERT INTO `HW1`.`cellphones` (`manufacturer`, `product_name`, `product_count`, `price`) VALUES ('Samsung', 'Note 10', '3', '850.0');
INSERT INTO `HW1`.`cellphones` (`manufacturer`, `product_name`, `product_count`, `price`) VALUES ('Samsung', 'Galaxy 10', '1', '950.0');

-- выборка данных
-- SELECT * from 'HW1'.'cellphones';

/* Задача 2
Напишите SELECT-запрос, который выводит название товара,
производителя и цену для товаров, количество которых превышает 2
*/

SELECT product_name, manufacturer, price from HW1.cellphones
    WHERE product_count > 2;

/* Задача 3
Выведите SELECT-запросом весь ассортимент товаров марки “Samsung”
*/

SELECT * from HW1.cellphones
where manufacturer = 'Samsung';

/* Задачи 4 
*               С помощью SELECT-запроса с оператором LIKE / REGEXP найти:
*/

-- 4.1.* Товары, в которых есть упоминание "Iphone"
SELECT * from HW1.cellphones where product_name LIKE '%Iphone%';

-- 4.2.* Товары, в которых есть упоминание "Samsung"
SELECT * from HW1.cellphones where product_name LIKE '%Samsung%';

-- 4.3.* Товары, в названии которых есть ЦИФРЫ
SELECT * from cellphones WHERE product_name LIKE '%[0-9]%'; -- Вроде должно работать но не хочет ((

-- var 2
SELECT * from cellphones WHERE product_name REGEXP '[0-9]';

-- var ugly
SELECT * from cellphones WHERE product_name LIKE '%0%' or product_name LIKE '%1%'
    or product_name LIKE '%2%' or product_name LIKE '%3%' or product_name LIKE '%4%'
    or product_name LIKE '%5%' or product_name LIKE '%6%' or product_name LIKE '%7%'
    or product_name LIKE '%8%' or product_name LIKE '%9%';

-- 4.4.* Товары, в названии которых есть ЦИФРА "8" 
SELECT * from cellphones WHERE product_name LIKE '%8%' OR product_name REGEXP '8';