-- 문제 풀이


use fish_shaped_bun_shop;

-- 문제 1번
INSERT INTO 
users(
	first_name,
    last_name,
    email,
    password,
    address,
    contact,
    gender
)
VALUES(
	"BANANA",
    "MILK",
    "banana123@banana.com",
    "ekfjabsgjb1l4",
    "oz-coding-school",
    "010-1234-5678",
    TRUE
);

-- 확인하기
SELECT * FROM users WHERE first_name="BANANA";



-- 문제 2번
UPDATE users
SET address="new-oz-coding-school"
WHERE id=11;

-- 확인하기
SELECT * FROM users WHERE id=11;


-- 문제 3번
-- sales_records 데이터 생성
INSERT INTO
sales_records(
	user_id
)
VALUE(
	11
);

-- 확인하기
SELECT * FROM sales_records;

SELECT * FROM products;

-- sales_items 데이터 생성
INSERT INTO
sales_items(
	sales_record_id,
    product_id,
    quantity
)
VALUES(
	3,
    (SELECT id FROM products WHERE name="Red Bean Bun"),
    3
);

INSERT INTO
sales_items(
	sales_record_id,
    product_id,
    quantity
)
VALUES(
	3,
    (SELECT id FROM products WHERE name="Fish Bun"),
    2
);

INSERT INTO
sales_items(
	sales_record_id,
    product_id,
    quantity
)
VALUES(
	3,
    (SELECT id FROM products WHERE name="Chocolate Bun"),
    5
);

-- 확인하기
SELECT * FROM sales_items;
SELECT * FROM raw_materials;



-- 문제 4번
INSERT INTO
order_records(
	user_id,
	raw_material_id,
    quantity
)
VALUES(
	3,
    1,
    5
);

INSERT INTO
order_records(
	user_id,
	raw_material_id,
    quantity
)
VALUES(
	3,
    3,
    5
);

INSERT INTO
order_records(
	user_id,
	raw_material_id,
    quantity
)
VALUES(
	3,
    7,
    150
);

-- 확인하기
SELECT * FROM order_records WHERE user_id=11;



-- 문제 5번
SELECT * FROM stocks;

INSERT INTO
daily_records(
	stock_id,
    change_quantity,
    change_type
)
VALUES(
	7,
    (SELECT quantity FROM stocks WHERE id = 7) + 150,
    "IN"
);

INSERT INTO
daily_records(
	stock_id,
    change_quantity,
    change_type
)
VALUES(
	1,
    (SELECT quantity FROM stocks WHERE id = 1) - 30,
    "OUT"
);

INSERT INTO
daily_records(
	stock_id,
    change_quantity,
    change_type
)
VALUES(
	5,
    (SELECT quantity FROM stocks WHERE id = 5) + 1000,
    "IN"
);

-- 확인하기
SELECT * FROM daily_records;


UPDATE stocks
SET quantity= quantity + 150
WHERE id = 7;

-- 확인하기
SELECT quantity FROM stocks WHERE id = 7; 



-- 문제 6번
SELECT 
    sr.id AS sales_record_id,
    sr.created_at,
    u.first_name,
    u.last_name,
    si.product_id,
    SUM(si.quantity) AS total_quantity,
    p.price
FROM 
    sales_items AS si
JOIN 
    sales_records AS sr ON si.sales_record_id = sr.id
JOIN 
    users AS u ON sr.user_id = u.id
JOIN 
    products AS p ON si.product_id = p.id
WHERE 
    u.id = 11
GROUP BY 
    si.product_id, sr.id, sr.created_at, u.first_name, u.last_name, p.price
ORDER BY 
    p.price DESC;