CREATE database home1;
Use home1;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL
);

CREATE TABLE Flowers (
    flower_id INT PRIMARY KEY,
    flower_name VARCHAR(50) NOT NULL,
    price INT,
    supplier_id INT,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

CREATE TABLE OrderItems (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    flower_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (flower_id) REFERENCES Flowers(flower_id)
);

INSERT INTO Customers (customer_id, name, email)
VALUES
(1, 'Dana', 'bseheda@kse.ua'),
(2, 'Nika', 'vanepska@kse.ua'),
(3, 'Nastya', 'nsyvak@kse.ua'),
(4, 'Vlad', 'vvlad@kse.ua'),
(5, 'Oleg', 'ooleg@kse.ua'),
(6, 'Ivan', 'ivolkov@kse.ua'),
(7, 'Anna', 'alebedeva@kse.ua'),
(8, 'Sergey', 'snikolaev@kse.ua'),
(9, 'Elena', 'epavlova@kse.ua'),
(10, 'Roman', 'rmorozov@kse.ua');

INSERT INTO Orders (order_id, customer_id, order_date)
VALUES
(11, 1, '2024-06-01'),
(22, 2, '2024-06-10'),
(33, 3, '2024-06-20'),
(44, 4, '2024-07-01'),
(55, 5, '2024-07-10'),
(66, 6, '2024-07-20'),
(77, 7, '2024-07-25'),
(88, 8, '2024-08-01'),
(99, 9, '2024-08-10'),
(100, 10, '2024-08-15');

INSERT INTO Suppliers (supplier_id, supplier_name)
VALUES
(111, 'flow_supp_1'),
(222, 'flow_supp_2'),
(333, 'flow_supp_3'),
(444, 'flow_supp_4'),
(555, 'flow_supp_5'),
(666, 'flow_supp_6'),
(777, 'flow_supp_7'),
(888, 'flow_supp_8'),
(999, 'flow_supp_9'),
(1010, 'flow_supp_10');

INSERT INTO Flowers (flower_id, flower_name, price, supplier_id)
VALUES
(1111, 'Rose', 12, 111),
(1112, 'Sunflower', 10, 111),
(1113, 'Orchid', 25, 222),
(1114, 'Daisy', 8, 222),
(1115, 'Lily', 14, 333),
(1116, 'Iris', 13, 333),
(1117, 'Peony', 20, 444),
(1118, 'Tulip', 15, 444),
(1119, 'Aster', 12, 555),
(1120, 'Carnation', 11, 555),
(1121, 'Chrysanthemum', 16, 666),
(1122, 'Lavender', 14, 666),
(1123, 'Hydrangea', 18, 777),
(1124, 'Freesia', 13, 777),
(1125, 'Daffodil', 9, 888);


INSERT INTO OrderItems (order_item_id, order_id, flower_id, quantity)
VALUES
(201, 11, 1111, 12),
(202, 22, 1112, 10),
(203, 33, 1113, 5),
(204, 44, 1114, 8),
(205, 55, 1115, 7),
(206, 66, 1116, 6),
(207, 77, 1117, 4),
(208, 88, 1118, 9),
(209, 99, 1119, 14),
(210, 100, 1120, 11),
(211, 11, 1121, 8),
(212, 22, 1122, 3),
(213, 33, 1123, 5),
(214, 44, 1124, 7),
(215, 55, 1125, 6);

SELECT *
	from Customers
	
SELECT *
	from Flowers
	
SELECT *
	from OrderItems
	
SELECT *
	from Orders
	
SELECT *
	from Suppliers
	
-- CTE
With My_table as(	
	SELECT
    c.name AS customer_name,
    o.order_id,
    o.order_date As date_of_order,
    f.flower_name AS flower,
    oi.quantity,
    f.price AS flower_price,
    s.supplier_name,
    COUNT(o.order_id) OVER (PARTITION BY c.customer_id) AS total_orders_per_custome
FROM
    Customers c
JOIN
    Orders o ON c.customer_id = o.customer_id
JOIN
    OrderItems oi ON o.order_id = oi.order_id
JOIN
    Flowers f ON oi.flower_id = f.flower_id
JOIN
    Suppliers s ON f.supplier_id = s.supplier_id
WHERE o.order_date BETWEEN '2024-07-01' AND '2024-08-01'
AND f.price < 20)

Select * from My_table 
ORDER BY date_of_order ASC;

-- UNION
SELECT supplier_id FROM Suppliers
UNION 
SELECT supplier_id FROM Flowers
ORDER BY supplier_id;

-- UNION ALL
SELECT supplier_id FROM Suppliers
UNION ALL
SELECT supplier_id FROM Flowers
ORDER BY supplier_id;


