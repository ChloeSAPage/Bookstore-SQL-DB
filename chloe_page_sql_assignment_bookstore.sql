-- This database is for a bookstore. It keeps track of book information, authors, customers, their purchases as well as stock.
-- This DB can be used to, manage purchaes and stock numbers, recommend new books to customers, send customers a newsletter or information on books, keep track of best selling authors.

CREATE DATABASE bookstore;
USE bookstore;

CREATE TABLE books (
	book_id INTEGER AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    author_id INTEGER NOT NULL,
    genre VARCHAR(55) NOT NULL,
    price INTEGER NOT NULL,
    publication_date DATE NOT NULL,
    CONSTRAINT PK_books PRIMARY KEY(book_id),
    CONSTRAINT CHK_price CHECK (price > 0)
);

CREATE TABLE authors (
	author_id INTEGER AUTO_INCREMENT,
    author_name VARCHAR(55) NOT NULL,
    nationality VARCHAR(55) NOT NULL,
    birth_year YEAR NOT NULL,
    CONSTRAINT PK_authors PRIMARY KEY(author_id)
);

CREATE TABLE customers (
	customer_id INTEGER AUTO_INCREMENT,
    customer_name VARCHAR(55) NOT NULL,
    email VARCHAR(55),
    phone_number VARCHAR(11),
    address VARCHAR(100), 
    CONSTRAINT PK_customers PRIMARY KEY(customer_id),
    CONSTRAINT CHK_email CHECK (email LIKE '%@%')
);

CREATE TABLE purchases (
	purchase_id INTEGER AUTO_INCREMENT,
    customer_id INTEGER NOT NULL,
    book_id INTEGER NOT NULL,
    purchase_date DATE NOT NULL,
    quantity INTEGER NOT NULL,
    total_price INTEGER NOT NULL,
    CONSTRAINT PK_purchases PRIMARY KEY(purchase_id)
);

CREATE TABLE stock(
	stock_id INTEGER AUTO_INCREMENT,
    book_id INTEGER NOT NULL UNIQUE,
    stock_quantity INTEGER,
    CONSTRAINT PK_stock_id PRIMARY KEY(stock_id)
);

-- DM COMMANDS
-- books
INSERT INTO books
(title, author_id, genre, price, publication_date)
VALUES
('Alices adventures in wonderland', 1, 'Fantasy', 7, '1885-11-01'),
('The Great Gatsby', 2, 'Fiction', 10, '1925-04-10'),
('To Kill a Mockingbird', 2, 'Fiction', 12, '1960-07-11'),
('1984', 4, 'Science Fiction', 9, '1949-06-08'),
('Pride and Prejudice', 5, 'Romance', 11, '1813-01-28'),
('The Catcher in the Rye', 6, 'Fiction', 8, '1951-07-16'),
('Harry Potter and the Sorcerers Stone', 7, 'Fantasy', 15, '1997-06-26'),
('The Hobbit', 8, 'Fantasy', 13, '1937-09-21'),
('The Da Vinci Code', 9, 'Thriller', 14, '2003-03-18');

-- authors
INSERT INTO authors
(author_name, nationality, birth_year)
VALUES
('Lewis Carroll', 'British', 1901),
('F. Scott Fitzgerald', 'American', 1902),
('Harper Lee', 'American', 1926),
('George Orwell', 'British', 1903),
('Jane Austen', 'British', 1903),
('J.D. Salinger', 'American', 1919),
('J.K. Rowling', 'British', 1965),
('J.R.R. Tolkien', 'British', 1904),
('Dan Brown', 'American', 1964);

-- customers
INSERT INTO customers
(customer_name, email, phone_number, address)
VALUES
('Alex Brown', 'alexbrown@books.com', '07123456578', '01 Book Street BK987'),
('Alice Johnson', 'alice@example.com', '07123456579', '123 Main St, Anytown, USA'),
('Bob Smith', 'bob@example.com', '07123456570', '456 Elm St, Othertown, USA'),
('Charlie Brown', 'charlie@example.com', '07123456571', '789 Oak St, Somewhere, USA'),
('David Davis', 'david@example.com', '07123456572', '246 Maple St, Nowhere, USA'),
('Emily White', 'emily@example.com', '07123456573', '369 Pine St, Nowhere, USA'),
('Frank Harris', 'frank@example.com', '07123456574', '482 Cedar St, Nowhere, USA'),
('Grace Taylor', 'grace@example.com', '07123456575', '605 Walnut St, Nowhere, USA'),
('Henry Lee', 'henry@example.com', '07123456576', '738 Birch St, Nowhere, USA');

-- purchases
INSERT INTO purchases
(customer_id , book_id , purchase_date, quantity, total_price)
VALUES
(1, 1, '2024-02-25', 10, 70),
(1, 2, '2024-03-20', 1, 10),
(2, 1, '2024-03-21', 2, 25),
(3, 5, '2024-03-22', 1, 9),
(4, 7, '2024-03-23', 1, 11),
(5, 3, '2024-03-24', 1, 8),
(6, 1, '2024-03-25', 1, 15),
(7, 6, '2024-03-26', 1, 13),
(8, 5, '2024-03-27', 1, 14);

INSERT INTO stock (book_id, stock_quantity)
VALUES 
  (1, 50),
  (2, 30),  
  (3, 40),  
  (5, 35),  
  (6, 25),  
  (7, 15),  
  (8, 10),  
  (9, 45);

-- Foreign Keys
ALTER TABLE books
ADD CONSTRAINT
FK_books_author
FOREIGN KEY(author_id)
REFERENCES authors(author_id);

ALTER TABLE purchases
ADD CONSTRAINT
FK_purchases_book
FOREIGN KEY(book_id)
REFERENCES books(book_id);

ALTER TABLE purchases
ADD CONSTRAINT
FK_purchases_customer
FOREIGN KEY(customer_id)
REFERENCES customers(customer_id);

ALTER TABLE stock
ADD CONSTRAINT
FK_book_id
FOREIGN KEY(book_id)
REFERENCES books(book_id);

-- -- Insert data
-- adding new books, authors and purchase
USE bookstore;

INSERT INTO authors
(author_name, nationality, birth_year)
VALUES
('Judith Viorst', 'American', 1931);

INSERT INTO books
(title, author_id, genre, price, publication_date)
VALUES
('Alexander and the terrible horrible no good very bad day', 10, 'humour', 10, '1972-06-16');

INSERT INTO stock
(book_id, stock_quantity)
VALUES 
(10, 50);

INSERT INTO purchases
(customer_id , book_id , purchase_date, quantity, total_price)
VALUES
(1, 10, '2024-03-27', 1, 10);

UPDATE stock
SET stock_quantity = 40
WHERE book_id = 10;


-- -- Get Data
-- find publication date of great gatsby
SELECT publication_date
FROM books
WHERE title = 'The Great Gatsby';

-- find all customer emails, can be used for sending deals
SELECT email
FROM customers
ORDER BY email;

-- find the purchase id where more than 1 book and less than 9 books were sold
SELECT purchase_id, quantity
FROM purchases
WHERE quantity > 1 AND NOT quantity > 9
ORDER BY quantity DESC;

-- Select all books that contain the word wonderland
SELECT title
FROM books
WHERE title LIKE '%wonderland%'
ORDER BY title;

-- select all authors who are british
SELECT author_name, birth_year
FROM authors
WHERE nationality = 'British'
ORDER BY birth_year;

-- -- Delete Data
DELETE FROM books
WHERE book_id = 4;

-- -- 2 Aggregate Functions
-- find how many books were sold per book_id
SELECT book_id, SUM(quantity) AS books_sold
FROM purchases
GROUP BY book_id
ORDER BY books_sold DESC; 

-- Find the average amount of books sold
SELECT AVG(quantity)
FROM purchases; 

-- -- Joins
-- Find who purchased what book and how many
SELECT  c.customer_name, b.title, p.quantity
FROM books b
INNER JOIN purchases p
ON b.book_id = p.book_id
INNER JOIN customers c
ON c.customer_id = p.customer_id
ORDER BY c.customer_name;

-- find how many books were sold per title
SELECT b.title, SUM(p.quantity) as total_sold
FROM purchases p
RIGHT OUTER JOIN books b
ON b.book_id = p.book_id
GROUP BY b.title
ORDER BY total_sold DESC;

-- -- Inbuilt Functions
-- Add new purchase
INSERT INTO purchases
(customer_id , book_id , purchase_date, quantity, total_price)
VALUES
(3, 10, CURDATE(), 1, 10);

-- pick random customer for prize draw!!
SELECT COUNT(customer_id) INTO @all_customers
FROM customers;

SET @rand_value = FLOOR(RAND()*(@all_customers)) + 1;

SELECT *
FROM customers
WHERE customer_id = @rand_value;

-- -- Procedure

DELIMITER //
CREATE PROCEDURE AddPurchase(
    P_customer_id INT,
    P_book_id INT,
    P_quantity INT,
    P_total_price INT
)
BEGIN
	INSERT INTO purchases
	(customer_id , book_id , purchase_date, quantity, total_price)
	VALUES
	(P_customer_id, P_book_id, CURDATE(), P_quantity, P_total_price);
    
    SELECT stock_quantity INTO @stock_quantity
	FROM stock
    WHERE book_id = P_book_id;
	    
    UPDATE stock
	SET stock_quantity = (@stock_quantity - P_quantity)
	WHERE book_id = P_book_id AND stock_quantity > P_quantity;
END//
DELIMITER ;

CALL AddPurchase(6, 9, 4, 89);
CALL AddPurchase(8, 1, 2, 20);
