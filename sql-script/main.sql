CREATE DATABASE [BookStore]
GO

USE [BookStore]
GO

USE [BookStore]
GO
/****** Object:  StoredProcedure [dbo].[sp_getAmountBookRented]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_getAmountBookRented] (@rentbook_id INT, @book_id VARCHAR(50))
AS BEGIN
	SELECT
		SUM(amount)
	FROM RENTBOOK_DETAIL
	WHERE rentbook_id = @rentbook_id AND book_id = @book_id
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getBookSoldByMonth]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_getBookSoldByMonth](@month INT)
AS BEGIN
	SELECT
		Book.ID book_id,
		COUNT(ORDER_DETAIL.amount) amount_sold
	FROM ORDER_DETAIL
		join Book ON Book.ID = ORDER_DETAIL.book_id
		join [ORDER] ON [ORDER].ID = ORDER_DETAIL.order_id
	WHERE MONTH([ORDER].Date_created) = @month
	GROUP BY Book.ID
END

EXEC dbo.sp_getBookSoldByMonth @month = 7 -- int


/****** Object:  StoredProcedure  [sp_getIncomeByMonth]  Script Date: 7/19/2019 ******/
--Trả về thông tin thống kê tiền sách thu được khi bán sách

GO
/****** Object:  StoredProcedure [dbo].[sp_getClosestPriceStorageWithBook]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure  [sp_getClosestPriceStorageWithBook]  Script Date: 8/13/2019 ******/
--Trả về giá tiền nhập sách của sách có id truyền vào tại thời điểm gần nhất
CREATE PROC [dbo].[sp_getClosestPriceStorageWithBook] (@bookId VARCHAR(50))
AS BEGIN
	SELECT TOP 1 sdt.price FROM dbo.STORAGE s, dbo.STORAGE_DETAIL sdt
	WHERE s.id = sdt.storage_id AND sdt.book_id = @bookId
	ORDER BY s.created_date DESC
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getCountBook]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_getCountBook](@book_id VARCHAR(50))
AS BEGIN
	SELECT
		amount AS amount
	FROM Book
	WHERE BOOK.id = @book_id
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getCountBookBeingRented]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_getCountBookBeingRented](@book_id VARCHAR(50))
AS BEGIN
	SELECT
		SUM(rd.amount)
	FROM RENTBOOK_DETAIL rd
		JOIN Book b ON b.ID = rd.book_id
		JOIN RENTBOOK r ON r.ID = rd.rentbook_id
	WHERE r.status = 0 AND rd.book_id = @book_id
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getCountBookInOrder]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure  [sp_getSumCountOrderSold]  Script Date: 8/07/2019 ******/
--Trả về tổng số lượng sách đã bán
CREATE PROC [dbo].[sp_getCountBookInOrder] (@order_id INT)
AS BEGIN
	SELECT
		SUM(amount)
	FROM ORDER_DETAIL
	WHERE order_id = @order_id
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getCountBookSold]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure  [sp_getCountBookSold]  Script Date: 7/17/2019 ******/
--Lấy về số lượng sách đã bán của sách có id là @book_id
CREATE PROC [dbo].[sp_getCountBookSold](@book_id VARCHAR(50))
AS BEGIN
	SELECT
		od.amount amount_sold
	FROM Book b
	join ORDER_DETAIL od ON b.ID = od.book_id
	WHERE b.id = @book_id
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getIncomeByMonth]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_getIncomeByMonth](@month INT)
AS BEGIN
	SELECT
		BOOK.id MaSach,
		SUM(ORDER_DETAIL.amount) amount_sold,
		SUM( ORDER_DETAIL.price * ORDER_DETAIL.amount) money_total
	FROM ORDER_DETAIL
		join BOOK ON ORDER_DETAIL.book_id = BOOK.id
		join [ORDER] ON ORDER_DETAIL.order_id = [ORDER].id
		WHERE MONTH([ORDER].Date_created) = @month
	GROUP BY BOOK.id, ORDER_DETAIL.price, ORDER_DETAIL.amount
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getLostBookDetail]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure  [sp_getLostBookDetail]  Script Date: 8/03/2019 ******/
--Trả về thông tin chi tiết của LOST_BOOK_DETAIL theo rentbook_id
CREATE PROC [dbo].[sp_getLostBookDetail] (@rentbook_id INT)
AS BEGIN
	SELECT
		book_id,
		amount,
		cost
	FROM dbo.BOOK_LOST_DETAIL
	WHERE rentbook_id = @rentbook_id
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getOrderDetail]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure  [sp_getOrderDetail]  Script Date: 7/17/2019 ******/
--Lấy ra thông tin mã sách, số lượng và giá sách dựa vào thông tin order truyền vào
CREATE PROC [dbo].[sp_getOrderDetail](@order_id INT)
AS BEGIN
	SELECT
		Book.ID AS book_id,
		ORDER_DETAIL.amount AS amount,
		ORDER_DETAIL.price AS price
	FROM dbo.BOOK
		JOIN ORDER_DETAIL ON Book.ID = ORDER_DETAIL.book_id
	WHERE
		ORDER_DETAIL.order_id = @order_id
END


/****** Object:  StoredProcedure  [sp_getCountBook]  Script Date: 7/17/2019 ******/
--Lấy về số lượng sách còn trong kho của sách có mã là @book_id

GO
/****** Object:  StoredProcedure [dbo].[sp_getRentBookDetail]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_getRentBookDetail](@rentbook_id INT)
AS BEGIN
	SELECT
		BOOK.id book_id,
		RENTBOOK_DETAIL.amount amount,
		RENTBOOK_DETAIL.price price
	FROM Book
		JOIN RENTBOOK_DETAIL ON Book.ID = RENTBOOK_DETAIL.book_id
	WHERE RENTBOOK_DETAIL.rentbook_id = @rentbook_id
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getStatisticBookLostInMonth]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure  [sp_getStatisticBookLostInMonth]  Script Date: 8/13/2019 ******/
--Trả về thông tin sách mất theo tháng
CREATE PROCEDURE [dbo].[sp_getStatisticBookLostInMonth](@month SMALLINT)
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
		FROM dbo.BOOK_LOST JOIN dbo.BOOK_LOST_DETAIL
		ON BOOK_LOST_DETAIL.rentbook_id = BOOK_LOST.rentbook_id
		WHERE YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
		GROUP BY book_id
	END
	ELSE
	BEGIN
		DECLARE cs CURSOR FOR SELECT book_id
		FROM dbo.BOOK_LOST JOIN dbo.BOOK_LOST_DETAIL
		ON BOOK_LOST_DETAIL.rentbook_id = BOOK_LOST.rentbook_id
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
			SELECT @bookTitle = title FROM dbo.BOOK WHERE id = @bookId

			--Số đơn báo mất
			SELECT @totalBookLost = COUNT(*) FROM dbo.BOOK_LOST JOIN dbo.BOOK_LOST_DETAIL
			ON BOOK_LOST_DETAIL.rentbook_id = BOOK_LOST.rentbook_id
			WHERE book_id = @bookId
			AND YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month

			--Tổng sách mất
			SELECT @totalAmountBookLost = SUM(amount) FROM dbo.BOOK_LOST JOIN dbo.BOOK_LOST_DETAIL
			ON BOOK_LOST_DETAIL.rentbook_id = BOOK_LOST.rentbook_id
			WHERE book_id = @bookId
			AND YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month

			--Tổng tiền phạt thu được
			SELECT @totalCost = SUM(cost) FROM dbo.BOOK_LOST JOIN dbo.BOOK_LOST_DETAIL
			ON BOOK_LOST_DETAIL.rentbook_id = BOOK_LOST.rentbook_id
			WHERE book_id = @bookId
			AND YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
		END
		ELSE
		BEGIN
			--Tên sách
			SELECT @bookTitle = title FROM dbo.BOOK WHERE id = @bookId

			--Số đơn báo mất
			SELECT @totalBookLost = COUNT(*) FROM dbo.BOOK_LOST JOIN dbo.BOOK_LOST_DETAIL
			ON BOOK_LOST_DETAIL.rentbook_id = BOOK_LOST.rentbook_id
			WHERE book_id = @bookId
			AND YEAR(created_date) = YEAR(GETDATE())

			--Tổng sách mất
			SELECT @totalAmountBookLost = SUM(amount) FROM dbo.BOOK_LOST JOIN dbo.BOOK_LOST_DETAIL
			ON BOOK_LOST_DETAIL.rentbook_id = BOOK_LOST.rentbook_id
			WHERE book_id = @bookId
			AND YEAR(created_date) = YEAR(GETDATE())

			--Tổng tiền phạt thu được
			SELECT @totalCost = SUM(cost) FROM dbo.BOOK_LOST JOIN dbo.BOOK_LOST_DETAIL
			ON BOOK_LOST_DETAIL.rentbook_id = BOOK_LOST.rentbook_id
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
/****** Object:  StoredProcedure [dbo].[sp_getStatisticIncome]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure  [sp_getStatisticIncome]  Script Date: 8/13/2019 ******/
--Trả về thông tin doanh thu EXEC sp_getStatisticIncome 6
CREATE PROCEDURE [dbo].[sp_getStatisticIncome] (@month SMALLINT)
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
		DECLARE cs CURSOR FOR SELECT id FROM dbo.BOOK
		WHERE id IN
		(
			SELECT DISTINCT book_id
			FROM dbo.RENTBOOK JOIN dbo.RENTBOOK_DETAIL
			ON RENTBOOK_DETAIL.rentbook_id = RENTBOOK.id
			WHERE YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
		) OR id IN
		(
			SELECT DISTINCT book_id
			FROM dbo.[ORDER] JOIN dbo.ORDER_DETAIL
			ON ORDER_DETAIL.order_id = [ORDER].id
			WHERE YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
		) OR id IN
		(
			SELECT DISTINCT book_id
			FROM dbo.STORAGE JOIN dbo.STORAGE_DETAIL
			ON STORAGE_DETAIL.storage_id = STORAGE.id
			WHERE YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
		) OR id IN
		(
			SELECT DISTINCT book_id
			FROM dbo.BOOK_LOST JOIN dbo.BOOK_LOST_DETAIL
			ON BOOK_LOST_DETAIL.rentbook_id = BOOK_LOST.rentbook_id
			WHERE YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
		)
	END
	ELSE
	BEGIN
		DECLARE cs CURSOR FOR SELECT id FROM dbo.BOOK
		WHERE id IN
		(
			SELECT DISTINCT book_id
			FROM dbo.RENTBOOK JOIN dbo.RENTBOOK_DETAIL
			ON RENTBOOK_DETAIL.rentbook_id = RENTBOOK.id
			WHERE YEAR(created_date) = YEAR(GETDATE())
		) OR id IN
		(
			SELECT DISTINCT book_id
			FROM dbo.[ORDER] JOIN dbo.ORDER_DETAIL
			ON ORDER_DETAIL.order_id = [ORDER].id
			WHERE YEAR(created_date) = YEAR(GETDATE())
		) OR id IN
		(
			SELECT DISTINCT book_id
			FROM dbo.STORAGE JOIN dbo.STORAGE_DETAIL
			ON STORAGE_DETAIL.storage_id = STORAGE.id
			WHERE YEAR(created_date) = YEAR(GETDATE())
		) OR id IN
		(
			SELECT DISTINCT book_id
			FROM dbo.BOOK_LOST JOIN dbo.BOOK_LOST_DETAIL
			ON BOOK_LOST_DETAIL.rentbook_id = BOOK_LOST.rentbook_id
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
			SELECT @book_title = title FROM dbo.BOOK

			-- /////////// TIỀN NHẬP /////////////
			SELECT @total_cost_storage = SUM (SDT.amount * SDT.price)
			FROM dbo.STORAGE S JOIN dbo.STORAGE_DETAIL SDT
			ON SDT.storage_id = S.id
			WHERE SDT.book_id = @book_id
			AND YEAR(S.created_date) = YEAR(GETDATE()) AND MONTH(S.created_date) = @month

			-- /////////// TIỀN BÁN /////////////
			SELECT @total_money_order = SUM (amount * price)
			FROM dbo.[ORDER] JOIN dbo.ORDER_DETAIL
			ON ORDER_DETAIL.order_id = [ORDER].id
			WHERE book_id = @book_id
			AND YEAR(date_created) = YEAR(GETDATE()) AND MONTH(date_created) = @month

			--/////////// TIỀN THUÊ /////////////

			SELECT @totalPriceRent += cost_rent * SUM(amount)
			FROM dbo.RENTBOOK JOIN dbo.RENTBOOK_DETAIL
			ON RENTBOOK_DETAIL.rentbook_id = RENTBOOK.id
			WHERE book_id = @book_id
			AND YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
			GROUP BY id, cost_rent

			SET @total_money_rentbook = @totalPriceRent

			-- /////////////  TỔNG TIỀN PHẠT //////////////////

			--Lấy ra tổng phí thu khi phạt mất sách
			SELECT @costBookLost += bl.cost_lost * bldt.amount * rbdt.price
			FROM dbo.BOOK_LOST bl, dbo.BOOK_LOST_DETAIL bldt, dbo.RENTBOOK_DETAIL rbdt
			WHERE bl.rentbook_id = bldt.rentbook_id
			AND bldt.rentbook_id = rbdt.rentbook_id
			AND bldt.book_id = rbdt.book_id
			AND bldt.book_id = @book_id
			AND YEAR(bl.created_date) = YEAR(GETDATE()) AND MONTH(bl.created_date) = @month
			GROUP BY bl.rentbook_id,  bldt.amount, rbdt.price, bl.cost_lost

			--Lấy ra tổng phí thu khi phạt quá hạn - ĐÃ TRẢ
			SELECT @costRentExpiration += rb.cost_expiration * SUM(dt.amount) * (DATEDIFF(DAY, rb.created_date, rb.returned_date) - rb.expiration_day)
			FROM dbo.RENTBOOK rb, dbo.RENTBOOK_DETAIL dt
			WHERE rb.id = dt.rentbook_id
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
			SELECT @book_title = title FROM dbo.BOOK

			-- /////////// TIỀN NHẬP /////////////
			SELECT @total_cost_storage = SUM (SDT.amount * SDT.price)
			FROM dbo.STORAGE S JOIN dbo.STORAGE_DETAIL SDT
			ON SDT.storage_id = S.id
			WHERE SDT.book_id = @book_id
			AND YEAR(S.created_date) = YEAR(GETDATE())

			-- /////////// TIỀN BÁN /////////////
			SELECT @total_money_order = SUM (amount * price)
			FROM dbo.[ORDER] JOIN dbo.ORDER_DETAIL
			ON ORDER_DETAIL.order_id = [ORDER].id
			WHERE book_id = @book_id
			AND YEAR(date_created) = YEAR(GETDATE())

			--/////////// TIỀN THUÊ /////////////

			SELECT @totalPriceRent += cost_rent * SUM(amount)
			FROM dbo.RENTBOOK JOIN dbo.RENTBOOK_DETAIL
			ON RENTBOOK_DETAIL.rentbook_id = RENTBOOK.id
			WHERE book_id = @book_id
			AND YEAR(created_date) = YEAR(GETDATE())
			GROUP BY id, cost_rent

			SET @total_money_rentbook = @totalPriceRent

			-- /////////////  TỔNG TIỀN PHẠT //////////////////

			--Lấy ra tổng phí thu khi phạt mất sách
			SELECT @costBookLost += bl.cost_lost * bldt.amount * rbdt.price
			FROM dbo.BOOK_LOST bl, dbo.BOOK_LOST_DETAIL bldt, dbo.RENTBOOK_DETAIL rbdt
			WHERE bl.rentbook_id = bldt.rentbook_id
			AND bldt.rentbook_id = rbdt.rentbook_id
			AND bldt.book_id = rbdt.book_id
			AND bldt.book_id = @book_id
			AND YEAR(bl.created_date) = YEAR(GETDATE())
			GROUP BY bl.rentbook_id,  bldt.amount, rbdt.price, bl.cost_lost

			--Lấy ra tổng phí thu khi phạt quá hạn - ĐÃ TRẢ
			SELECT @costRentExpiration += rb.cost_expiration * SUM(dt.amount) * (DATEDIFF(DAY, rb.created_date, rb.returned_date) - rb.expiration_day)
			FROM dbo.RENTBOOK rb, dbo.RENTBOOK_DETAIL dt
			WHERE rb.id = dt.rentbook_id
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
/****** Object:  StoredProcedure [dbo].[sp_getStatisticOrderInMonth]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure  [sp_getStatisticOrderInMonth]  Script Date: 8/13/2019 ******/
--Trả về thông tin sách đã bán theo tháng // DROP PROC sp_getStatisticOrderInMonth EXEC sp_getStatisticOrderInMonth 0
CREATE PROC [dbo].[sp_getStatisticOrderInMonth] (@month int)
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
		book_category NVARCHAR(256),
		book_author NVARCHAR(256),
		book_createdDate DATE,
		totalOrder SMALLINT,
		totalBookOrder SMALLINT,
		totalPriceOrder MONEY
	)

	IF (@month != 0)
	BEGIN
		DECLARE cs CURSOR FOR SELECT book_id FROM dbo.[ORDER] JOIN dbo.ORDER_DETAIL
		ON ORDER_DETAIL.order_id = [ORDER].id
		WHERE YEAR(date_created) = YEAR(GETDATE()) AND MONTH(date_created) = @month
		GROUP BY book_id
	END
	ELSE
	BEGIN
		DECLARE cs CURSOR FOR SELECT book_id FROM dbo.[ORDER] JOIN dbo.ORDER_DETAIL
		ON ORDER_DETAIL.order_id = [ORDER].id
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
			FROM dbo.BOOK WHERE id = @bookId

			--Thể loại
			SELECT @bookCategory = category_title
			FROM dbo.BOOK, dbo.CATEGORY
			WHERE category_id = CATEGORY.id
			AND BOOK.id = @bookId

			--Tác giả
			SELECT @bookAuthor = fullname FROM dbo.BOOK, dbo.AUTHOR
			WHERE author_id = AUTHOR.id
			AND BOOK.id = @bookId

			--Ngày nhập
			SELECT @bookCreatedDate = created_date
			FROM dbo.BOOK
			WHERE id = @bookId

			--Tổng đơn
			SELECT @totalOrder = COUNT(*)
			FROM dbo.[ORDER] JOIN dbo.ORDER_DETAIL
			ON ORDER_DETAIL.order_id = [ORDER].id
			WHERE book_id = @bookId
			AND YEAR(date_created) = YEAR(GETDATE()) AND MONTH(date_created) = @month

			--Tổng sách đã bán
			SELECT @totalBookOrder = SUM (amount)
			FROM dbo.[ORDER] JOIN dbo.ORDER_DETAIL
			ON ORDER_DETAIL.order_id = [ORDER].id
			WHERE book_id = @bookId
			AND YEAR(date_created) = YEAR(GETDATE()) AND MONTH(date_created) = @month
			GROUP BY book_id

			--Tiền thu được
			SELECT @totalPriceOrder = SUM(amount * price)
			FROM dbo.[ORDER] JOIN dbo.ORDER_DETAIL
			ON ORDER_DETAIL.order_id = [ORDER].id
			WHERE book_id = @bookId
			AND YEAR(date_created) = YEAR(GETDATE()) AND MONTH(date_created) = @month
			GROUP BY book_id
		END
		ELSE
		BEGIN
			--Tên sách
			SELECT @bookTitle = title
			FROM dbo.BOOK WHERE id = @bookId

			--Thể loại
			SELECT @bookCategory = category_title
			FROM dbo.BOOK, dbo.CATEGORY
			WHERE category_id = CATEGORY.id
			AND BOOK.id = @bookId

			--Tác giả
			SELECT @bookAuthor = fullname FROM dbo.BOOK, dbo.AUTHOR
			WHERE author_id = AUTHOR.id
			AND BOOK.id = @bookId

			--Ngày nhập
			SELECT @bookCreatedDate = created_date
			FROM dbo.BOOK
			WHERE id = @bookId

			--Tổng đơn
			SELECT @totalOrder = COUNT(*)
			FROM dbo.[ORDER] JOIN dbo.ORDER_DETAIL
			ON ORDER_DETAIL.order_id = [ORDER].id
			WHERE book_id = @bookId
			AND YEAR(date_created) = YEAR(GETDATE())

			--Tổng sách đã bán
			SELECT @totalBookOrder = SUM (amount)
			FROM dbo.[ORDER] JOIN dbo.ORDER_DETAIL
			ON ORDER_DETAIL.order_id = [ORDER].id
			WHERE book_id = @bookId
			AND YEAR(date_created) = YEAR(GETDATE())
			GROUP BY book_id

			--Tiền thu được
			SELECT @totalPriceOrder = SUM(amount * price)
			FROM dbo.[ORDER] JOIN dbo.ORDER_DETAIL
			ON ORDER_DETAIL.order_id = [ORDER].id
			WHERE book_id = @bookId
			AND YEAR(date_created) = YEAR(GETDATE())
			GROUP BY book_id
		END


		--Thêm dữ liệu vào bảng thống kê
		INSERT @tblStats( book_id , book_title , book_category , book_author , book_createdDate , totalOrder , totalBookOrder , totalPriceOrder)
		VALUES (@bookId, @bookTitle, @bookCategory, @bookAuthor, @bookCreatedDate, @totalOrder, @totalBookOrder, @totalPriceOrder)

		FETCH NEXT FROM cs INTO @bookId
	END

	CLOSE cs
	DEALLOCATE cs

	SELECT * FROM @tblStats
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getStatisticOverviewInMonth]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure  [sp_getStatisticOverviewInMonth]  Script Date: 8/10/2019 ******/
--Trả về tổng tất cả các thứ cần thống ke :))
CREATE PROC [dbo].[sp_getStatisticOverviewInMonth]
AS BEGIN
	DECLARE @totalOrder FLOAT = 0
	DECLARE @totalRent FLOAT = 0
	DECLARE @totalLost FLOAT = 0
	DECLARE @totalUser FLOAT = 0
	DECLARE @totalAddStorage FLOAT = 0
	DECLARE @totalIncome FLOAT = 0

	SELECT @totalOrder = SUM(ORDER_DETAIL.amount) FROM ORDER_DETAIL, [ORDER]
	WHERE ORDER_DETAIL.order_id = [ORDER].id
	AND YEAR([ORDER].date_created) = YEAR(GETDATE())
	AND MONTH([ORDER].date_created) = MONTH(GETDATE())

	SELECT @totalRent = SUM(RENTBOOK_DETAIL.amount) FROM RENTBOOK_DETAIL, RENTBOOK
	WHERE  RENTBOOK_DETAIL.rentbook_id = RENTBOOK.id
	AND YEAR(RENTBOOK.created_date) = YEAR(GETDATE())
	AND MONTH(RENTBOOK.created_date) = MONTH(GETDATE())

	SELECT @totalLost = SUM(BOOK_LOST_DETAIL.amount) FROM  BOOK_LOST_DETAIL, BOOK_LOST
	WHERE BOOK_LOST_DETAIL.rentbook_id = BOOK_LOST.rentbook_id
	AND YEAR(BOOK_LOST.created_date) = YEAR(GETDATE())
	AND MONTH(BOOK_LOST.created_date) = MONTH(GETDATE())

	SELECT @totalUser = COUNT([USER].id) FROM [USER]
	WHERE YEAR([USER].created_date) = YEAR(GETDATE())
	AND MONTH([USER].created_date) = MONTH(GETDATE())

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
	SELECT @totalSumOrder = SUM(ORDER_DETAIL.amount*ORDER_DETAIL.price)
	FROM ORDER_DETAIL, [ORDER]
	WHERE ORDER_DETAIL.order_id = [ORDER].id
	AND YEAR([ORDER].date_created) = YEAR(GETDATE())
	AND MONTH([ORDER].date_created) = MONTH(GETDATE())

	-- Tổng phí phạt mất sách
	SELECT @totalSumLost = SUM(BOOK_LOST_DETAIL.cost)
	FROM BOOK_LOST, BOOK_LOST_DETAIL
	WHERE BOOK_LOST_DETAIL.rentbook_id = BOOK_LOST.rentbook_id
	AND YEAR(BOOK_LOST.created_date) = YEAR(GETDATE())
	AND MONTH(BOOK_LOST.created_date) = MONTH(GETDATE())

	--Lấy ra số tổng phí thuê sách
	SELECT @totalSumRent += cost_rent * SUM(amount)
	FROM dbo.RENTBOOK JOIN dbo.RENTBOOK_DETAIL
	ON RENTBOOK_DETAIL.rentbook_id = RENTBOOK.id
	WHERE YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = MONTH(GETDATE())
	GROUP BY rentbook_id, cost_rent

	--Lấy ra số tổng phí phạt khi thuê
	SELECT @totalSumRentExpiration += cost_expiration * SUM(amount) * (DATEDIFF(DAY, created_date, returned_date) - expiration_day)
	FROM dbo.RENTBOOK JOIN dbo.RENTBOOK_DETAIL
	ON RENTBOOK_DETAIL.rentbook_id = RENTBOOK.id
	WHERE status = 1 AND DATEDIFF(DAY, created_date, returned_date) > expiration_day
	AND YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = MONTH(GETDATE())
	GROUP BY rentbook_id, cost_expiration, created_date, returned_date, expiration_day

	--Lấy ra tổng chi phí khi nhập sách
	SELECT @totalSumMoneyStorage = SUM (price * amount)
	FROM dbo.STORAGE JOIN dbo.STORAGE_DETAIL
	ON STORAGE_DETAIL.storage_id = STORAGE.id
	WHERE YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = MONTH(GETDATE())

	SET @totalIncome = ISNULL(@totalSumOrder, 0) + ISNULL(@totalSumLost, 0) + ISNULL(@totalSumRentExpiration, 0) + ISNULL(@totalSumRent, 0) - ISNULL(@totalSumMoneyStorage, 0)

	SELECT @totalOrder AS [Total Order], @totalRent AS [Total Rent], @totalLost AS [Total Lost], @totalUser AS [Total User], @totalAddStorage AS [Total Book Storage], @totalIncome AS [Total imcome]
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getStatisticRentbookInMonth]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/****** Object:  StoredProcedure  [sp_getStatisticRentbookInMonth]  Script Date: 8/13/2019 ******/
--Trả về thông tin sách thuê theo tháng
CREATE PROCEDURE [dbo].[sp_getStatisticRentbookInMonth] (@month SMALLINT)
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
		FROM dbo.BOOK b, dbo.RENTBOOK rb, dbo.RENTBOOK_DETAIL dt
		WHERE b.id = dt.book_id AND rb.id = dt.rentbook_id
		AND YEAR(rb.created_date) = YEAR(GETDATE()) AND MONTH(rb.created_date) = @month
	ELSE-- Nếu @month = 0 thì duyệt lấy mã sách thuê trong cả năm
		DECLARE cs  CURSOR FOR SELECT DISTINCT b.id
		FROM dbo.BOOK b, dbo.RENTBOOK rb, dbo.RENTBOOK_DETAIL dt
		WHERE b.id = dt.book_id AND rb.id = dt.rentbook_id
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
			SELECT @book_title = title FROM dbo.BOOK WHERE id = @book_id

			--Tổng số lượng đã thuê
			SELECT @amount_total = SUM(rdt.amount)
			FROM dbo.RENTBOOK_DETAIL rdt JOIN dbo.RENTBOOK
			ON RENTBOOK.id = rdt.rentbook_id
			WHERE rdt.book_id = @book_id
			AND YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
			GROUP BY rdt.book_id

			--Tổng số sách đã trả
			SELECT @amount_returned = SUM(amount)
			FROM dbo.RENTBOOK_DETAIL JOIN dbo.RENTBOOK
			ON RENTBOOK.id = RENTBOOK_DETAIL.rentbook_id
			WHERE book_id = @book_id
			AND YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
			AND status = 1
			GROUP BY book_id

			--Tổng số sách đang còn thuê
			SELECT @amount_renting = SUM(amount)
			FROM dbo.RENTBOOK JOIN dbo.RENTBOOK_DETAIL
			ON RENTBOOK_DETAIL.rentbook_id = RENTBOOK.id
			WHERE book_id = @book_id
			AND status = 0
			AND YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
			GROUP BY book_id

			--Tổng số sách đang quá hạn
			SELECT @amount_expiration = SUM(amount)
			FROM dbo.RENTBOOK JOIN dbo.RENTBOOK_DETAIL
			ON RENTBOOK_DETAIL.rentbook_id = RENTBOOK.id
			WHERE book_id = @book_id
			AND status = 0
			AND DATEDIFF(DAY, created_date, GETDATE()) > expiration_day
			AND YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
			GROUP BY book_id
		END
		ELSE
		BEGIN
			--Tên sách
			SELECT @book_title = title FROM dbo.BOOK WHERE id = @book_id

			--Tổng số lượng đã thuê
			SELECT @amount_total = SUM(rdt.amount)
			FROM dbo.RENTBOOK_DETAIL rdt JOIN dbo.RENTBOOK
			ON RENTBOOK.id = rdt.rentbook_id
			WHERE rdt.book_id = @book_id
			AND YEAR(created_date) = YEAR(GETDATE())
			GROUP BY rdt.book_id

			--Tổng số sách đã trả
			SELECT @amount_returned = SUM(amount)
			FROM dbo.RENTBOOK_DETAIL JOIN dbo.RENTBOOK
			ON RENTBOOK.id = RENTBOOK_DETAIL.rentbook_id
			WHERE book_id = @book_id
			AND YEAR(created_date) = YEAR(GETDATE())
			AND status = 1
			GROUP BY book_id

			--Tổng số sách đang còn thuê
			SELECT @amount_renting = SUM(amount)
			FROM dbo.RENTBOOK JOIN dbo.RENTBOOK_DETAIL
			ON RENTBOOK_DETAIL.rentbook_id = RENTBOOK.id
			WHERE book_id = @book_id
			AND status = 0
			AND YEAR(created_date) = YEAR(GETDATE())
			GROUP BY book_id

			--Tổng số sách đang quá hạn
			SELECT @amount_expiration = SUM(amount)
			FROM dbo.RENTBOOK JOIN dbo.RENTBOOK_DETAIL
			ON RENTBOOK_DETAIL.rentbook_id = RENTBOOK.id
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
/****** Object:  StoredProcedure [dbo].[sp_getStatisticStorageInMonth]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure  [sp_getStatisticStorageInMonth]  Script Date: 8/13/2019 ******/
--Trả về thông tin sách nhập của tháng EXEC sp_getStatisticStorageInMonth 8
CREATE PROCEDURE [dbo].[sp_getStatisticStorageInMonth](@month SMALLINT)
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
		FROM dbo.STORAGE JOIN dbo.STORAGE_DETAIL
		ON STORAGE_DETAIL.storage_id = STORAGE.id
		WHERE YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
		GROUP BY book_id
	END
	ELSE
	BEGIN
		DECLARE cs CURSOR FOR SELECT book_id
		FROM dbo.STORAGE JOIN dbo.STORAGE_DETAIL
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
			SELECT @bookTitle = title FROM dbo.BOOK
			WHERE id = @bookId

			--Tổng sách đã nhập
			SELECT @totalAmount = SUM (amount) FROM dbo.STORAGE JOIN dbo.STORAGE_DETAIL
			ON STORAGE_DETAIL.storage_id = STORAGE.id
			WHERE book_id = @bookId
			AND YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month

			--Tổng chi phí
			SELECT @totalPrice = SUM (amount * price) FROM dbo.STORAGE JOIN dbo.STORAGE_DETAIL
			ON STORAGE_DETAIL.storage_id = STORAGE.id
			WHERE book_id = @bookId
			AND YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
		END
		ELSE
		BEGIN
			--Tên sách
			SELECT @bookTitle = title FROM dbo.BOOK
			WHERE id = @bookId

			--Tổng sách đã nhập
			SELECT @totalAmount = SUM (amount) FROM dbo.STORAGE JOIN dbo.STORAGE_DETAIL
			ON STORAGE_DETAIL.storage_id = STORAGE.id
			WHERE book_id = @bookId
			AND YEAR(created_date) = YEAR(GETDATE())

			--Tổng chi phí
			SELECT @totalPrice = SUM (amount * price) FROM dbo.STORAGE JOIN dbo.STORAGE_DETAIL
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
/****** Object:  StoredProcedure [dbo].[sp_getStatisticUserInMonth]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/****** Object:  StoredProcedure  [sp_getStatisticUserInMonth]  Script Date: 8/13/2019 ******/
--Trả về thông tin thành viên người dùng theo tháng
CREATE PROCEDURE [dbo].[sp_getStatisticUserInMonth](@month SMALLINT)
AS
BEGIN
	SET NOCOUNT ON
	IF (@month != 0)
	BEGIN
		SELECT id, username, fullname, email, date_of_birth, created_date
		FROM dbo.[USER]
		WHERE YEAR(created_date) = YEAR(GETDATE()) AND MONTH(created_date) = @month
	END
	ELSE
	BEGIN
		SELECT id, username, fullname, email, date_of_birth, created_date
		FROM dbo.[USER]
		WHERE YEAR(created_date) = YEAR(GETDATE())
	END
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getTotalAmountOrderBook]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure  [sp_getTotalAmountOrderBook]  Script Date: 8/10/2019 ******/
--Trả về tổng số sách đã bán
CREATE PROC [dbo].[sp_getTotalAmountOrderBook]
AS BEGIN
	SELECT
		SUM(amount)
	FROM ORDER_DETAIL
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getTotalCostBookLost]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure  [sp_getTotalCostBookLost]  Script Date: 8/03/2019 ******/
--Trả về tổng số cost có trong LostBook theo renbook_id
CREATE PROC [dbo].[sp_getTotalCostBookLost] (@rentbook_id INT)
AS BEGIN
	SELECT
		SUM(cost)
	FROM dbo.BOOK_LOST_DETAIL
	WHERE rentbook_id = @rentbook_id
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getTotalCountBookLost]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_getTotalCountBookLost] (@rentbook_id INT)
AS BEGIN
	SELECT
		SUM(amount)
	FROM dbo.BOOK_LOST_DETAIL
	WHERE rentbook_id = @rentbook_id
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getTotalCountBookOfStorage]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure  [sp_getLostBookDetail]  Script Date: 8/04/2019 ******/
--Trả về tổng số sách đã nhập trong hóa đơn nhập
CREATE PROC [dbo].[sp_getTotalCountBookOfStorage] (@storage_id INT)
AS BEGIN
	SELECT
		SUM(amount)
	FROM STORAGE_DETAIL
	WHERE storage_id = @storage_id
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getTotalPriceInOrder]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure  [sp_getSumPriceOrderSold]  Script Date: 8/07/2019 ******/
--Trả về tổng số lượng sách đã bán
CREATE PROC [dbo].[sp_getTotalPriceInOrder](@order_id INT)
AS BEGIN
	SELECT
		SUM(price * amount)
	FROM ORDER_DETAIL
	WHERE order_id = @order_id
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getTotalRentBook]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  StoredProcedure  [sp_getTotalRentbook]  Script Date: 8/03/2019 ******/
--Trả về tổng số sách đã thuê trong RENTBOOK_DETAIL theo renbook_id
CREATE PROC [dbo].[sp_getTotalRentBook] (@rentbook_id INT)
AS BEGIN
	SELECT
		SUM(amount)
	FROM RENTBOOK_DETAIL
	WHERE rentbook_id = @rentbook_id
END

GO
/****** Object:  Table [dbo].[ADMIN]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ADMIN](
	[id] [int] IDENTITY(101,2) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[fullName] [nvarchar](256) NOT NULL,
	[email] [varchar](50) NULL,
	[phone_number] [varchar](14) NOT NULL,
	[image] [nvarchar](256) NULL,
	[sex] [bit] NULL,
	[role] [int] NOT NULL,
	[isActive] [bit] NULL,
	[created_date] [date] NULL,
PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AUTHOR]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AUTHOR](
	[id] [int] IDENTITY(100,1) NOT NULL,
	[fullname] [nvarchar](256) NOT NULL,
	[date_of_birth] [date] NULL,
	[date_of_death] [date] NULL,
	[image] [nvarchar](256) NULL,
	[introduce] [nvarchar](256) NULL,
	[created_date] [date] NULL,
PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BOOK]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BOOK](
	[id] [varchar](50) NOT NULL,
	[title] [nvarchar](100) NOT NULL,
	[category_id] [varchar](50) NOT NULL,
	[page_num] [int] NULL,
	[author_id] [int] NULL,
	[amount] [int] NULL,
	[publisher_id] [int] NULL,
	[publication_year] [int] NULL,
	[price] [money] NULL,
	[image] [nvarchar](256) NULL,
	[location_id] [varchar](50) NULL,
	[description] [nvarchar](256) NULL,
	[introduce] [nvarchar](256) NULL,
	[created_date] [date] NULL,
PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BOOK_LOST]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BOOK_LOST](
	[rentbook_id] [int] NOT NULL,
	[admin_id] [int] NULL,
	[cost_lost] [smallmoney] NULL,
	[created_date] [date] NULL,
PRIMARY KEY CLUSTERED
(
	[rentbook_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BOOK_LOST_DETAIL]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BOOK_LOST_DETAIL](
	[rentbook_id] [int] NOT NULL,
	[book_id] [varchar](50) NOT NULL,
	[amount] [int] NOT NULL,
	[cost] [money] NULL,
PRIMARY KEY CLUSTERED
(
	[rentbook_id] ASC,
	[book_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[books_authors]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[books_authors](
	[book_id] [varchar](50) NOT NULL,
	[author_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED
(
	[book_id] ASC,
	[author_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[books_categories]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[books_categories](
	[book_id] [varchar](50) NOT NULL,
	[category_id] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED
(
	[book_id] ASC,
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CATEGORY]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CATEGORY](
	[id] [varchar](50) NOT NULL,
	[category_title] [nvarchar](50) NULL,
	[category_description] [text] NULL,
PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LOCATION]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOCATION](
	[id] [varchar](50) NOT NULL,
	[location_name] [nvarchar](256) NOT NULL,
	[max_storage] [int] NULL,
	[description] [nvarchar](256) NULL,
PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ORDER]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ORDER](
	[id] [int] IDENTITY(100,1) NOT NULL,
	[user_id] [int] NULL,
	[admin_id] [int] NULL,
	[date_created] [date] NULL,
PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ORDER_DETAIL]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ORDER_DETAIL](
	[order_id] [int] NOT NULL,
	[book_id] [varchar](50) NOT NULL,
	[amount] [int] NOT NULL,
	[price] [money] NOT NULL,
PRIMARY KEY CLUSTERED
(
	[order_id] ASC,
	[book_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PUBLISHER]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PUBLISHER](
	[id] [int] IDENTITY(100,1) NOT NULL,
	[name] [nvarchar](256) NOT NULL,
	[phone_number] [varchar](13) NULL,
	[email] [varchar](100) NOT NULL,
	[address] [nvarchar](200) NULL,
	[introduce] [nvarchar](256) NULL,
	[created_date] [date] NULL,
PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RENTBOOK]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RENTBOOK](
	[id] [int] IDENTITY(100,1) NOT NULL,
	[user_id] [int] NULL,
	[admin_id] [int] NULL,
	[cost_rent] [money] NULL,
	[cost_expiration] [money] NULL,
	[expiration_day] [smallint] NULL,
	[created_date] [date] NULL,
	[returned_date] [date] NULL,
	[status] [int] NULL,
PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RENTBOOK_DETAIL]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RENTBOOK_DETAIL](
	[rentbook_id] [int] NOT NULL,
	[book_id] [varchar](50) NOT NULL,
	[amount] [int] NOT NULL,
	[price] [money] NULL,
PRIMARY KEY CLUSTERED
(
	[rentbook_id] ASC,
	[book_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[STORAGE]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STORAGE](
	[id] [int] IDENTITY(100,1) NOT NULL,
	[admin_id] [int] NOT NULL,
	[description] [nvarchar](256) NULL,
	[created_date] [date] NULL,
PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[STORAGE_DETAIL]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[STORAGE_DETAIL](
	[storage_id] [int] NOT NULL,
	[book_id] [varchar](50) NOT NULL,
	[amount] [int] NULL,
	[price] [money] NULL,
PRIMARY KEY CLUSTERED
(
	[storage_id] ASC,
	[book_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[USER]    Script Date: 02/08/2020 2:17:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[USER](
	[id] [int] IDENTITY(100,1) NOT NULL,
	[username] [varchar](100) NOT NULL,
	[password] [varchar](100) NOT NULL,
	[fullname] [nvarchar](50) NULL,
	[date_of_birth] [date] NULL,
	[email] [varchar](50) NULL,
	[phone_number] [varchar](14) NULL,
	[sex] [bit] NULL,
	[isActive] [bit] NULL,
	[created_date] [date] NULL,
PRIMARY KEY CLUSTERED
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[ADMIN] ON

INSERT [dbo].[ADMIN] ([id], [username], [password], [fullName], [email], [phone_number], [image], [sex], [role], [isActive], [created_date]) VALUES (101, N'quanly', N'123', N'Lý Tiểu Long', N'lytieulong@gmail.com', N'01682439314', NULL, NULL, 1, 0, CAST(0x273A0B00 AS Date))
INSERT [dbo].[ADMIN] ([id], [username], [password], [fullName], [email], [phone_number], [image], [sex], [role], [isActive], [created_date]) VALUES (103, N'truongphong', N'123', N'Nguyễn Đại Trân', N'ngueyndairan@gmail.com', N'0123456789', NULL, NULL, 1, 1, CAST(0xC2350B00 AS Date))
INSERT [dbo].[ADMIN] ([id], [username], [password], [fullName], [email], [phone_number], [image], [sex], [role], [isActive], [created_date]) VALUES (105, N'haogd', N'123456789', N'Đại Hào', N'daihao12mc@gmail.com', N'0376555796', N'', 1, 0, 1, CAST(0x64410B00 AS Date))
SET IDENTITY_INSERT [dbo].[ADMIN] OFF
SET IDENTITY_INSERT [dbo].[AUTHOR] ON

INSERT [dbo].[AUTHOR] ([id], [fullname], [date_of_birth], [date_of_death], [image], [introduce], [created_date]) VALUES (100, N'Đỗ Văn Hoàng', CAST(0x64410B00 AS Date), NULL, N'', N'Tác giả này tên là Đỗ Văn Hoàng.', CAST(0x64410B00 AS Date))
INSERT [dbo].[AUTHOR] ([id], [fullname], [date_of_birth], [date_of_death], [image], [introduce], [created_date]) VALUES (101, N'Trần Đăng Khoa', CAST(0x64410B00 AS Date), NULL, N'', N'Tác giả này nổi tiếng với các bài văn dành cho trẻ em', CAST(0x64410B00 AS Date))
INSERT [dbo].[AUTHOR] ([id], [fullname], [date_of_birth], [date_of_death], [image], [introduce], [created_date]) VALUES (102, N'Lê Văn Thuyết', CAST(0x64410B00 AS Date), NULL, N'', N'', CAST(0x64410B00 AS Date))
SET IDENTITY_INSERT [dbo].[AUTHOR] OFF
INSERT [dbo].[BOOK] ([id], [title], [category_id], [page_num], [author_id], [amount], [publisher_id], [publication_year], [price], [image], [location_id], [description], [introduce], [created_date]) VALUES (N'GH12', N'TÔI THẤY MÌNH CÒN TRẺ', N'TT2', 274, 100, 96, 100, 2017, 296999.0000, N'', N'A1', N'', NULL, CAST(0xEA3E0B00 AS Date))
INSERT [dbo].[BOOK] ([id], [title], [category_id], [page_num], [author_id], [amount], [publisher_id], [publication_year], [price], [image], [location_id], [description], [introduce], [created_date]) VALUES (N'JH42', N'TÔI THẤY HOA VÀNG TRÊN CỎ XANH', N'AG1', 274, 102, 96, 101, 2017, 196333.0000, N'', N'A2', N'', NULL, CAST(0xEB3E0B00 AS Date))
INSERT [dbo].[books_authors] ([book_id], [author_id]) VALUES (N'GH12', 100)
INSERT [dbo].[books_authors] ([book_id], [author_id]) VALUES (N'JH42', 101)
INSERT [dbo].[books_categories] ([book_id], [category_id]) VALUES (N'GH12', N'AG1')
INSERT [dbo].[books_categories] ([book_id], [category_id]) VALUES (N'GH12', N'PT5')
INSERT [dbo].[books_categories] ([book_id], [category_id]) VALUES (N'GH12', N'TT2')
INSERT [dbo].[books_categories] ([book_id], [category_id]) VALUES (N'JH42', N'PT5')
INSERT [dbo].[CATEGORY] ([id], [category_title], [category_description]) VALUES (N'AG1', N'Sống đúng', N'')
INSERT [dbo].[CATEGORY] ([id], [category_title], [category_description]) VALUES (N'PT5', N'Đi tìm ngày xưa', N'')
INSERT [dbo].[CATEGORY] ([id], [category_title], [category_description]) VALUES (N'TT2', N'Kỉ Niệm HÀ NỘI tôi', N'71 trang')
INSERT [dbo].[LOCATION] ([id], [location_name], [max_storage], [description]) VALUES (N'A1', N'Kệ A1', 100, N'')
INSERT [dbo].[LOCATION] ([id], [location_name], [max_storage], [description]) VALUES (N'A2', N'Kệ A2', 120, N'')
INSERT [dbo].[LOCATION] ([id], [location_name], [max_storage], [description]) VALUES (N'A3', N'Kệ A3', 130, N'')
INSERT [dbo].[LOCATION] ([id], [location_name], [max_storage], [description]) VALUES (N'A4', N'Kệ A4', 90, N'')
INSERT [dbo].[LOCATION] ([id], [location_name], [max_storage], [description]) VALUES (N'A5', N'Kệ A5', 100, N'')
INSERT [dbo].[LOCATION] ([id], [location_name], [max_storage], [description]) VALUES (N'A6', N'Kệ A6', 100, N'')
INSERT [dbo].[LOCATION] ([id], [location_name], [max_storage], [description]) VALUES (N'A7', N'Kệ A7', 120, N'')
INSERT [dbo].[LOCATION] ([id], [location_name], [max_storage], [description]) VALUES (N'A8', N'Kệ A8', 110, N'')
SET IDENTITY_INSERT [dbo].[ORDER] ON

INSERT [dbo].[ORDER] ([id], [user_id], [admin_id], [date_created]) VALUES (100, 100, 101, CAST(0x64410B00 AS Date))
INSERT [dbo].[ORDER] ([id], [user_id], [admin_id], [date_created]) VALUES (101, 101, 103, CAST(0x64410B00 AS Date))
SET IDENTITY_INSERT [dbo].[ORDER] OFF
INSERT [dbo].[ORDER_DETAIL] ([order_id], [book_id], [amount], [price]) VALUES (100, N'GH12', 3, 200000.0000)
INSERT [dbo].[ORDER_DETAIL] ([order_id], [book_id], [amount], [price]) VALUES (101, N'JH42', 2, 300000.0000)
SET IDENTITY_INSERT [dbo].[PUBLISHER] ON

INSERT [dbo].[PUBLISHER] ([id], [name], [phone_number], [email], [address], [introduce], [created_date]) VALUES (100, N'BXB Trẻ', N'0376546521', N'contact@nxbtre.com', NULL, N'Đây là nhà xuất bản khá trẻ :v', CAST(0x64410B00 AS Date))
INSERT [dbo].[PUBLISHER] ([id], [name], [phone_number], [email], [address], [introduce], [created_date]) VALUES (101, N'BXB Nhi Đồng', N'0186224665', N'contact@nxbnhidong.com', NULL, N'Đây là nhà xuất bản nhi đồng', CAST(0x64410B00 AS Date))
SET IDENTITY_INSERT [dbo].[PUBLISHER] OFF
SET IDENTITY_INSERT [dbo].[RENTBOOK] ON

INSERT [dbo].[RENTBOOK] ([id], [user_id], [admin_id], [cost_rent], [cost_expiration], [expiration_day], [created_date], [returned_date], [status]) VALUES (100, 100, 101, 5000.0000, 1000.0000, 7, CAST(0x64410B00 AS Date), NULL, 0)
INSERT [dbo].[RENTBOOK] ([id], [user_id], [admin_id], [cost_rent], [cost_expiration], [expiration_day], [created_date], [returned_date], [status]) VALUES (101, 101, 103, 5000.0000, 1000.0000, 7, CAST(0x64410B00 AS Date), CAST(0x64410B00 AS Date), 1)
SET IDENTITY_INSERT [dbo].[RENTBOOK] OFF
INSERT [dbo].[RENTBOOK_DETAIL] ([rentbook_id], [book_id], [amount], [price]) VALUES (100, N'GH12', 3, 300000.0000)
INSERT [dbo].[RENTBOOK_DETAIL] ([rentbook_id], [book_id], [amount], [price]) VALUES (101, N'GH12', 2, 400000.0000)
INSERT [dbo].[RENTBOOK_DETAIL] ([rentbook_id], [book_id], [amount], [price]) VALUES (101, N'JH42', 4, 400000.0000)
SET IDENTITY_INSERT [dbo].[STORAGE] ON

INSERT [dbo].[STORAGE] ([id], [admin_id], [description], [created_date]) VALUES (100, 101, N'Không ghi chú gì hết', CAST(0x64410B00 AS Date))
SET IDENTITY_INSERT [dbo].[STORAGE] OFF
INSERT [dbo].[STORAGE_DETAIL] ([storage_id], [book_id], [amount], [price]) VALUES (100, N'GH12', 90, 250000.0000)
INSERT [dbo].[STORAGE_DETAIL] ([storage_id], [book_id], [amount], [price]) VALUES (100, N'JH42', 50, 180000.0000)
SET IDENTITY_INSERT [dbo].[USER] ON

INSERT [dbo].[USER] ([id], [username], [password], [fullname], [date_of_birth], [email], [phone_number], [sex], [isActive], [created_date]) VALUES (100, N'haond', N'$2a$06$KRGxLBS0Lxe3KBCwKxOzLeZWomlsqLFNrudAZ1YJhJKfRxcTQbuY.', N'Nguyễn Văn Hao', CAST(0x3B230B00 AS Date), N'teonv@gmail.com', N'0623457413', 1, 1, NULL)
INSERT [dbo].[USER] ([id], [username], [password], [fullname], [date_of_birth], [email], [phone_number], [sex], [isActive], [created_date]) VALUES (101, N'nopt12', N'$2a$06$KRGxLBS0Lxe3KBCwKxOzLeZWomlsqLFNrudAZ1YJhJKfRxcTQbuY.', N'Nguyễn Thị Nở', CAST(0x501A0B00 AS Date), N'nopt@gmail.com', N'054632179', 1, 0, NULL)
SET IDENTITY_INSERT [dbo].[USER] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__ADMIN__F3DBC5724758F3D9]    Script Date: 02/08/2020 2:17:06 PM ******/
ALTER TABLE [dbo].[ADMIN] ADD UNIQUE NONCLUSTERED
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__USER__F3DBC572572A880F]    Script Date: 02/08/2020 2:17:06 PM ******/
ALTER TABLE [dbo].[USER] ADD UNIQUE NONCLUSTERED
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[STORAGE] ADD  DEFAULT (getdate()) FOR [created_date]
GO
ALTER TABLE [dbo].[BOOK]  WITH CHECK ADD  CONSTRAINT [FK_Book_Author_id] FOREIGN KEY([author_id])
REFERENCES [dbo].[AUTHOR] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BOOK] CHECK CONSTRAINT [FK_Book_Author_id]
GO
ALTER TABLE [dbo].[BOOK]  WITH CHECK ADD  CONSTRAINT [FK_Book_category_id] FOREIGN KEY([category_id])
REFERENCES [dbo].[CATEGORY] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BOOK] CHECK CONSTRAINT [FK_Book_category_id]
GO
ALTER TABLE [dbo].[BOOK]  WITH CHECK ADD  CONSTRAINT [FK_Book_Location_id] FOREIGN KEY([location_id])
REFERENCES [dbo].[LOCATION] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BOOK] CHECK CONSTRAINT [FK_Book_Location_id]
GO
ALTER TABLE [dbo].[BOOK]  WITH CHECK ADD  CONSTRAINT [FK_Book_publisher_id] FOREIGN KEY([publisher_id])
REFERENCES [dbo].[PUBLISHER] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BOOK] CHECK CONSTRAINT [FK_Book_publisher_id]
GO
ALTER TABLE [dbo].[BOOK]  WITH CHECK ADD  CONSTRAINT [FKgtvt7p649s4x80y6f4842pnfq] FOREIGN KEY([publisher_id])
REFERENCES [dbo].[PUBLISHER] ([id])
GO
ALTER TABLE [dbo].[BOOK] CHECK CONSTRAINT [FKgtvt7p649s4x80y6f4842pnfq]
GO
ALTER TABLE [dbo].[BOOK_LOST]  WITH CHECK ADD  CONSTRAINT [fk_LostBook_Admin_id] FOREIGN KEY([admin_id])
REFERENCES [dbo].[ADMIN] ([id])
GO
ALTER TABLE [dbo].[BOOK_LOST] CHECK CONSTRAINT [fk_LostBook_Admin_id]
GO
ALTER TABLE [dbo].[BOOK_LOST]  WITH CHECK ADD  CONSTRAINT [fk_LostBook_RentBook_id] FOREIGN KEY([rentbook_id])
REFERENCES [dbo].[RENTBOOK] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BOOK_LOST] CHECK CONSTRAINT [fk_LostBook_RentBook_id]
GO
ALTER TABLE [dbo].[BOOK_LOST_DETAIL]  WITH CHECK ADD  CONSTRAINT [fk_LostBook__Detail_Book_id] FOREIGN KEY([book_id])
REFERENCES [dbo].[BOOK] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BOOK_LOST_DETAIL] CHECK CONSTRAINT [fk_LostBook__Detail_Book_id]
GO
ALTER TABLE [dbo].[BOOK_LOST_DETAIL]  WITH CHECK ADD  CONSTRAINT [fk_LostBook_Detail_RentBook_id] FOREIGN KEY([rentbook_id])
REFERENCES [dbo].[BOOK_LOST] ([rentbook_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BOOK_LOST_DETAIL] CHECK CONSTRAINT [fk_LostBook_Detail_RentBook_id]
GO
ALTER TABLE [dbo].[books_authors]  WITH CHECK ADD  CONSTRAINT [FK6ojkw2gy23xsgdkqih628favt] FOREIGN KEY([book_id])
REFERENCES [dbo].[BOOK] ([id])
GO
ALTER TABLE [dbo].[books_authors] CHECK CONSTRAINT [FK6ojkw2gy23xsgdkqih628favt]
GO
ALTER TABLE [dbo].[books_authors]  WITH CHECK ADD  CONSTRAINT [FKov77rfnon6gwd8emlsah05qty] FOREIGN KEY([author_id])
REFERENCES [dbo].[AUTHOR] ([id])
GO
ALTER TABLE [dbo].[books_authors] CHECK CONSTRAINT [FKov77rfnon6gwd8emlsah05qty]
GO
ALTER TABLE [dbo].[books_categories]  WITH CHECK ADD  CONSTRAINT [FKb9cxhvxrdqagj2np5dliseash] FOREIGN KEY([book_id])
REFERENCES [dbo].[BOOK] ([id])
GO
ALTER TABLE [dbo].[books_categories] CHECK CONSTRAINT [FKb9cxhvxrdqagj2np5dliseash]
GO
ALTER TABLE [dbo].[books_categories]  WITH CHECK ADD  CONSTRAINT [FKkksgsy7k6sy1hr55se8mpktvb] FOREIGN KEY([category_id])
REFERENCES [dbo].[CATEGORY] ([id])
GO
ALTER TABLE [dbo].[books_categories] CHECK CONSTRAINT [FKkksgsy7k6sy1hr55se8mpktvb]
GO
ALTER TABLE [dbo].[ORDER]  WITH CHECK ADD  CONSTRAINT [fk_ADMIN_ORDER] FOREIGN KEY([admin_id])
REFERENCES [dbo].[ADMIN] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ORDER] CHECK CONSTRAINT [fk_ADMIN_ORDER]
GO
ALTER TABLE [dbo].[ORDER]  WITH CHECK ADD  CONSTRAINT [fk_Book] FOREIGN KEY([user_id])
REFERENCES [dbo].[USER] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ORDER] CHECK CONSTRAINT [fk_Book]
GO
ALTER TABLE [dbo].[ORDER_DETAIL]  WITH CHECK ADD  CONSTRAINT [fk_book_oder] FOREIGN KEY([book_id])
REFERENCES [dbo].[BOOK] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[ORDER_DETAIL] CHECK CONSTRAINT [fk_book_oder]
GO
ALTER TABLE [dbo].[ORDER_DETAIL]  WITH CHECK ADD  CONSTRAINT [fk_order1_book] FOREIGN KEY([order_id])
REFERENCES [dbo].[ORDER] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ORDER_DETAIL] CHECK CONSTRAINT [fk_order1_book]
GO
ALTER TABLE [dbo].[RENTBOOK]  WITH CHECK ADD  CONSTRAINT [fk_admin1] FOREIGN KEY([admin_id])
REFERENCES [dbo].[ADMIN] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[RENTBOOK] CHECK CONSTRAINT [fk_admin1]
GO
ALTER TABLE [dbo].[RENTBOOK]  WITH CHECK ADD  CONSTRAINT [fk_user] FOREIGN KEY([user_id])
REFERENCES [dbo].[USER] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[RENTBOOK] CHECK CONSTRAINT [fk_user]
GO
ALTER TABLE [dbo].[RENTBOOK_DETAIL]  WITH CHECK ADD  CONSTRAINT [fk_bookID] FOREIGN KEY([book_id])
REFERENCES [dbo].[BOOK] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[RENTBOOK_DETAIL] CHECK CONSTRAINT [fk_bookID]
GO
ALTER TABLE [dbo].[RENTBOOK_DETAIL]  WITH CHECK ADD  CONSTRAINT [fk_renbook] FOREIGN KEY([rentbook_id])
REFERENCES [dbo].[RENTBOOK] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RENTBOOK_DETAIL] CHECK CONSTRAINT [fk_renbook]
GO
ALTER TABLE [dbo].[STORAGE]  WITH CHECK ADD  CONSTRAINT [fk_storage_admin_id] FOREIGN KEY([admin_id])
REFERENCES [dbo].[ADMIN] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[STORAGE] CHECK CONSTRAINT [fk_storage_admin_id]
GO
ALTER TABLE [dbo].[STORAGE_DETAIL]  WITH CHECK ADD  CONSTRAINT [fk_storage_detail_book_id] FOREIGN KEY([book_id])
REFERENCES [dbo].[BOOK] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[STORAGE_DETAIL] CHECK CONSTRAINT [fk_storage_detail_book_id]
GO
ALTER TABLE [dbo].[STORAGE_DETAIL]  WITH CHECK ADD  CONSTRAINT [fk_storage_detail_storeage_id] FOREIGN KEY([storage_id])
REFERENCES [dbo].[STORAGE] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[STORAGE_DETAIL] CHECK CONSTRAINT [fk_storage_detail_storeage_id]
GO
ALTER TABLE [dbo].[BOOK_LOST_DETAIL]  WITH CHECK ADD CHECK  (([amount]>(0)))
GO
ALTER TABLE [dbo].[LOCATION]  WITH CHECK ADD CHECK  (([max_storage]>(0)))
GO
ALTER TABLE [dbo].[STORAGE_DETAIL]  WITH CHECK ADD CHECK  (([amount]>(0)))
GO

/* Tạo người dùng */
-- Tạo tài khoản đăng nhập
USE MASTER
IF EXISTS(SELECT name FROM SYS.SERVER_PRINCIPALS WHERE name = 'book_garden_operator')
    BEGIN
        DROP LOGIN book_garden_operator
    END
GO
CREATE LOGIN book_garden_operator WITH PASSWORD = 'Bookgarden_001', DEFAULT_DATABASE = BookStore

-- Tạo người dùng cho tài khoản đăng nhập
USE BookStore
IF EXISTS(SELECT name FROM SYS.DATABASE_PRINCIPALS WHERE name = 'book_garden_operator')
    BEGIN
        DROP USER book_garden_operator
    END
GO
CREATE USER book_garden_operator FOR LOGIN book_garden_operator

-- Thêm vai trò cho người dùng
USE BookStore
ALTER ROLE db_owner ADD MEMBER book_garden_operator;
