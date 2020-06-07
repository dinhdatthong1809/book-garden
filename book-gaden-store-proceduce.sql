USE BookGarden
GO

/****** Object:  StoredProcedure  [sp_getOrderDetail]  Script Date: 7/17/2019 ******/
--Lấy ra thông tin mã sách, số lượng và giá sách dựa vào thông tin order truyền vào
CREATE PROC sp_getOrderDetail(@order_id INT)
AS BEGIN
	SELECT
		BOOK.ID AS book_id,
		ORDER_SELL_DETAIL.amount AS amount,
		ORDER_SELL_DETAIL.price AS price
	FROM BOOK
		JOIN ORDER_SELL_DETAIL ON BOOK.ID = ORDER_SELL_DETAIL.book_id
	WHERE
		ORDER_SELL_DETAIL.order_sell_id = @order_id
END
GO


/****** Object:  StoredProcedure  [sp_getCountBook]  Script Date: 7/17/2019 ******/
--Lấy về số lượng sách còn trong kho của sách có mã là @book_id
CREATE PROC sp_getCountBook(@book_id VARCHAR(50))
AS BEGIN
	SELECT
		amount AS amount
	FROM book
	WHERE id = @book_id
END
GO
/****** Object:  StoredProcedure  [sp_getCountBookSold]  Script Date: 7/17/2019 ******/
--Lấy về số lượng sách đã bán của sách có id là @book_id
CREATE PROC sp_getCountBookSold(@book_id VARCHAR(50))
AS BEGIN
	SELECT
		od.amount amount_sold
	FROM Book b
	join ORDER_SELL_DETAIL od ON b.ID = od.book_id
	WHERE b.id = @book_id
END
GO

/****** Object:  StoredProcedure  [sp_getCountBookBeingRented]  Script Date: 7/17/2019 ******/
--Lấy về số lượng sách "ĐANG" được thuê của sách có id là @book_id
CREATE PROC sp_getCountBookBeingRented(@book_id VARCHAR(50))
AS BEGIN
	SELECT
		SUM(rd.amount)
	FROM ORDER_RENT_DETAIL rd
		JOIN Book b ON b.ID = rd.book_id
		JOIN ORDER_RENT r ON r.ID = rd.order_rent_id
	WHERE r.status = 0 AND rd.book_id = @book_id
END
GO

/****** Object:  StoredProcedure  [sp_getRentBookDetail]  Script Date: 7/17/2019 ******/
--Từ id rentbook truyền vào, lấy ra các thông tin chi tiết của hóa đơn thuê sách
CREATE PROC sp_getRentBookDetail(@order_rent_id INT)
AS BEGIN
	SELECT
		BOOK.id book_id,
		ORDER_RENT_DETAIL.amount amount,
		ORDER_RENT_DETAIL.price price
	FROM BOOK
		JOIN ORDER_RENT_DETAIL ON BOOK.ID = ORDER_RENT_DETAIL.book_id
	WHERE ORDER_RENT_DETAIL.order_rent_id = @order_rent_id
END
GO

/****** Object:  StoredProcedure  [sp_getBookSoldByMonth]  Script Date: 7/17/2019 ******/
--Trả về thông tin thống kê sách đã bán được theo tháng
CREATE PROC sp_getBookSoldByMonth(@month INT)
AS BEGIN
	SELECT
		Book.ID book_id,
		COUNT(ORDER_SELL_DETAIL.amount) amount_sold
	FROM ORDER_SELL_DETAIL
		join Book ON Book.ID = ORDER_SELL_DETAIL.book_id
		join ORDER_SELL ON ORDER_SELL.ID = ORDER_SELL_DETAIL.order_sell_id
	WHERE MONTH(ORDER_SELL.Date_created) = @month
	GROUP BY Book.ID
END
GO



/****** Object:  StoredProcedure  [sp_getIncomeByMonth]  Script Date: 7/19/2019 ******/
--Trả về thông tin thống kê tiền sách thu được khi bán sách
CREATE PROC sp_getIncomeByMonth(@month INT)
AS BEGIN
	SELECT
		BOOK.id MaSach,
		SUM(ORDER_SELL_DETAIL.amount) amount_sold,
		SUM(ORDER_SELL_DETAIL.price * ORDER_SELL_DETAIL.amount) money_total
	FROM ORDER_SELL_DETAIL
		join BOOK ON ORDER_SELL_DETAIL.book_id = BOOK.id
		join ORDER_SELL ON ORDER_SELL_DETAIL.order_sell_id = ORDER_SELL.id
		WHERE MONTH(ORDER_SELL.Date_created) = @month
	GROUP BY BOOK.id, ORDER_SELL_DETAIL.price, ORDER_SELL_DETAIL.amount
END
GO

/****** Object:  StoredProcedure  [sp_getTotalRentbook]  Script Date: 8/03/2019 ******/
--Trả về tổng số sách đã thuê trong ORDER_RENT_DETAIL theo renbook_id
CREATE PROC sp_getTotalRentBook (@order_rent_id INT)
AS BEGIN
	SELECT
		SUM(amount)
	FROM ORDER_RENT_DETAIL
	WHERE order_rent_id = @order_rent_id
END
GO

/****** Object:  StoredProcedure  [sp_getTotalCostBookLost]  Script Date: 8/03/2019 ******/
--Trả về tổng số cost có trong LostBook theo renbook_id
CREATE PROC sp_getTotalCostBookLost (@book_lost_id INT)
AS BEGIN
	SELECT
		SUM(cost)
	FROM BOOK_LOST_DETAIL
	WHERE book_lost_id = @book_lost_id
END
GO

/****** Object:  StoredProcedure  [sp_getTotalCountBookLost]  Script Date: 8/03/2019 ******/
--Trả về tổng số sách đã mất theo renbook_id
CREATE PROC sp_getTotalCountBookLost (@book_lost_id INT)
AS BEGIN
	SELECT
		SUM(amount)
	FROM BOOK_LOST_DETAIL
	WHERE book_lost_id = @book_lost_id
END
GO

/****** Object:  StoredProcedure  [sp_getAmountBookRented]  Script Date: 8/03/2019 ******/
--Trả về tổng số sách của sách có @book_id đã thuê với đơn thuê có mã @rentbook_id
CREATE PROC sp_getAmountBookRented (@order_rent_id INT, @book_id VARCHAR(50))
AS BEGIN
	SELECT
		SUM(amount)
	FROM ORDER_RENT_DETAIL
	WHERE order_rent_id = @order_rent_id AND book_id = @book_id
END
GO

/****** Object:  StoredProcedure  [sp_getLostBookDetail]  Script Date: 8/03/2019 ******/
--Trả về thông tin chi tiết của LOST_BOOK_DETAIL theo rentbook_id
CREATE PROC sp_getLostBookDetail (@book_lost_id INT)
AS BEGIN
	SELECT
		book_id,
		amount,
		cost
	FROM BOOK_LOST_DETAIL
	WHERE book_lost_id = @book_lost_id
END
GO

/****** Object:  StoredProcedure  [sp_getLostBookDetail]  Script Date: 8/04/2019 ******/
--Trả về tổng số sách đã nhập trong hóa đơn nhập
CREATE PROC sp_getTotalCountBookOfStorage (@storage_id INT)
AS BEGIN
	SELECT
		SUM(amount)
	FROM STORAGE_DETAIL
	WHERE storage_id = @storage_id
END
GO

/****** Object:  StoredProcedure  [sp_getSumCountOrderSold]  Script Date: 8/07/2019 ******/
--Trả về tổng số lượng sách đã bán
CREATE PROC sp_getCountBookInOrder (@order_sell_id INT)
AS BEGIN
	SELECT
		SUM(amount)
	FROM ORDER_SELL_DETAIL
	WHERE order_sell_id = @order_sell_id
END
GO

/****** Object:  StoredProcedure  [sp_getSumPriceOrderSold]  Script Date: 8/07/2019 ******/
--Trả về tổng số lượng sách đã bán
CREATE PROC sp_getTotalPriceInOrder(@order_sell_id INT)
AS BEGIN
	SELECT
		SUM(price * amount)
	FROM ORDER_SELL_DETAIL
	WHERE order_sell_id = @order_sell_id
END
GO

/****** Object:  StoredProcedure  [sp_getTotalAmountOrderSellBook]  Script Date: 8/10/2019 ******/
--Trả về tổng số sách đã bán
CREATE PROC sp_getTotalAmountOrderSellBook
AS BEGIN
	SELECT
		SUM(amount)
	FROM ORDER_SELL_DETAIL
END
GO

/****** Object:  StoredProcedure  [sp_getClosestPriceStorageWithBook]  Script Date: 8/13/2019 ******/
--Trả về giá tiền nhập sách của sách có id truyền vào tại thời điểm gần nhất
CREATE PROC sp_getClosestPriceStorageWithBook (@bookId VARCHAR(50))
AS BEGIN
	SELECT TOP 1 sdt.price FROM STORAGE s, STORAGE_DETAIL sdt
	WHERE s.id = sdt.storage_id AND sdt.book_id = @bookId
	ORDER BY s.created_date DESC
END
GO

/****** Object:  StoredProcedure  [sp_getStatisticOverviewInMonth]  Script Date: 8/10/2019 ******/
--Trả về tổng tất cả các thứ cần thống ke :))
CREATE PROC sp_getStatisticOverviewInMonth
AS BEGIN
	DECLARE @totalOrder FLOAT = 0
	DECLARE @totalRent FLOAT = 0
	DECLARE @totalLost FLOAT = 0
	DECLARE @totalUser FLOAT = 0
	DECLARE @totalAddStorage FLOAT = 0
	DECLARE @totalIncome FLOAT = 0

	SELECT @totalOrder = SUM(ORDER_SELL_DETAIL.amount) FROM ORDER_SELL_DETAIL, [ORDER_SELL]
	WHERE ORDER_SELL_DETAIL.order_sell_id = [ORDER_SELL].id
	AND YEAR([ORDER_SELL].date_created) = YEAR(GETDATE())
	AND MONTH([ORDER_SELL].date_created) = MONTH(GETDATE())

	SELECT @totalRent = SUM(ORDER_RENT_DETAIL.amount) FROM ORDER_RENT_DETAIL, ORDER_RENT
	WHERE  ORDER_RENT_DETAIL.order_rent_id = ORDER_RENT.id
	AND YEAR(ORDER_RENT.created_date) = YEAR(GETDATE())
	AND MONTH(ORDER_RENT.created_date) = MONTH(GETDATE())

	SELECT @totalLost = SUM(BOOK_LOST_DETAIL.amount) FROM  BOOK_LOST_DETAIL, BOOK_LOST
	WHERE BOOK_LOST_DETAIL.book_lost_id = BOOK_LOST.id
	AND YEAR(BOOK_LOST.created_date) = YEAR(GETDATE())
	AND MONTH(BOOK_LOST.created_date) = MONTH(GETDATE())

	SELECT @totalUser = COUNT(CUSTOMER.id) FROM CUSTOMER
	WHERE YEAR(CUSTOMER.created_date) = YEAR(GETDATE())
	AND MONTH(CUSTOMER.created_date) = MONTH(GETDATE())

	SELECT @totalAddStorage = SUM(STORAGE_DETAIL.amount) FROM STORAGE_DETAIL, STORAGE
	WHERE STORAGE_DETAIL.storage_id = STORAGE.id
	AND YEAR(STORAGE.created_date) = YEAR(GETDATE())
	AND MONTH(STORAGE.created_date) = MONTH(GETDATE())

	DECLARE @totalSumOrder FLOAT = 0
	DECLARE @totalSumLost FLOAT = 0
	DECLARE @totalSumRentExpiration FLOAT = 0
	DECLARE @totalSumRent FLOAT = 0;
	DECLARE @totalSumMoneyStorage FLOAT = 0

	-- Tổng doanh thu bán sách
	SELECT @totalSumOrder = SUM(ORDER_SELL_DETAIL.amount*ORDER_SELL_DETAIL.price)
	FROM ORDER_SELL_DETAIL, [ORDER_SELL]
	WHERE ORDER_SELL_DETAIL.order_sell_id = [ORDER_SELL].id
	AND YEAR([ORDER_SELL].date_created) = YEAR(GETDATE())
	AND MONTH([ORDER_SELL].date_created) = MONTH(GETDATE())

	-- Tổng phí phạt mất sách
	SELECT @totalSumLost = SUM(BOOK_LOST_DETAIL.cost)
	FROM BOOK_LOST, BOOK_LOST_DETAIL
	WHERE BOOK_LOST_DETAIL.book_lost_id = BOOK_LOST.id
	AND YEAR(BOOK_LOST.created_date) = YEAR(GETDATE())
	AND MONTH(BOOK_LOST.created_date) = MONTH(GETDATE())

	--Lấy ra số tổng phí thuê sách
	SELECT @totalSumRent += cost_rent * SUM(amount)
	FROM ORDER_RENT JOIN ORDER_RENT_DETAIL
	ON ORDER_RENT_DETAIL.order_rent_id = ORDER_RENT.id
	WHERE YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = MONTH(GETDATE())
	GROUP BY order_rent_id, cost_rent

	--Lấy ra số tổng phí phạt khi thuê
	SELECT @totalSumRentExpiration += cost_expiration * SUM(amount) * (DATEDIFF(DAY, created_date, returned_date) - expiration_day)
	FROM ORDER_RENT JOIN ORDER_RENT_DETAIL
	ON ORDER_RENT_DETAIL.order_rent_id = ORDER_RENT.id
	WHERE status = 1 AND DATEDIFF(DAY, created_date, returned_date) > expiration_day
	AND YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = MONTH(GETDATE())
	GROUP BY order_rent_id, cost_expiration, created_date, returned_date, expiration_day

	--Lấy ra tổng chi phí khi nhập sách
	SELECT @totalSumMoneyStorage = SUM (price * amount)
	FROM STORAGE JOIN STORAGE_DETAIL
	ON STORAGE_DETAIL.storage_id = STORAGE.id
	WHERE YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = MONTH(GETDATE())

	SET @totalIncome = ISNULL(@totalSumOrder, 0) + ISNULL(@totalSumLost, 0) + ISNULL(@totalSumRentExpiration, 0) + ISNULL(@totalSumRent, 0) - ISNULL(@totalSumMoneyStorage, 0)

	SELECT @totalOrder AS [Total Order], @totalRent AS [Total Rent], @totalLost AS [Total Lost], @totalUser AS [Total User], @totalAddStorage AS [Total Book Storage], @totalIncome AS [Total imcome]
END
GO


/****** Object:  StoredProcedure  [sp_getStatisticOrderInMonth]  Script Date: 8/13/2019 ******/
--Trả về thông tin sách đã bán theo tháng // DROP PROC sp_getStatisticOrderInMonth EXEC sp_getStatisticOrderInMonth 0
CREATE PROC sp_getStatisticOrderInMonth (@month int)
AS BEGIN
	SET NOCOUNT ON
	DECLARE @bookId VARCHAR(50)
	DECLARE @bookTitle NVARCHAR(256)
	DECLARE @bookCategory NVARCHAR(256)
	DECLARE @bookAuthor NVARCHAR(256)
	DECLARE @bookCreatedDate DATE
	DECLARE @totalOrder SMALLINT = 0
	DECLARE @totalBookOrder SMALLINT = 0
	DECLARE @totalPriceOrder MONEY = 0

	DECLARE @tblStats TABLE
	(
		book_id VARCHAR(50),
		book_title NVARCHAR(256),
-- 		book_category NVARCHAR(256),
-- 		book_author NVARCHAR(256),
		book_createdDate DATE,
		totalOrder SMALLINT,
		totalBookOrder SMALLINT,
		totalPriceOrder MONEY
	)

	IF (@month != 0)
	BEGIN
		DECLARE cs CURSOR FOR SELECT book_id FROM ORDER_SELL JOIN ORDER_SELL_DETAIL
		ON ORDER_SELL_DETAIL.order_sell_id = ORDER_SELL.id
		WHERE YEAR(date_created) = YEAR(GETDATE()) AND MONTH(date_created) = @month
		GROUP BY book_id
	END
	ELSE
	BEGIN
		DECLARE cs CURSOR FOR SELECT book_id FROM ORDER_SELL JOIN ORDER_SELL_DETAIL
		ON ORDER_SELL_DETAIL.order_sell_id = ORDER_SELL.id
		WHERE YEAR(date_created) = YEAR(GETDATE())
		GROUP BY book_id
	END

	--duyệt list book vừa lấy ra được
	OPEN cs
	FETCH NEXT FROM cs INTO @bookId

	WHILE @@FETCH_STATUS = 0
	BEGIN
		--RESET số liệu
		SET @totalOrder = 0
		SET @totalBookOrder = 0
		SET @totalPriceOrder = 0

		IF (@month != 0)
		BEGIN
			--Tên sách
			SELECT @bookTitle = title
			FROM BOOK WHERE id = @bookId

-- 			--Thể loại
-- 			SELECT @bookCategory = name
-- 			FROM BOOK, CATEGORY
-- 			WHERE category_id = CATEGORY.id
-- 			AND BOOK.id = @bookId
--
-- 			--Tác giả
-- 			SELECT @bookAuthor = fullname FROM BOOK, AUTHOR
-- 			WHERE author_id = AUTHOR.id
-- 			AND BOOK.id = @bookId

			--Ngày nhập
			SELECT @bookCreatedDate = created_date
			FROM BOOK
			WHERE id = @bookId

			--Tổng đơn
			SELECT @totalOrder = COUNT(*)
			FROM ORDER_SELL JOIN ORDER_SELL_DETAIL
			ON ORDER_SELL_DETAIL.order_sell_id = ORDER_SELL.id
			WHERE book_id = @bookId
			AND YEAR(date_created) = YEAR(GETDATE()) AND MONTH(date_created) = @month

			--Tổng sách đã bán
			SELECT @totalBookOrder = SUM (amount)
			FROM ORDER_SELL JOIN ORDER_SELL_DETAIL
			ON ORDER_SELL_DETAIL.order_sell_id = ORDER_SELL.id
			WHERE book_id = @bookId
			AND YEAR(date_created) = YEAR(GETDATE()) AND MONTH(date_created) = @month
			GROUP BY book_id

			--Tiền thu được
			SELECT @totalPriceOrder = SUM(amount * price)
			FROM ORDER_SELL JOIN ORDER_SELL_DETAIL
			ON ORDER_SELL_DETAIL.order_sell_id = ORDER_SELL.id
			WHERE book_id = @bookId
			AND YEAR(date_created) = YEAR(GETDATE()) AND MONTH(date_created) = @month
			GROUP BY book_id
		END
		ELSE
		BEGIN
			--Tên sách
			SELECT @bookTitle = title
			FROM BOOK WHERE id = @bookId

-- 			--Thể loại
-- 			SELECT @bookCategory = category_title
-- 			FROM BOOK, CATEGORY
-- 			WHERE category_id = CATEGORY.id
-- 			AND BOOK.id = @bookId
--
-- 			--Tác giả
-- 			SELECT @bookAuthor = fullname FROM BOOK, AUTHOR
-- 			WHERE author_id = AUTHOR.id
-- 			AND BOOK.id = @bookId

			--Ngày nhập
			SELECT @bookCreatedDate = created_date
			FROM BOOK
			WHERE id = @bookId

			--Tổng đơn
			SELECT @totalOrder = COUNT(*)
			FROM ORDER_SELL JOIN ORDER_SELL_DETAIL
			ON ORDER_SELL_DETAIL.order_sell_id = ORDER_SELL.id
			WHERE book_id = @bookId
			AND YEAR(date_created) = YEAR(GETDATE())

			--Tổng sách đã bán
			SELECT @totalBookOrder = SUM (amount)
			FROM ORDER_SELL JOIN ORDER_SELL_DETAIL
			ON ORDER_SELL_DETAIL.order_sell_id = ORDER_SELL.id
			WHERE book_id = @bookId
			AND YEAR(date_created) = YEAR(GETDATE())
			GROUP BY book_id

			--Tiền thu được
			SELECT @totalPriceOrder = SUM(amount * price)
			FROM ORDER_SELL JOIN ORDER_SELL_DETAIL
			ON ORDER_SELL_DETAIL.order_sell_id = ORDER_SELL.id
			WHERE book_id = @bookId
			AND YEAR(date_created) = YEAR(GETDATE())
			GROUP BY book_id
		END


		--Thêm dữ liệu vào bảng thống kê
-- 		INSERT @tblStats( book_id , book_title , book_category , book_author , book_createdDate , totalOrder , totalBookOrder , totalPriceOrder)
-- 		VALUES (@bookId, @bookTitle, @bookCategory, @bookAuthor, @bookCreatedDate, @totalOrder, @totalBookOrder, @totalPriceOrder)

		INSERT @tblStats( book_id, book_title, book_createdDate, totalOrder, totalBookOrder, totalPriceOrder)
		VALUES (@bookId, @bookTitle,  @bookCreatedDate, @totalOrder, @totalBookOrder, @totalPriceOrder)

		FETCH NEXT FROM cs INTO @bookId
	END

	CLOSE cs
	DEALLOCATE cs

	SELECT * FROM @tblStats
END
GO




/****** Object:  StoredProcedure  [sp_getStatisticRentbookInMonth]  Script Date: 8/13/2019 ******/
--Trả về thông tin sách thuê theo tháng
CREATE PROCEDURE sp_getStatisticRentbookInMonth (@month SMALLINT)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @book_id VARCHAR(50)
	DECLARE @book_title NVARCHAR(256)
	DECLARE	@amount_total INT = 0
	DECLARE	@amount_returned INT = 0
	DECLARE	@amount_renting INT = 0
	DECLARE	@amount_expiration INT = 0

	DECLARE @tblStats TABLE
	(
		book_id VARCHAR(50),
		book_title NVARCHAR(256),
		amount_total INT,
		amount_returned INT,
		amount_renting INT,
		amount_expiration INT
	)
	--Tạo con trỏ duyệt từng sách có trong phần thuê sách
	IF (@month != 0) -- Nếu @month khác 0 thì duyệt lấy mã sách thuê theo tháng @month
		DECLARE cs  CURSOR FOR SELECT DISTINCT b.id
		FROM BOOK b, ORDER_RENT rb, ORDER_RENT_DETAIL dt
		WHERE b.id = dt.book_id AND rb.id = dt.order_rent_id
		AND YEAR(rb.created_date) = YEAR(GETDATE()) AND MONTH(rb.created_date) = @month
	ELSE-- Nếu @month = 0 thì duyệt lấy mã sách thuê trong cả năm
		DECLARE cs  CURSOR FOR SELECT DISTINCT b.id
		FROM BOOK b, ORDER_RENT rb, ORDER_RENT_DETAIL dt
		WHERE b.id = dt.book_id AND rb.id = dt.order_rent_id
		AND YEAR(rb.created_date) = YEAR(GETDATE())

	OPEN cs
	FETCH NEXT FROM cs INTO @book_id

	--Tiến hành lặp danh sách sách thuê và insert dữ liệu thống kê vào tblStats
	WHILE @@FETCH_STATUS = 0
	BEGIN
		-- Set giá trị các biến trở về mặc định
		SET	@amount_total = 0
		SET	@amount_returned = 0
		SET	@amount_renting = 0
		SET	@amount_expiration = 0

		IF (@month != 0)
		BEGIN
			--Tên sách
			SELECT @book_title = title FROM BOOK WHERE id = @book_id

			--Tổng số lượng đã thuê
			SELECT @amount_total = SUM(rdt.amount)
			FROM ORDER_RENT_DETAIL rdt JOIN ORDER_RENT
			ON ORDER_RENT.id = rdt.order_rent_id
			WHERE rdt.book_id = @book_id
			AND YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
			GROUP BY rdt.book_id

			--Tổng số sách đã trả
			SELECT @amount_returned = SUM(amount)
			FROM ORDER_RENT_DETAIL JOIN ORDER_RENT
			ON ORDER_RENT.id = ORDER_RENT_DETAIL.order_rent_id
			WHERE book_id = @book_id
			AND YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
			AND status = 1
			GROUP BY book_id

			--Tổng số sách đang còn thuê
			SELECT @amount_renting = SUM(amount)
			FROM ORDER_RENT JOIN ORDER_RENT_DETAIL
			ON ORDER_RENT_DETAIL.order_rent_id = ORDER_RENT.id
			WHERE book_id = @book_id
			AND status = 0
			AND YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
			GROUP BY book_id

			--Tổng số sách đang quá hạn
			SELECT @amount_expiration = SUM(amount)
			FROM ORDER_RENT JOIN ORDER_RENT_DETAIL
			ON ORDER_RENT_DETAIL.order_rent_id = ORDER_RENT.id
			WHERE book_id = @book_id
			AND status = 0
			AND DATEDIFF(DAY, created_date, GETDATE()) > expiration_day
			AND YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
			GROUP BY book_id
		END
		ELSE
		BEGIN
			--Tên sách
			SELECT @book_title = title FROM BOOK WHERE id = @book_id

			--Tổng số lượng đã thuê
			SELECT @amount_total = SUM(rdt.amount)
			FROM ORDER_RENT_DETAIL rdt JOIN ORDER_RENT
			ON ORDER_RENT.id = rdt.order_rent_id
			WHERE rdt.book_id = @book_id
			AND YEAR(created_date) = YEAR(GETDATE())
			GROUP BY rdt.book_id

			--Tổng số sách đã trả
			SELECT @amount_returned = SUM(amount)
			FROM ORDER_RENT_DETAIL JOIN ORDER_RENT
			ON ORDER_RENT.id = ORDER_RENT_DETAIL.order_rent_id
			WHERE book_id = @book_id
			AND YEAR(created_date) = YEAR(GETDATE())
			AND status = 1
			GROUP BY book_id

			--Tổng số sách đang còn thuê
			SELECT @amount_renting = SUM(amount)
			FROM ORDER_RENT JOIN ORDER_RENT_DETAIL
			ON ORDER_RENT_DETAIL.order_rent_id = ORDER_RENT.id
			WHERE book_id = @book_id
			AND status = 0
			AND YEAR(created_date) = YEAR(GETDATE())
			GROUP BY book_id

			--Tổng số sách đang quá hạn
			SELECT @amount_expiration = SUM(amount)
			FROM ORDER_RENT JOIN ORDER_RENT_DETAIL
			ON ORDER_RENT_DETAIL.order_rent_id = ORDER_RENT.id
			WHERE book_id = @book_id
			AND status = 0
			AND DATEDIFF(DAY, created_date, GETDATE()) > expiration_day
			AND YEAR(created_date) = YEAR(GETDATE())
			GROUP BY book_id
		END

		--Thêm các dữ liệu đã thống kê vào bảng tblStats
		INSERT @tblStats( book_id, book_title, amount_total, amount_returned, amount_renting, amount_expiration)
		VALUES  (@book_id, @book_title, @amount_total, @amount_returned, @amount_renting, @amount_expiration)

		-- Đi đến dòng tiếp theo
		FETCH NEXT FROM cs INTO @book_id
	END


	--Đóng con trỏ
	CLOSE cs
	DEALLOCATE cs

	--Trả về bảng danh sách đã thống kê
	SELECT * FROM @tblStats
END
GO

/****** Object:  StoredProcedure  [sp_getStatisticBookLostInMonth]  Script Date: 8/13/2019 ******/
--Trả về thông tin sách mất theo tháng
CREATE PROCEDURE sp_getStatisticBookLostInMonth(@month SMALLINT)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @bookId VARCHAR(50)
	DECLARE @bookTitle NVARCHAR(256)
	DECLARE @totalBookLost SMALLINT = 0
	DECLARE @totalAmountBookLost SMALLINT = 0
	DECLARE @totalCost MONEY = 0

	DECLARE @tblStats TABLE
	(
		bookId VARCHAR(50),
		bookTitle NVARCHAR(256),
		totalBookLost SMALLINT,
		totalAmountBookLost SMALLINT,
		totalCost MONEY
	)

	--Tạo con trỏ duyệt qua các sách có trong khi báo mất
	IF (@month != 0)
	BEGIN
		DECLARE cs CURSOR FOR SELECT book_id
		FROM BOOK_LOST JOIN BOOK_LOST_DETAIL
		ON BOOK_LOST_DETAIL.book_lost_id = BOOK_LOST.id
		WHERE YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
		GROUP BY book_id
	END
	ELSE
	BEGIN
		DECLARE cs CURSOR FOR SELECT book_id
		FROM BOOK_LOST JOIN BOOK_LOST_DETAIL
		ON BOOK_LOST_DETAIL.book_lost_id = BOOK_LOST.id
		WHERE YEAR(created_date) = YEAR(GETDATE())
		GROUP BY book_id
	END

	--Tiến hành duyệt danh sách và lấy các con số thống kê
	OPEN cs
	FETCH NEXT FROM cs INTO @bookId

	WHILE @@FETCH_STATUS = 0
	BEGIN
		--Reset dữ liệu lại
		SET @totalBookLost = 0
		SET @totalAmountBookLost = 0
		SET @totalCost = 0

		IF (@month != 0)
		BEGIN
			--Tên sách
			SELECT @bookTitle = title FROM BOOK WHERE id = @bookId

			--Số đơn báo mất
			SELECT @totalBookLost = COUNT(*) FROM BOOK_LOST JOIN BOOK_LOST_DETAIL
			ON BOOK_LOST_DETAIL.book_lost_id = BOOK_LOST.id
			WHERE book_id = @bookId
			AND YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month

			--Tổng sách mất
			SELECT @totalAmountBookLost = SUM(amount) FROM BOOK_LOST JOIN BOOK_LOST_DETAIL
			ON BOOK_LOST_DETAIL.book_lost_id = BOOK_LOST.id
			WHERE book_id = @bookId
			AND YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month

			--Tổng tiền phạt thu được
			SELECT @totalCost = SUM(cost) FROM BOOK_LOST JOIN BOOK_LOST_DETAIL
			ON BOOK_LOST_DETAIL.book_lost_id = BOOK_LOST.id
			WHERE book_id = @bookId
			AND YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
		END
		ELSE
		BEGIN
			--Tên sách
			SELECT @bookTitle = title FROM BOOK WHERE id = @bookId

			--Số đơn báo mất
			SELECT @totalBookLost = COUNT(*) FROM BOOK_LOST JOIN BOOK_LOST_DETAIL
			ON BOOK_LOST_DETAIL.book_lost_id = BOOK_LOST.id
			WHERE book_id = @bookId
			AND YEAR(created_date) = YEAR(GETDATE())

			--Tổng sách mất
			SELECT @totalAmountBookLost = SUM(amount) FROM BOOK_LOST JOIN BOOK_LOST_DETAIL
			ON BOOK_LOST_DETAIL.book_lost_id = BOOK_LOST.id
			WHERE book_id = @bookId
			AND YEAR(created_date) = YEAR(GETDATE())

			--Tổng tiền phạt thu được
			SELECT @totalCost = SUM(cost) FROM BOOK_LOST JOIN BOOK_LOST_DETAIL
			ON BOOK_LOST_DETAIL.book_lost_id = BOOK_LOST.id
			WHERE book_id = @bookId
			AND YEAR(created_date) = YEAR(GETDATE())
		END

		--Thêm dữ liệu vừa thống kê được vào bảng tblStats
		INSERT @tblStats( bookId, bookTitle, totalBookLost, totalAmountBookLost, totalCost)
		VALUES  (@bookId, @bookTitle, @totalBookLost, @totalAmountBookLost, @totalCost)

		--Đi tới dòng tiếp theo
		FETCH NEXT FROM cs INTO @bookId
	END


	CLOSE cs
	DEALLOCATE cs

	SELECT * FROM @tblStats
END
GO

------------------------- save ---------------

/****** Object:  StoredProcedure  [sp_getStatisticUserInMonth]  Script Date: 8/13/2019 ******/
--Trả về thông tin thành viên người dùng theo tháng
CREATE PROCEDURE sp_getStatisticUserInMonth(@month SMALLINT)
AS
BEGIN
	SET NOCOUNT ON
	IF (@month != 0)
	BEGIN
		SELECT id, username, full_name, email, date_of_birth, created_date
		FROM CUSTOMER
		WHERE YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
	END
	ELSE
	BEGIN
		SELECT id, username, full_name, email, date_of_birth, created_date
		FROM CUSTOMER
		WHERE YEAR(created_date) = YEAR(GETDATE())
	END
END
GO

/****** Object:  StoredProcedure  [sp_getStatisticStorageInMonth]  Script Date: 8/13/2019 ******/
--Trả về thông tin sách nhập của tháng EXEC sp_getStatisticStorageInMonth 8
CREATE PROCEDURE sp_getStatisticStorageInMonth(@month SMALLINT)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @bookId VARCHAR(50)
	DECLARE @bookTitle NVARCHAR(256)
	DECLARE	@totalAmount SMALLINT = 0
	DECLARE @totalPrice MONEY = 0

	DECLARE @tblStats TABLE
	(
		bookId VARCHAR(50),
		bookTitle NVARCHAR(256),
		totalAmount SMALLINT,
		totalPrice MONEY
	)

	--Tạo con trỏ, lấy về danh sách book_id cần thống kê
	IF (@month != 0)
	BEGIN
		DECLARE cs CURSOR FOR SELECT book_id
		FROM STORAGE JOIN STORAGE_DETAIL
		ON STORAGE_DETAIL.storage_id = STORAGE.id
		WHERE YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
		GROUP BY book_id
	END
	ELSE
	BEGIN
		DECLARE cs CURSOR FOR SELECT book_id
		FROM STORAGE JOIN STORAGE_DETAIL
		ON STORAGE_DETAIL.storage_id = STORAGE.id
		WHERE YEAR(created_date) = YEAR(GETDATE())
		GROUP BY book_id
	END

	--Duyệt danh sách book_id
	OPEN cs
	FETCH NEXT FROM cs INTO @bookId

	WHILE @@FETCH_STATUS = 0
	BEGIN
		-- Reset dữ liệu các biến tạm
		SET	@totalAmount = 0
		SET @totalPrice = 0

		IF (@month != 0)
		BEGIN
			--Tên sách
			SELECT @bookTitle = title FROM BOOK
			WHERE id = @bookId

			--Tổng sách đã nhập
			SELECT @totalAmount = SUM (amount) FROM STORAGE JOIN STORAGE_DETAIL
			ON STORAGE_DETAIL.storage_id = STORAGE.id
			WHERE book_id = @bookId
			AND YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month

			--Tổng chi phí
			SELECT @totalPrice = SUM (amount * price) FROM STORAGE JOIN STORAGE_DETAIL
			ON STORAGE_DETAIL.storage_id = STORAGE.id
			WHERE book_id = @bookId
			AND YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
		END
		ELSE
		BEGIN
			--Tên sách
			SELECT @bookTitle = title FROM BOOK
			WHERE id = @bookId

			--Tổng sách đã nhập
			SELECT @totalAmount = SUM (amount) FROM STORAGE JOIN STORAGE_DETAIL
			ON STORAGE_DETAIL.storage_id = STORAGE.id
			WHERE book_id = @bookId
			AND YEAR(created_date) = YEAR(GETDATE())

			--Tổng chi phí
			SELECT @totalPrice = SUM (amount * price) FROM STORAGE JOIN STORAGE_DETAIL
			ON STORAGE_DETAIL.storage_id = STORAGE.id
			WHERE book_id = @bookId
			AND YEAR(created_date) = YEAR(GETDATE())
		END

		--Insert dữ liệu tìm được vào bảng stats
		INSERT @tblStats( bookId, bookTitle, totalAmount, totalPrice)
		VALUES  (@bookId, @bookTitle, @totalAmount, @totalPrice)

		-- Nhảy tới dòng kế tiếp
		FETCH NEXT FROM cs INTO @bookId
	END

	CLOSE cs
	DEALLOCATE cs

	SELECT * FROM @tblStats
END
GO

/****** Object:  StoredProcedure  [sp_getStatisticIncome]  Script Date: 8/13/2019 ******/
--Trả về thông tin doanh thu EXEC sp_getStatisticIncome 6
CREATE PROCEDURE sp_getStatisticIncome (@month SMALLINT)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @book_id VARCHAR(50)
	DECLARE @book_title NVARCHAR(256)
	DECLARE	@total_cost_storage MONEY = 0
	DECLARE	@total_money_order MONEY = 0
	DECLARE	@total_money_rentbook MONEY = 0
	DECLARE	@total_money_penalty MONEY = 0
	DECLARE	@total_money_income MONEY = 0

	DECLARE @tblStats TABLE
	(
		book_id VARCHAR(50),
		book_title NVARCHAR(256),
		total_cost_storage MONEY,
		total_money_order MONEY,
		total_money_rentbook MONEY,
		total_money_penalty MONEY,
		total_money_income MONEY
	)

	-- Lấy ra danh sách bảng chứa book_id tồn tại trong 1 trong số các bảng cần thống kê
	IF (@month != 0)
	BEGIN
		DECLARE cs CURSOR FOR SELECT id FROM BOOK
		WHERE id IN
		(
			SELECT DISTINCT book_id
			FROM ORDER_RENT JOIN ORDER_RENT_DETAIL
			ON ORDER_RENT_DETAIL.order_rent_id = ORDER_RENT.id
			WHERE YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
		) OR id IN
		(
			SELECT DISTINCT book_id
			FROM ORDER_SELL JOIN ORDER_SELL_DETAIL
			ON ORDER_SELL_DETAIL.order_sell_id = ORDER_SELL.id
			WHERE YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
		) OR id IN
		(
			SELECT DISTINCT book_id
			FROM STORAGE JOIN STORAGE_DETAIL
			ON STORAGE_DETAIL.storage_id = STORAGE.id
			WHERE YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
		) OR id IN
		(
			SELECT DISTINCT book_id
			FROM BOOK_LOST JOIN BOOK_LOST_DETAIL
			ON BOOK_LOST_DETAIL.book_lost_id = BOOK_LOST.id
			WHERE YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
		)
	END
	ELSE
	BEGIN
		DECLARE cs CURSOR FOR SELECT id FROM BOOK
		WHERE id IN
		(
			SELECT DISTINCT book_id
			FROM ORDER_RENT JOIN ORDER_RENT_DETAIL
			ON ORDER_RENT_DETAIL.order_rent_id = ORDER_RENT.id
			WHERE YEAR(created_date) = YEAR(GETDATE())
		) OR id IN
		(
			SELECT DISTINCT book_id
			FROM ORDER_SELL JOIN ORDER_SELL_DETAIL
			ON ORDER_SELL_DETAIL.order_sell_id = ORDER_SELL.id
			WHERE YEAR(created_date) = YEAR(GETDATE())
		) OR id IN
		(
			SELECT DISTINCT book_id
			FROM STORAGE JOIN STORAGE_DETAIL
			ON STORAGE_DETAIL.storage_id = STORAGE.id
			WHERE YEAR(created_date) = YEAR(GETDATE())
		) OR id IN
		(
			SELECT DISTINCT book_id
			FROM BOOK_LOST JOIN BOOK_LOST_DETAIL
			ON BOOK_LOST_DETAIL.book_lost_id = BOOK_LOST.id
			WHERE YEAR(created_date) = YEAR(GETDATE())
		)
	END

	--Duyệt con trỏ và tiến hành lấy các giá trị cần thống kê
	OPEN cs
	FETCH NEXT FROM cs INTO @book_id

	-- Lặp qua hết danh sách book_id vừa lấy được
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET	@total_cost_storage = 0
		SET	@total_money_order = 0
		SET	@total_money_rentbook = 0
		SET	@total_money_penalty = 0
		SET	@total_money_income = 0
					DECLARE @totalPriceRent MONEY = 0
			DECLARE @costRentExpiration MONEY = 0
			DECLARE @costBookLost MONEY = 0;

		IF (@month != 0)
		BEGIN
			-- /////////// TÊN SÁCH ///////////////
			SELECT @book_title = title FROM BOOK

			-- /////////// TIỀN NHẬP /////////////
			SELECT @total_cost_storage = SUM (SDT.amount * SDT.price)
			FROM STORAGE S JOIN STORAGE_DETAIL SDT
			ON SDT.storage_id = S.id
			WHERE SDT.book_id = @book_id
			AND YEAR(S.created_date) = YEAR(GETDATE()) AND MONTH(S.created_date) = @month

			-- /////////// TIỀN BÁN /////////////
			SELECT @total_money_order = SUM (amount * price)
			FROM ORDER_SELL JOIN ORDER_SELL_DETAIL
			ON ORDER_SELL_DETAIL.order_sell_id = ORDER_SELL.id
			WHERE book_id = @book_id
			AND YEAR(date_created) = YEAR(GETDATE()) AND MONTH(date_created) = @month

			--/////////// TIỀN THUÊ /////////////

			SELECT @totalPriceRent += cost_rent * SUM(amount)
			FROM ORDER_RENT JOIN ORDER_RENT_DETAIL
			ON ORDER_RENT_DETAIL.order_rent_id = ORDER_RENT.id
			WHERE book_id = @book_id
			AND YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
			GROUP BY id, cost_rent

			SET @total_money_rentbook = @totalPriceRent

			-- /////////////  TỔNG TIỀN PHẠT //////////////////

			--Lấy ra tổng phí thu khi phạt mất sách
			SELECT @costBookLost += bl.cost_lost * bldt.amount * rbdt.price
			FROM BOOK_LOST bl, BOOK_LOST_DETAIL bldt, ORDER_RENT_DETAIL rbdt
			WHERE bl.id = bldt.book_lost_id
			AND bldt.book_lost_id = rbdt.order_rent_id
			AND bldt.book_id = rbdt.book_id
			AND bldt.book_id = @book_id
			AND YEAR(bl.created_date) = YEAR(GETDATE()) AND MONTH(bl.created_date) = @month
			GROUP BY bl.id,  bldt.amount, rbdt.price, bl.cost_lost

			--Lấy ra tổng phí thu khi phạt quá hạn - ĐÃ TRẢ
			SELECT @costRentExpiration += rb.cost_expiration * SUM(dt.amount) * (DATEDIFF(DAY, rb.created_date, rb.returned_date) - rb.expiration_day)
			FROM ORDER_RENT rb, ORDER_RENT_DETAIL dt
			WHERE rb.id = dt.order_rent_id
			AND rb.status = 1
			AND DATEDIFF(DAY, rb.created_date, rb.returned_date) > rb.expiration_day
			AND dt.book_id = @book_id
			AND YEAR(rb.created_date) = YEAR(GETDATE()) AND MONTH(rb.created_date) = @month
			GROUP BY rb.id, rb.cost_expiration, rb.created_date, rb.returned_date, rb.expiration_day

			-- Tổng phí nhận được từ phí phạt
			SET @total_money_penalty = ISNULL(@costBookLost, 0) + ISNULL(@costRentExpiration, 0)

			-- /////////////  TỔNG TIỀN  //////////////////
			SET @total_money_income = ISNULL(@total_money_order, 0) + ISNULL(@total_money_penalty, 0) + ISNULL(@total_money_rentbook, 0) - ISNULL(@total_cost_storage, 0)
		END
		ELSE
		BEGIN
			-- /////////// TÊN SÁCH ///////////////
			SELECT @book_title = title FROM BOOK

			-- /////////// TIỀN NHẬP /////////////
			SELECT @total_cost_storage = SUM (SDT.amount * SDT.price)
			FROM STORAGE S JOIN STORAGE_DETAIL SDT
			ON SDT.storage_id = S.id
			WHERE SDT.book_id = @book_id
			AND YEAR(S.created_date) = YEAR(GETDATE())

			-- /////////// TIỀN BÁN /////////////
			SELECT @total_money_order = SUM (amount * price)
			FROM ORDER_SELL JOIN ORDER_SELL_DETAIL
			ON ORDER_SELL_DETAIL.order_sell_id = ORDER_SELL.id
			WHERE book_id = @book_id
			AND YEAR(date_created) = YEAR(GETDATE())

			--/////////// TIỀN THUÊ /////////////

			SELECT @totalPriceRent += cost_rent * SUM(amount)
			FROM ORDER_RENT JOIN ORDER_RENT_DETAIL
			ON ORDER_RENT_DETAIL.order_rent_id = ORDER_RENT.id
			WHERE book_id = @book_id
			AND YEAR(created_date) = YEAR(GETDATE())
			GROUP BY id, cost_rent

			SET @total_money_rentbook = @totalPriceRent

			-- /////////////  TỔNG TIỀN PHẠT //////////////////

			--Lấy ra tổng phí thu khi phạt mất sách
			SELECT @costBookLost += bl.cost_lost * bldt.amount * rbdt.price
			FROM BOOK_LOST bl, BOOK_LOST_DETAIL bldt, ORDER_RENT_DETAIL rbdt
			WHERE bl.id = bldt.book_lost_id
			AND bldt.book_lost_id = rbdt.order_rent_id
			AND bldt.book_id = rbdt.book_id
			AND bldt.book_id = @book_id
			AND YEAR(bl.created_date) = YEAR(GETDATE())
			GROUP BY bl.id,  bldt.amount, rbdt.price, bl.cost_lost

			--Lấy ra tổng phí thu khi phạt quá hạn - ĐÃ TRẢ
			SELECT @costRentExpiration += rb.cost_expiration * SUM(dt.amount) * (DATEDIFF(DAY, rb.created_date, rb.returned_date) - rb.expiration_day)
			FROM ORDER_RENT rb, ORDER_RENT_DETAIL dt
			WHERE rb.id = dt.order_rent_id
			AND rb.status = 1
			AND DATEDIFF(DAY, rb.created_date, rb.returned_date) > rb.expiration_day
			AND dt.book_id = @book_id
			AND YEAR(rb.created_date) = YEAR(GETDATE())
			GROUP BY rb.id, rb.cost_expiration, rb.created_date, rb.returned_date, rb.expiration_day

			-- Tổng phí nhận được từ phí phạt
			SET @total_money_penalty = ISNULL(@costBookLost, 0) + ISNULL(@costRentExpiration, 0)

			-- /////////////  TỔNG TIỀN  //////////////////
			SET @total_money_income = ISNULL(@total_money_order, 0) + ISNULL(@total_money_penalty, 0) + ISNULL(@total_money_rentbook, 0) - ISNULL(@total_cost_storage, 0)
		END


		--Thêm dữ liệu thống kê từ book_id đó vào bảng thống kê stats
		INSERT @tblStats( book_id, book_title, total_cost_storage, total_money_order, total_money_rentbook, total_money_penalty ,total_money_income)
		VALUES  (@book_id, @book_title, @total_cost_storage, @total_money_order, @total_money_rentbook, @total_money_penalty, @total_money_income)

		--Nhảy tới dòng kế tiếp
		FETCH NEXT FROM cs INTO @book_id
	END

	CLOSE cs
	DEALLOCATE cs

	--Trả về bảng danh sách đã thống kê
	DECLARE @SUM_TOTAL_INCOMEA MONEY

	SELECT @SUM_TOTAL_INCOMEA = SUM(total_money_income) FROM @tblStats
	SELECT *, @SUM_TOTAL_INCOMEA FROM @tblStats
END
GO


--Gọi khi bảng order detail có insert
CREATE TRIGGER tg_InsertOrderDetail ON ORDER_SELL_DETAIL
FOR INSERT
AS
BEGIN
	DECLARE @book_id VARCHAR(50)
	DECLARE @amount_insertd INT
	DECLARE cs CURSOR FOR SELECT Inserted.book_id, Inserted.amount FROM Inserted

	OPEN cs
	FETCH NEXT FROM cs INTO @book_id, @amount_insertd

	WHILE @@FETCH_STATUS = 0
	BEGIN
		--Giảm trừ số lượng đã insert vào số lượng sách đang có
		UPDATE BOOK SET amount = (amount - @amount_insertd) WHERE id = @book_id

		--Di chuyển tới dòng tiếp theo
		FETCH NEXT FROM cs INTO @book_id, @amount_insertd
	END
	CLOSE cs
	DEALLOCATE cs
END
GO

--Gọi khi bảng order detail có delete
CREATE TRIGGER tg_DeleteOrderDetail ON ORDER_SELL_DETAIL
FOR DELETE
AS
BEGIN
	DECLARE @book_id VARCHAR(50)
	DECLARE @amount_deleted INT
	DECLARE cs CURSOR FOR SELECT Deleted.book_id, Deleted.amount FROM Deleted
	OPEN cs

	FETCH NEXT FROM cs INTO @book_id, @amount_deleted
	WHILE @@FETCH_STATUS = 0
	BEGIN
		--Tăng số lượng từ bảng đã xóa vào số lượng sách đang có
		UPDATE BOOK SET amount = (amount + @amount_deleted) WHERE id = @book_id
		FETCH NEXT FROM cs INTO @book_id, @amount_deleted
	END

	CLOSE cs
	DEALLOCATE cs
END
GO

--Gọi khi bảng RentBookDetail có insert
CREATE TRIGGER tg_insertRentBookDetail ON ORDER_RENT_DETAIL
FOR INSERT
AS
BEGIN
	DECLARE @book_id VARCHAR(50)
	DECLARE @amount_inserted INT
	DECLARE cs CURSOR FOR SELECT Inserted.book_id, Inserted.amount FROM Inserted
	OPEN cs

	FETCH NEXT FROM cs INTO @book_id, @amount_inserted

	WHILE @@FETCH_STATUS = 0
	BEGIN
		--Giảm số lượng sách đang có dựa vào số lượng sách thuê đã insert
		UPDATE BOOK SET amount = (amount  - @amount_inserted) WHERE id = @book_id

		--Đi tới dòng tiếp theo
		FETCH NEXT FROM cs INTO @book_id, @amount_inserted
	END

	CLOSE cs
	DEALLOCATE cs
END
GO

--Gọi khi bảng RentBookDetail có delete
CREATE TRIGGER tg_deleteRentBookDetail ON ORDER_RENT_DETAIL
FOR DELETE
AS
BEGIN
	DECLARE @book_id VARCHAR(50)
	DECLARE @amount_deleted INT
	DECLARE @rentbook_id INT
	DECLARE @status INT
	DECLARE cs CURSOR FOR SELECT Deleted.book_id, Deleted.amount FROM Deleted

	-- Nếu xóa chi tiết của đơn thuê đã trả rồi thì ko xử lý nữa
	SELECT @status = status FROM ORDER_RENT WHERE id = @rentbook_id
	IF (@status = 1)
		ROLLBACK

	OPEN cs
	FETCH NEXT FROM cs INTO @book_id, @amount_deleted

	WHILE @@FETCH_STATUS = 0
	BEGIN
		--tăng số lượng sách đang có dựa vào số lượng sách thuê đã delete
		UPDATE BOOK SET amount = (amount + @amount_deleted) WHERE id = @book_id

		--Di chuyển tới dòng kế tiếp
		FETCH NEXT FROM cs INTO @book_id, @amount_deleted
	END

	CLOSE cs
	DEALLOCATE cs
END
GO

--Gọi khi bảng ORDER_RENT có update status = 1 => đã trả sách
CREATE TRIGGER tg_updateRentBook ON ORDER_RENT
FOR UPDATE
AS
BEGIN
	DECLARE @status_before INT
	DECLARE @status_after INT
	DECLARE @order_rent_id INT
	DECLARE @book_id VARCHAR(50)
	DECLARE @amount INT

	--Lấy ra trạng thái sau khi cập nhật và trước đó
	SELECT @status_before = Deleted.status, @order_rent_id = Deleted.id FROM Deleted
	SELECT @status_after = Inserted.status FROM Inserted



	--Mã status = 1 => đã trả sách
	IF (@status_before = 0 AND @status_after = 1)
	BEGIN

		DECLARE cs CURSOR FOR SELECT dt.book_id, dt.amount
		FROM ORDER_RENT_DETAIL dt WHERE order_rent_id = @order_rent_id

		OPEN cs
		FETCH NEXT FROM cs INTO @book_id, @amount

		WHILE @@FETCH_STATUS = 0
		BEGIN
			--Lấy số lượng trong chi tiết + ngược lại vào số lượng sách đang có
			UPDATE BOOK SET amount = (amount + @amount) WHERE id = @book_id

			--Duyệt tiếp
			FETCH NEXT FROM cs INTO @book_id, @amount
		END

		CLOSE cs
		DEALLOCATE cs
	END
END
GO

--Gọi khi bảng BOOK_LOST_DETAIL có insert
CREATE TRIGGER tg_insertBookLostDetail ON BOOK_LOST_DETAIL
FOR INSERT
AS
BEGIN
	DECLARE @book_id VARCHAR(50)
	DECLARE @amount_inserted INT
	DECLARE cs CURSOR FOR SELECT Inserted.book_id, Inserted.amount FROM Inserted

	OPEN cs
	FETCH NEXT FROM cs INTO @book_id, @amount_inserted

	WHILE @@FETCH_STATUS = 0
	BEGIN
		--Giảm số lượng sách đang có dựa vào số lượng sách mất đã insert
		UPDATE BOOK SET amount = (amount  - @amount_inserted) WHERE id = @book_id

		--Next tới dòng kế tiếp
		FETCH NEXT FROM cs INTO @book_id, @amount_inserted
	END

	CLOSE cs
	DEALLOCATE cs
END
GO

--Gọi khi bảng BOOK_LOST_DETAIL có delete
CREATE TRIGGER tg_deleteBookLostDetail ON BOOK_LOST_DETAIL
FOR DELETE
AS
BEGIN
	DECLARE @book_id VARCHAR(50)
	DECLARE @amount_deleted INT
	DECLARE cs CURSOR FOR SELECT Deleted.book_id, Deleted.amount FROM Deleted

	OPEN cs
	FETCH NEXT FROM cs INTO @book_id, @amount_deleted

	WHILE @@FETCH_STATUS = 0
	BEGIN
		--tăng số lượng sách đang có dựa vào số lượng sách mất đã deleted
		UPDATE BOOK SET amount = (amount  + @amount_deleted) WHERE id = @book_id

		--Next tới dòng kế tiếp
		FETCH NEXT FROM cs INTO @book_id, @amount_deleted
	END

	CLOSE cs
	DEALLOCATE cs
END
GO

--Gọi khi bảng STORAGE_DETAIL có INSERT
CREATE TRIGGER tg_InsertStorageDetail ON STORAGE_DETAIL
FOR INSERT
AS
BEGIN
	DECLARE @book_id VARCHAR(50)
	DECLARE @amount_insertd INT

	--Lấy ra mã sách và số lượng insert
	Declare cs Cursor
		FOR SELECT Inserted.book_id, Inserted.amount FROM Inserted
	Open cs
	Fetch next from cs INTO @book_id, @amount_insertd
	While @@FETCH_STATUS = 0
	BEGIN
		--Thêm số lượng đã insert vào số lượng sách đang có
		UPDATE BOOK SET amount = (amount + @amount_insertd) WHERE id = @book_id

		-- Next dòng tiếp theo
		Fetch next from cs INTO @book_id, @amount_insertd
	END
	close cs -- đóng con trỏ
	deallocate cs -- hủy bộ nhớ
END
GO

--Gọi khi bảng STORAGE_DETAIL có delete
CREATE TRIGGER tg_DeleteStorageDetail ON STORAGE_DETAIL
FOR DELETE
AS
BEGIN
	DECLARE @book_id VARCHAR(50)
	DECLARE @amount_deleted INT
	DECLARE cs CURSOR FOR SELECT Deleted.book_id, Deleted.amount FROM Deleted

	OPEN cs
	FETCH NEXT FROM cs INTO @book_id, @amount_deleted

	WHILE @@FETCH_STATUS = 0
	BEGIN
		--Giảm số lượng từ bảng đã xóa vào số lượng sách đang có
		UPDATE BOOK SET amount = (amount - @amount_deleted) WHERE id = @book_id
		--Di chuyển tới dòng kế tiếp
		FETCH NEXT FROM cs INTO @book_id, @amount_deleted
	END
	CLOSE cs
	DEALLOCATE cs
END
GO

