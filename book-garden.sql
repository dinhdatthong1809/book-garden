/* Tạo cơ sở dữ liệu */
USE master
GO

IF EXISTS (SELECT 1 FROM SYS.DATABASES WHERE name = 'BookGarden')
	DROP DATABASE BookGarden
GO

CREATE DATABASE BookGarden
GO

USE BookGarden
GO

/* Tạo bảng */
CREATE TABLE CATEGORY
(
	id				INT IDENTITY (1, 1),
	name			NVARCHAR(50),
	description		NTEXT,
	version			INT,

	CONSTRAINT PK_Category PRIMARY KEY (id)
)
GO

CREATE TABLE BOOKSHELF
(
	id				INT IDENTITY (1, 1),
	location_name	NVARCHAR(256) NOT NULL,
	max_storage		INT CHECK(max_storage > 0),
	description     NVARCHAR(256),
	version			INT,

	CONSTRAINT PK_Bookshelf PRIMARY KEY (id)
)
GO

CREATE TABLE AUTHOR
(
	id				INT IDENTITY (1, 1),
	full_name		NVARCHAR(50) NOT NULL,
	date_of_birth	DATE,
	date_of_death	DATE,
	image			NVARCHAR(256),
	introduce		NVARCHAR(MAX),
	created_date	DATE,
	version			INT,

	CONSTRAINT PK_Author PRIMARY KEY (id)
)
GO

CREATE TABLE PUBLISHER
(
	id				INT IDENTITY (1, 1),
	name			NVARCHAR(256) NOT NULL,
	phone_number	VARCHAR(13),
	email			VARCHAR(100) NOT NULL,
	address			NVARCHAR(200),
	introduce		NVARCHAR(MAX),
	created_date	DATE,
	version			INT,

	CONSTRAINT PK_Publisher PRIMARY KEY (id)
)
GO

CREATE TABLE BOOK
(
	id					INT IDENTITY (1, 1),
	code				VARCHAR(50),
	title				NVARCHAR(100) NOT NULL,
	page_num			INT,
	amount				INT,
	publisher_id		INT,
	release_year    	INT,
	sell_price			MONEY,
	image				NVARCHAR(256),
	bookshelf_id		INT,
	rentable			BIT DEFAULT 1,
	buyable             BIT DEFAULT 1,
	rent_price			MONEY,
	description			NVARCHAR(256),
	introduce			NVARCHAR(256),
	created_date		DATE,
	version				INT,
    
	CONSTRAINT PK_Book				PRIMARY KEY (id),
	CONSTRAINT FK_Book_BookShelf_id	FOREIGN KEY (bookshelf_id) REFERENCES BOOKSHELF(id) ON UPDATE CASCADE,
	CONSTRAINT FK_Book_Publisher_id FOREIGN KEY (publisher_id) REFERENCES PUBLISHER(id) ON UPDATE CASCADE
)
GO

CREATE TABLE BOOK_CATEGORY
(
	book_id     INT,
	category_id INT,

	CONSTRAINT PK_BookCategory              PRIMARY KEY (book_id, category_id),
	CONSTRAINT FK_BookCategory_BookId		FOREIGN KEY (book_id) REFERENCES BOOK(id),
	CONSTRAINT FK_BookCategory_CategoryId	FOREIGN KEY (category_id) REFERENCES CATEGORY(id)
)
GO

CREATE TABLE BOOK_AUTHOR 
(
	book_id		INT,
	author_id	INT,
	version		INT,

	CONSTRAINT PK_BookAuthor			PRIMARY KEY (book_id, author_id),
	CONSTRAINT FK_BookAuthor_BookId		FOREIGN KEY (book_id) REFERENCES BOOK(id),
	CONSTRAINT FK_BookAuthor_AuthorId	FOREIGN KEY (author_id) REFERENCES AUTHOR(id)
)
GO

CREATE TABLE BOOK_PUBLISHER
(
	book_id			INT,
	publisher_id	INT,
	version			INT,

	CONSTRAINT PK_BookPublisher				PRIMARY KEY (book_id, publisher_id),
	CONSTRAINT FK_BookPublisher_BookId		FOREIGN KEY (book_id) REFERENCES BOOK(id),
	CONSTRAINT FK_BookPublisher_PublisherId FOREIGN KEY (publisher_id) REFERENCES PUBLISHER(id)
)
GO

CREATE TABLE CUSTOMER
(
	id				INT IDENTITY (1, 1),
    username		VARCHAR(100) UNIQUE NOT NULL,
	password		VARCHAR(100) NOT NULL,
	full_name		NVARCHAR(50),
	date_of_birth	DATE,
	email			VARCHAR(50),
	phone_number	VARCHAR(14),
	sex				BIT,
	is_active		BIT,
	created_date	DATE,
	version			INT,

	CONSTRAINT PK_Customer PRIMARY KEY (id),
)
GO

CREATE TABLE EMPLOYEE
(
	id              INT IDENTITY(1, 1),
	username		VARCHAR(50) UNIQUE NOT NULL,
	password		VARCHAR(50) NOT NULL,
	full_name		NVARCHAR(50) NOT NULL,
	email			VARCHAR(50),
	ident_number	VARCHAR(12),
	phone_number	VARCHAR(14) NOT NULL,
	image			NVARCHAR(256),
	sex				BIT,
	role			INT NOT NULL,
	is_active		BIT,
	created_date	DATE DEFAULT(GETDATE()),
	version			INT,

	CONSTRAINT PK_Admin PRIMARY KEY (id),
)
GO

CREATE TABLE STORAGE
(
	id				INT IDENTITY(1, 1),
	employee_id		INT NOT NULL,
	description		NVARCHAR(256),
	created_date	DATE DEFAULT(GETDATE()),
	version			INT,

	CONSTRAINT PK_Storage			    PRIMARY KEY (id),
	CONSTRAINT FK_Storage_EmployeeId	FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(id) ON UPDATE CASCADE
)
GO

CREATE TABLE STORAGE_DETAIL
(
	storage_id	INT,
	book_id		INT,
	amount		INT CHECK (amount > 0),
	price		MONEY,

	CONSTRAINT PK_StorageDetail				PRIMARY KEY (storage_id, book_id),
	CONSTRAINT FK_StorageDetail_StoreageId	FOREIGN KEY (storage_id) REFERENCES STORAGE(id) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_StorageDetail_BookId		FOREIGN KEY (book_id) REFERENCES BOOK(id) ON UPDATE CASCADE
)
GO

CREATE TABLE ORDER_RENT
(
	id				INT IDENTITY(1, 1),
	customer_id		INT,
	employee_id		INT, 
	cost_rent		MONEY,
	cost_expiration MONEY,
	expiration_day	SMALLINT,
	created_date	DATE,
	returned_date	DATE,
	status			INT,
	version			INT,

	CONSTRAINT PK_OrderRent			    PRIMARY KEY (id),
	CONSTRAINT FK_OrderRent_CustomerId	FOREIGN KEY (customer_id) REFERENCES CUSTOMER(id) ON UPDATE CASCADE,
	CONSTRAINT FK_OrderRent_EmployeeId	FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(id) ON UPDATE CASCADE
)
GO 

CREATE TABLE ORDER_RENT_DETAIL
(
	order_rent_id	INT ,
	book_id			INT,
	amount			INT NOT NULL,
	price			MONEY,

	CONSTRAINT PK_OrderRentDetail				PRIMARY KEY (order_rent_id, book_id),
	CONSTRAINT FK_OrderRentDetail_OrderRentId	FOREIGN KEY (order_rent_id) REFERENCES ORDER_RENT(id),
	CONSTRAINT FK_OrderRentDetail_BookId		FOREIGN KEY (book_id) REFERENCES Book(id)
)
GO

CREATE TABLE ORDER_SELL
(
	id				INT IDENTITY(1, 1),
	customer_id		INT,
	employee_id		INT,
	date_created	DATE,
	version			INT,

	CONSTRAINT PK_OrderSell             PRIMARY KEY (id),
	CONSTRAINT FK_OrderSell_CustomerId  FOREIGN KEY (customer_id) REFERENCES CUSTOMER(id) ON UPDATE CASCADE,
	CONSTRAINT FK_OrderSell_EmployeeId  FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(id) ON UPDATE CASCADE
)
GO

CREATE TABLE ORDER_SELL_DETAIL
(
	order_sell_id	INT NOT NULL,
	book_id			INT NOT NULL,
	amount			INT NOT NULL,
	price			MONEY NOT NULL,

	CONSTRAINT PK_OrderSellDetail			PRIMARY KEY (order_sell_id,book_id),
	CONSTRAINT FK_OrderSellDetail_OrderId	FOREIGN KEY (order_sell_id) REFERENCES ORDER_SELL(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_OrderSellDetail_BookId	FOREIGN KEY (book_id) REFERENCES BOOK(id) ON UPDATE CASCADE,
)
GO

CREATE FUNCTION dbo.fn_checkOrderRentIdExisted(@orderRentId INT) RETURNS INT
AS
BEGIN
    RETURN (SELECT 1 FROM ORDER_RENT WHERE ORDER_RENT.id = @orderRentId)
END
GO

CREATE TABLE BOOK_LOST
(
	id				INT CHECK (dbo.fn_checkOrderRentIdExisted(id) = 1),
	employee_id		INT,
	cost_lost		SMALLMONEY,
	created_date	DATE,
	version			INT,

	CONSTRAINT PK_BookLost				PRIMARY KEY (id),
	CONSTRAINT fk_LostBook_OrderRentId	FOREIGN KEY (id) REFERENCES ORDER_RENT(id) ON UPDATE CASCADE,
	CONSTRAINT fk_LostBook_EmployeeId	FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(id),
)
GO

CREATE TABLE BOOK_LOST_DETAIL
(
	book_lost_id	INT,
	book_id			INT NOT NULL,
	amount			INT NOT NULL CHECK (amount > 0),
	cost			MONEY,

	CONSTRAINT PK_BookLostDetail				PRIMARY KEY (book_lost_id, book_id),
	CONSTRAINT FK_BookLostDetail_OrderRentId	FOREIGN KEY (book_lost_id) REFERENCES BOOK_LOST(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_BookLostDetail_BookId			FOREIGN KEY (book_id) REFERENCES BOOK(id) ON UPDATE CASCADE
)
GO

CREATE TABLE ADDRESS
(
	id		INT IDENTITY (1, 1),
	name	NVARCHAR(100),
	address NVARCHAR(256),

	CONSTRAINT PK_Address PRIMARY KEY (id),
)
GO

CREATE TABLE CUSTOMER_ADDRESS
(
	customer_id INT,
	address_id  INT,

	CONSTRAINT PK_UserAddress               PRIMARY KEY (customer_id, address_id),
    CONSTRAINT FK_UserAddress_CustomerId    FOREIGN KEY (customer_id) REFERENCES CUSTOMER(id),
    CONSTRAINT FK_UserAddress_AddressId     FOREIGN KEY (address_id) REFERENCES ADDRESS(id),
)
GO

CREATE TABLE SHIPPING_STATUS
(
	id			INT IDENTITY (1, 1),
	name		NVARCHAR(100),
	description NVARCHAR(256),

	CONSTRAINT PK_ShippingStatus PRIMARY KEY (id),
)
GO

CREATE TABLE ORDER_SHIPPING
(
	id                      INT IDENTITY (100, 1),
	order_sell_id			INT,
	order_rent_id			INT,
	user_id					INT,
	employee_id				INT,
	address_id				INT,
	status_id				INT,
	employee_note   	    NVARCHAR(256),
	user_note   	    	NVARCHAR(256),
	
	CONSTRAINT PK_OrderShipping					PRIMARY KEY (id),
	CONSTRAINT FK_OrderShipping_OrderSellId		FOREIGN KEY (order_sell_id) REFERENCES ORDER_SELL(id),
	CONSTRAINT FK_OrderShipping_OrderRentId		FOREIGN KEY (order_rent_id) REFERENCES ORDER_RENT(id),
	CONSTRAINT FK_OrderShipping_UserId			FOREIGN KEY (user_id) REFERENCES CUSTOMER(id),
	CONSTRAINT FK_OrderShipping_EmployeeId		FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(id),
	CONSTRAINT FK_OrderShipping_AddressId		FOREIGN KEY (address_id) REFERENCES ADDRESS(id),
	CONSTRAINT FK_OrderShipping_StatusId		FOREIGN KEY (status_id) REFERENCES SHIPPING_STATUS(id),
)
GO

CREATE TABLE RATING_SHIPPING 
(
	order_shipping_id	INT,
	user_id				INT,
	employee_id			INT,
	user_comment		NVARCHAR(256),
	employee_comment	NVARCHAR(256),
	stars				TINYINT CHECK (stars > 0 AND stars <= 5),

	CONSTRAINT PK_RatingShipping					PRIMARY KEY (order_shipping_id),
	CONSTRAINT FK_RatingShipping_OrderShippingId	FOREIGN KEY (order_shipping_id) REFERENCES ORDER_SHIPPING(id),
	CONSTRAINT FK_RattingShipping_CustomerId		FOREIGN KEY (user_id) REFERENCES CUSTOMER(id),
	CONSTRAINT FK_RattingShipping_EmployeeId		FOREIGN KEY (employee_id) REFERENCES EMPLOYEE(id),
)
GO

/* Nhập dữ liệu */
INSERT INTO BOOKSHELF (location_name, max_storage, description)
VALUES (N'Kệ A1', 100, N''),
       (N'Kệ A4', 90, N''),
       (N'Kệ A2', 120, N''),
       (N'Kệ A3', 130, N''),
       (N'Kệ A5', 100, N''),
       (N'Kệ A6', 100, N''),
       (N'Kệ A7', 120, N''),
       (N'Kệ A8', 110, N'')
GO

INSERT INTO CATEGORY (name, description)
VALUES (N'Kỉ Niệm HÀ NỘI tôi', '71 trang'),
       (N'Đi tìm ngày xưa', ''),
       (N'Sống đúng', '')
GO

INSERT INTO AUTHOR (full_name, date_of_birth, image, introduce, created_date)
VALUES (N'Đỗ Văn Hoàng', GETDATE(), N'', N'Tác giả này tên là Đỗ Văn Hoàng.', GETDATE()),
       (N'Trần Đăng Khoa', GETDATE(), N'', N'Tác giả này nổi tiếng với các bài văn dành cho trẻ em', GETDATE()),
       (N'Lê Văn Thuyết', GETDATE(), N'', N'', GETDATE())
GO

INSERT INTO PUBLISHER (name, phone_number, email, introduce, created_date)
VALUES (N'BXB Trẻ', '0376546521', 'contact@nxbtre.com', N'Đây là nhà xuất bản khá trẻ :v', GETDATE()),
       (N'BXB Nhi Đồng', '0186224665', 'contact@nxbnhidong.com', N'Đây là nhà xuất bản nhi đồng', GETDATE())
GO

INSERT INTO BOOK (code, title, page_num, amount, publisher_id, release_year, sell_price, image, bookshelf_id, description, created_date)
VALUES ('GH12', N'TÔI THẤY MÌNH CÒN TRẺ', 274, 100, 1, 2017, 100000, N'', 1, '', '11/05/2018'),
       ('JH42', N'TÔI THẤY HOA VÀNG TRÊN CỎ XANH', 274, 120, 2, 2017, 100000, N'', 2, '', '11/06/2018')
GO

INSERT INTO CUSTOMER(username, password, full_name, date_of_birth, email, phone_number, is_active)
VALUES ('haond', '123', N'Nguyễn Văn Hao', '1999-06-11', 'teonv@gmail.com', '0623457413', 1),
       ('nopt12', '123', N'Nguyễn Thị Nở', '1993-03-11', 'nopt@gmail.com', '054632179', 0)
GO

INSERT INTO EMPLOYEE (username, password, full_name, email, phone_number, role, created_date, is_active)
VALUES ('quanly', '123', N'Lý Tiểu Long', 'lytieulong@gmail.com', '01682439314', 1, '07/05/2015', 0),
       ('truongphong', '123', N'Nguyễn Đại Trân', 'ngueyndairan@gmail.com', '0123456789', 1, '06/05/2012', 1)
GO

INSERT INTO ORDER_SELL (customer_id, employee_id, date_created)
VALUES (1, 1, GETDATE()),
       (2, 1, GETDATE())
GO


INSERT INTO ORDER_SELL_DETAIL (order_sell_id, book_id, amount, price)
VALUES (1, 1, 3, 200000),
       (1, 2, 2, 300000)
GO

INSERT INTO ORDER_RENT (customer_id, employee_id, cost_rent, cost_expiration, expiration_day, created_date, returned_date, status)
VALUES (1, 1, 5000, 1000, 7, GETDATE(), NULL, 0),
       (2, 2, 5000, 1000, 7, GETDATE(), GETDATE(), 1)
GO

INSERT INTO ORDER_RENT_DETAIL (order_rent_id, book_id, amount, price)
VALUES (1, 'GH12', 3, 300000),
       (2, 'JH42', 4, 400000),
       (2, 'GH12', 2, 400000)
GO

INSERT INTO STORAGE (employee_id, description, created_date)
VALUES (1, N'Không ghi chú gì hết', GETDATE())
GO

INSERT INTO STORAGE_DETAIL (storage_id, book_id, amount, price)
VALUES (1, 'GH12', 90, 250000),
       (1, 'JH42', 50, 180000)
GO

/* Tạo người dùng */
-- Tạo tài khoản đăng nhập
USE MASTER
IF EXISTS (SELECT name FROM SYS.SERVER_PRINCIPALS WHERE name = 'book_garden_operator')
    BEGIN
        DROP LOGIN book_garden_operator
    END
GO
CREATE LOGIN book_garden_operator WITH PASSWORD = 'Bookgarden_001', DEFAULT_DATABASE = BookGarden

-- Tạo người dùng cho tài khoản đăng nhập
USE BookGarden
IF EXISTS (SELECT name FROM SYS.DATABASE_PRINCIPALS WHERE name = 'book_garden_operator')
    BEGIN
        DROP USER book_garden_operator
    END
GO
CREATE USER book_garden_operator FOR LOGIN book_garden_operator

-- Thêm vai trò cho người dùng
USE BookGarden
ALTER ROLE db_owner ADD MEMBER book_garden_operator;
