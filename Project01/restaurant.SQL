DROP TABLE menus;
  
CREATE TABLE IF NOT EXISTS menus (
  menus_id INT UNIQUE,
  menus_name TEXT,
  menus_price INT,
  category_id INT
 );

INSERT INTO menus VALUES
  (1, "Hamburger", 78, 1),
  (2, "Cheeseburger", 159, 1),
  (3, "Beanburger", 67, 2),
  (4, "Salmon burger", 280, 3),
  (5, "Plantbase burger", 99, 2),
  (6, "Chicken burger", 89, 1),
  (7, "Mushroom burger", 69, 2),
  (8, "Shimp burger", 109, 3),
  (9, "hotdog", 59, 1),
  (10, "Waffle", 99, 4),
  (11, "Mashed potatoes", 59, 4),
  (12, "Lemon Soda", 49, 5),
  (13, "Kiwi juice", 39, 5);

SELECT * FROM menus;

-- category

DROP TABLE category;

CREATE TABLE IF NOT EXISTS category (
  category_id INT UNIQUE,
  category_name TEXT
  );

INSERT INTO category VALUES
  (1, "Meat"),
  (2, "Veggie"),
  (3, "Seafood"),
  (4, "Side dish"),
  (5, "Drink");

SELECT * FROM category;

-- membercard

DROP TABLE member;

CREATE TABLE IF NOT EXISTS member (
  card_id INT UNIQUE,
  card_name text );

INSERT INTO member VALUES
  (1, "Gold Member"),
  (2, "Silver Member"),
  (3, "Bronze Member");

SELECT * FROM member;

DROP TABLE customers;

CREATE TABLE IF NOT EXISTS customers (
  cus_id INT UNIQUE,
  cus_name TEXT,
  cus_country TEXT,
  card_id INT
);

INSERT INTO customers VALUES
  (1, "Piz", "England", 3),
  (2, "Prang", "Thailand", 1),
  (3, "Ari", "Singapore", 3),
  (4, "Nara", "Malaysia", 2),
  (5, "Yama", "China", 1),
  (6, "Tayla", "Thailand", 2),
  (7, "Ruby", "India", 3),
  (8, "Loli", "Thailand", 3),
  (9, "Pan", "Japan", 2),
  (10, "Paw", "Thailand", 3);

SELECT * FROM customers;

-- orders

DROP TABLE orders;

CREATE TABLE IF NOT EXISTS orders (
  ord_id INT UNIQUE,
  ord_date TIMESTAMP,
  cus_id INT,
  menus_id INT
);

INSERT INTO orders VALUES
  (1, "2023-01-25 11:30:45", 10, 1), 
  (2, "2023-01-25 11:30:46", 10, 11),
  (3, "2023-01-25 11:30:48", 10, 13),
  (4, "2023-01-25 15:18:04", 2, 9),
  (5, "2023-01-25 15:45:16", 5, 4),
  (6, "2023-01-25 19:23:50", 3, 2),
  (7, "2023-01-25 19:23:52", 3, 14),
  (8, "2023-01-26 12:37:30", 9, 8),
  (9, "2023-01-26 12:37:31", 9, 10),
  (10, "2023-01-26 12:37:33", 9, 13),
  (11, "2023-01-26 14:16:16", 6, 2),
  (12, "2023-01-26 17:58:01", 4, 6),
  (13, "2023-01-26 17:58:03", 4, 12),
  (14, "2023-01-27 13:08:19", 8, 3),
  (15, "2023-01-27 13:08:20", 8, 5),
  (17, "2023-01-27 13:08:21", 8, 7),
  (18, "2023-01-27 16:32:00", 1, 1),
  (19, "2023-01-27 16:32:02", 1, 13),
  (20, "2023-01-27 18:29:41", 7, 4),
  (21, "2023-01-27 18:29:42", 7, 8);

SELECT * FROM orders;

-- query 1
SELECT * FROM customers
WHERE cus_name LIKE 'P%';

-- query 2 where clause 
SELECT
  cus_id,
  cus_name,
  cus_country AS country
FROM customers
WHERE country = 'Japan';

-- query 3 join table
SELECT
  cus_id,
  cus_name,
  card_name
FROM customers AS cus
LEFT JOIN member AS me
ON cus.card_id = me.card_id;

-- query 4 join table
select 
  m.menus_name,
  ord.menus_id as orders_menus,
  m.menus_price
from menus as m 
 join orders as ord  
on m.menus_id = ord.menus_id
group by m.menus_name
order by ord.menus_id desc;

-- query 5  price Aggregate function 
SELECT 
    SUM (menus_price) as Total,
    MIN (menus_price) as Min_price,
    MAX (menus_price) as Max_price,
    COUNT (menus_price) as Count_price,
    AVG (menus_price) as Avg_price
FROM menus as Me
JOIN orders as ord
ON me.menus_id = ord.menus_id;

-- query 6 Sub Query

select 
  cus_name AS Name,
  cus_id AS id
From (Select *
from customers 
where cus_country = 'Thailand');



-- query 7 With
with cards_mem AS ( 
select * from member
where card_name = 'Gold Member'
), country_thai AS (
select * from customers
where cus_country = 'Thailand'
)
select * from  cards_mem c
join country_thai t on c.card_id= t.card_id;


-- query 8 Case
select
  menus_name as MenuName, 
  menus_price as Price ,
  CASE 
    WHEN category_id IN (1,2,3) THEN 'Food'
    WHEN category_id IN (5) THEN 'Beverage'
    ELSE 'Other'
  END as Category
From menus;
