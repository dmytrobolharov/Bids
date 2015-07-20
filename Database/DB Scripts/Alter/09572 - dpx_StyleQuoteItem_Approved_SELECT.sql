IF OBJECT_ID(N'[dbo].[dpx_StyleQuoteItem_Approved_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[dpx_StyleQuoteItem_Approved_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_StyleQuoteItem_Approved_SELECT]
(
	@Flag int
)
AS

/************************************************************/
/*@Flag:													*/
/* 1 = Quotes approved today.								*/
/* 2 = Quotes approved yesterday.							*/
/* 3 = Quotes approved this week.							*/
/* 4 = Quotes approved this week, broken down by day.		*/
/* 5 = Quotes approved this month. 							*/
/* 6 = Quotes approved this month, broken down by day. 		*/
/* 7 = Quotes approved this quarter. 						*/
/* 8 = Quotes approved this quarter, broken down by day.	*/
/* 9 = Quotes approved this quarter, broken down by month.	*/
/* 10 = Quotes approved this year.							*/
/* 11 = Quotes approved this year, broken down by month.	*/
/************************************************************/




--Global Variables.
DECLARE @DateTime datetime
DECLARE @DateTimeBegin datetime
DECLARE @DateTimeEnd datetime

DECLARE @ShortStringDate nvarchar(10)
DECLARE @StringDateBegin nvarchar(25)
DECLARE @StringDateEnd nvarchar(25)

DECLARE @DayOfTheWeek int
DECLARE @SubtractDays int
DECLARE @AddDays int

DECLARE @Year int
DECLARE @Month int


--Create all of the Temp tables, even if they're not used because the Query will break otherwise.
CREATE TABLE #tempApprovedQuotes
(
	TableRow int identity(1,1),
	[Count] int,
	StyleQuoteItemApprovedDate nvarchar(10)
)

CREATE TABLE #tempBrokenDown
(
	TableRow int identity(1,1),
	[Count] int,
	StyleQuoteItemApprovedDate nvarchar(10)
)

--Set the current date.
SET	@DateTime = GETDATE()

--Choose the right output depending on the flag chosen.
IF(@Flag = 1)	--Quotes approved today.
	BEGIN
		--Set current date variable to a short date format.
		SET @ShortStringDate = SUBSTRING(CONVERT(nvarchar(25), @DateTime, 120), 1, 10)
		
		--Set two variables to the beginning and end of the current date.
		SET @StringDateBegin = @ShortStringDate + ' 00:00:00.000'
		SET @StringDateEnd = @ShortStringDate + ' 23:59:59.998'
		
		--Get approved quotes for current date.
		SELECT
			uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,
			COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
			pStyleQuoteItemStatus.Custom AS Status,
			pStyleQuoteItem.StyleQuoteItemApprovedDate,
			pStyleQuoteItem.StyleQuoteItemApprovedBy
		FROM	pStyleQuoteItem
			LEFT OUTER JOIN pStyleQuoteItemStatus ON 	(pStyleQuoteItem.StyleQuoteItemStatusID = pStyleQuoteItemStatus.CustomKey)
			INNER JOIN pStyleHeader sh ON (pStyleQuoteItem.StyleID = sh.StyleID)
			LEFT OUTER JOIN uTradePartner ON	(pStyleQuoteItem.TradePartnerID = uTradePartner.TradePartnerID)
			LEFT OUTER JOIN uTradePartnerVendor ON	(pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID)
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pStyleQuoteItem.StyleQuoteItemStatusID = 3)
			AND	(pStyleQuoteItem.StyleQuoteItemApprovedDate >= @StringDateBegin
				AND	pStyleQuoteItem.StyleQuoteItemApprovedDate <= @StringDateEnd)
		ORDER BY	uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass),
			COALESCE(sr.SizeRangeCode, sh.SizeRange)
	END
ELSE IF(@Flag = 2)	--Quotes approved yesterday.
	BEGIN
		--Set the date to one day less than the current date.
		SET @DateTime = DATEADD(day, -1, @DateTime)
		
		--Set current date variable to a short date format.
		SET @ShortStringDate = SUBSTRING(CONVERT(nvarchar(25), @DateTime, 120), 1, 10)
		
		--Set two variables to the beginning and end of the current date.
		SET @StringDateBegin = @ShortStringDate + ' 00:00:00.000'
		SET @StringDateEnd = @ShortStringDate + ' 23:59:59.998'
		
		--Get approved quotes for yesterday.
		SELECT
			uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,
			COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
			pStyleQuoteItemStatus.Custom AS Status,
			pStyleQuoteItem.StyleQuoteItemApprovedDate,
			pStyleQuoteItem.StyleQuoteItemApprovedBy
		FROM	pStyleQuoteItem
			LEFT OUTER JOIN pStyleQuoteItemStatus ON 	(pStyleQuoteItem.StyleQuoteItemStatusID = pStyleQuoteItemStatus.CustomKey)
			INNER JOIN pStyleHeader sh ON (pStyleQuoteItem.StyleID = sh.StyleID)
			LEFT OUTER JOIN uTradePartner ON	(pStyleQuoteItem.TradePartnerID = uTradePartner.TradePartnerID)
			LEFT OUTER JOIN uTradePartnerVendor ON	(pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID)
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pStyleQuoteItem.StyleQuoteItemStatusID = 3)
			AND	(pStyleQuoteItem.StyleQuoteItemApprovedDate >= @StringDateBegin
				AND	pStyleQuoteItem.StyleQuoteItemApprovedDate <= @StringDateEnd)
		ORDER BY	uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass),
			COALESCE(sr.SizeRangeCode, sh.SizeRange)
	END
ELSE IF(@Flag = 3)	--Quotes approved this week.
	BEGIN
		--Set the first day of the week to Monday.
		SET DATEFIRST 1
		
		--Get the integer equivalent of the day of the week.
		SET @DayOfTheWeek = DATEPART(dw, @DateTime)
		
		--Find out where the current date is in comparison to the beginning and end of the week.
		SET @SubtractDays = 1 - @DayOfTheWeek
		SET @AddDays = 7 - @DayOfTheWeek
		
		--Set the dates for the beginning and end of the week.
		SET @DateTimeBegin = DATEADD(day, @SubtractDays, @DateTime)
		SET @DateTimeEnd = DATEADD(day, @AddDays, @DateTime)
		
		--Set beginning and end of week date variables to a short date format.
		SET @StringDateBegin = SUBSTRING(CONVERT(nvarchar(25), @DateTimeBegin, 120), 1, 10)
		SET @StringDateEnd = SUBSTRING(CONVERT(nvarchar(25), @DateTimeEnd, 120), 1, 10)
		
		--Set two variables to the beginning and end of the current week.
		SET @StringDateBegin = @StringDateBegin + ' 00:00:00.000'
		SET @StringDateEnd = @StringDateEnd + ' 23:59:59.998'
		
		--Get approved quotes for current week.
		SELECT
			uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,
			COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
			pStyleQuoteItemStatus.Custom AS Status,
			pStyleQuoteItem.StyleQuoteItemApprovedDate,
			pStyleQuoteItem.StyleQuoteItemApprovedBy
		FROM	pStyleQuoteItem
			LEFT OUTER JOIN pStyleQuoteItemStatus ON 	(pStyleQuoteItem.StyleQuoteItemStatusID = pStyleQuoteItemStatus.CustomKey)
			INNER JOIN pStyleHeader sh ON	(pStyleQuoteItem.StyleID = sh.StyleID)
			LEFT OUTER JOIN uTradePartner ON	(pStyleQuoteItem.TradePartnerID = uTradePartner.TradePartnerID)
			LEFT OUTER JOIN uTradePartnerVendor ON	(pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID)
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pStyleQuoteItem.StyleQuoteItemStatusID = 3)
			AND	(pStyleQuoteItem.StyleQuoteItemApprovedDate >= @StringDateBegin
				AND	pStyleQuoteItem.StyleQuoteItemApprovedDate <= @StringDateEnd)
		ORDER BY	uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass),
			COALESCE(sr.SizeRangeCode, sh.SizeRange)
	END
ELSE IF(@Flag = 4)	--Quotes approved this week, broken down by day.
	BEGIN
		--Set the first day of the week to Monday.
		SET DATEFIRST 1
		
		--Get the integer equivalent of the day of the week.
		SET @DayOfTheWeek = DATEPART(dw, @DateTime)
		
		--Find out where the current date is in comparison to the beginning and end of the week.
		SET @SubtractDays = 1 - @DayOfTheWeek
		SET @AddDays = 7 - @DayOfTheWeek
		
		--Set the dates for the beginning and end of the week.
		SET @DateTimeBegin = DATEADD(day, @SubtractDays, @DateTime)
		SET @DateTimeEnd = DATEADD(day, @AddDays, @DateTime)
		
		--Set beginning and end of week date variables to a short date format.
		SET @StringDateBegin = SUBSTRING(CONVERT(nvarchar(25), @DateTimeBegin, 120), 1, 10)
		SET @StringDateEnd = SUBSTRING(CONVERT(nvarchar(25), @DateTimeEnd, 120), 1, 10)
		
		--Set two variables to the beginning and end of the current week.
		SET @StringDateBegin = @StringDateBegin + ' 00:00:00.000'
		SET @StringDateEnd = @StringDateEnd + ' 23:59:59.998'
		
		--Set the datetime versions of the beginning and end of the date range to use for the loop.
		SET @DateTimeBegin = @StringDateBegin
		SET @DateTimeEnd = @StringDateEnd
		
		--Get approved samples for the specified date range.
		INSERT INTO #tempApprovedQuotes ([Count], StyleQuoteItemApprovedDate)
		SELECT	COUNT(*), SUBSTRING(CONVERT(nvarchar(25), pStyleQuoteItem.StyleQuoteItemApprovedDate, 120), 1, 10) AS StyleQuoteItemApprovedDate
		FROM	pStyleQuoteItem
		WHERE	(pStyleQuoteItem.StyleQuoteItemStatusID = 3)
			AND	(pStyleQuoteItem.StyleQuoteItemApprovedDate >= @StringDateBegin
				AND	pStyleQuoteItem.StyleQuoteItemApprovedDate <= @StringDateEnd)
		GROUP BY	SUBSTRING(CONVERT(nvarchar(25), pStyleQuoteItem.StyleQuoteItemApprovedDate, 120), 1, 10)
		
		--Loop to populate the broken down temp table with dates only.
		WHILE(@DateTimeBegin <= @DateTimeEnd)
			BEGIN
				--Add each day of the specified date range one day at a time.
				INSERT INTO #tempBrokenDown (StyleQuoteItemApprovedDate)
				VALUES (SUBSTRING(CONVERT(nvarchar(25), @DateTimeBegin, 120), 1, 10))
		
				--Move to the next day.
				SET @DateTimeBegin = DATEADD(day, 1, @DateTimeBegin)
			END
		
		--Update the broken down temp table with numbers.
		UPDATE	#tempBrokenDown
		SET	#tempBrokenDown.[Count] = #tempApprovedQuotes.[Count]
		FROM	#tempApprovedQuotes
			INNER JOIN #tempBrokenDown ON #tempApprovedQuotes.StyleQuoteItemApprovedDate = #tempBrokenDown.StyleQuoteItemApprovedDate
		
		--Fill in the NULLS with zeros.
		UPDATE	#tempBrokenDown
		SET	[Count] = 0
		WHERE	[Count] IS NULL
		
		--Get the data from the broken down temp table.
		SELECT	[Count], StyleQuoteItemApprovedDate
		FROM	#tempBrokenDown
	END
ELSE IF(@Flag = 5)	--Quotes approved this month.
	BEGIN
		--Get the integer equivalent of the month and the year.
		SET @Year = DATEPART(yyyy, @DateTime)
		SET @Month = DATEPART(mm, @DateTime)
		
		--Set the date for the beginning of the month.
		SET @DateTimeBegin = CAST(@Year AS nvarchar(4)) + '-' + CAST(@Month AS nvarchar(2)) + '-01'
		
		--Set the ending date to the beginning of the next month.
		SET @DateTimeEnd = DATEADD(month, 1, @DateTimeBegin)
		
		--Set the ending date to one day less than the beginning of the next month.
		SET @DateTimeEnd = DATEADD(day, -1, @DateTimeEnd)
		
		--Set beginning and end of month date variables to a short date format.
		SET @StringDateBegin = SUBSTRING(CONVERT(nvarchar(25), @DateTimeBegin, 120), 1, 10)
		SET @StringDateEnd = SUBSTRING(CONVERT(nvarchar(25), @DateTimeEnd, 120), 1, 10)
		
		--Set two variables to the beginning and end of the current month.
		SET @StringDateBegin = @StringDateBegin + ' 00:00:00.000'
		SET @StringDateEnd = @StringDateEnd + ' 23:59:59.998'
		
		--Get approved quotes for current month.
		SELECT
			uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,
			COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
			pStyleQuoteItemStatus.Custom AS Status,
			pStyleQuoteItem.StyleQuoteItemApprovedDate,
			pStyleQuoteItem.StyleQuoteItemApprovedBy
		FROM	pStyleQuoteItem
			LEFT OUTER JOIN pStyleQuoteItemStatus ON 	(pStyleQuoteItem.StyleQuoteItemStatusID = pStyleQuoteItemStatus.CustomKey)
			INNER JOIN pStyleHeader sh ON (pStyleQuoteItem.StyleID = sh.StyleID)
			LEFT OUTER JOIN uTradePartner ON	(pStyleQuoteItem.TradePartnerID = uTradePartner.TradePartnerID)
			LEFT OUTER JOIN uTradePartnerVendor ON	(pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID)
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pStyleQuoteItem.StyleQuoteItemStatusID = 3)
			AND	(pStyleQuoteItem.StyleQuoteItemApprovedDate >= @StringDateBegin
				AND	pStyleQuoteItem.StyleQuoteItemApprovedDate <= @StringDateEnd)
		ORDER BY	uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass),
			COALESCE(sr.SizeRangeCode, sh.SizeRange)
	END
ELSE IF(@Flag = 6)	--Quotes approved this month, broken down by day.
	BEGIN
		--Get the integer equivalent of the month and the year.
		SET @Year = DATEPART(yyyy, @DateTime)
		SET @Month = DATEPART(mm, @DateTime)
		
		--Set the date for the beginning of the month.
		SET @DateTimeBegin = CAST(@Year AS nvarchar(4)) + '-' + CAST(@Month AS nvarchar(2)) + '-01'
		
		--Set the ending date to the beginning of the next month.
		SET @DateTimeEnd = DATEADD(month, 1, @DateTimeBegin)
		
		--Set the ending date to one day less than the beginning of the next month.
		SET @DateTimeEnd = DATEADD(day, -1, @DateTimeEnd)
		
		--Set beginning and end of month date variables to a short date format.
		SET @StringDateBegin = SUBSTRING(CONVERT(nvarchar(25), @DateTimeBegin, 120), 1, 10)
		SET @StringDateEnd = SUBSTRING(CONVERT(nvarchar(25), @DateTimeEnd, 120), 1, 10)
		
		--Set two variables to the beginning and end of the current month.
		SET @StringDateBegin = @StringDateBegin + ' 00:00:00.000'
		SET @StringDateEnd = @StringDateEnd + ' 23:59:59.998'
		
		--Set the datetime versions of the beginning and end of the date range to use for the loop.
		SET @DateTimeBegin = @StringDateBegin
		SET @DateTimeEnd = @StringDateEnd
		
		--Get approved samples for the specified date range.
		INSERT INTO #tempApprovedQuotes ([Count], StyleQuoteItemApprovedDate)
		SELECT	COUNT(*), SUBSTRING(CONVERT(nvarchar(25), pStyleQuoteItem.StyleQuoteItemApprovedDate, 120), 1, 10) AS StyleQuoteItemApprovedDate
		FROM	pStyleQuoteItem
		WHERE	(pStyleQuoteItem.StyleQuoteItemStatusID = 3)
			AND	(pStyleQuoteItem.StyleQuoteItemApprovedDate >= @StringDateBegin
				AND	pStyleQuoteItem.StyleQuoteItemApprovedDate <= @StringDateEnd)
		GROUP BY	SUBSTRING(CONVERT(nvarchar(25), pStyleQuoteItem.StyleQuoteItemApprovedDate, 120), 1, 10)
		
		--Loop to populate the broken down temp table with dates only.
		WHILE(@DateTimeBegin <= @DateTimeEnd)
			BEGIN
				--Add each day of the specified date range one day at a time.
				INSERT INTO #tempBrokenDown (StyleQuoteItemApprovedDate)
				VALUES (SUBSTRING(CONVERT(nvarchar(25), @DateTimeBegin, 120), 1, 10))
		
				--Move to the next day.
				SET @DateTimeBegin = DATEADD(day, 1, @DateTimeBegin)
			END
		
		--Update the broken down temp table with numbers.
		UPDATE	#tempBrokenDown
		SET	#tempBrokenDown.[Count] = #tempApprovedQuotes.[Count]
		FROM	#tempApprovedQuotes
			INNER JOIN #tempBrokenDown ON #tempApprovedQuotes.StyleQuoteItemApprovedDate = #tempBrokenDown.StyleQuoteItemApprovedDate
		
		--Fill in the NULLS with zeros.
		UPDATE	#tempBrokenDown
		SET	[Count] = 0
		WHERE	[Count] IS NULL
		
		--Get the data from the broken down temp table.
		SELECT	[Count], StyleQuoteItemApprovedDate
		FROM	#tempBrokenDown
	END
ELSE IF(@Flag = 7)	--Quotes approved this quarter.
	BEGIN
		--Get the integer equivalent of the month and the year.
		SET @Year = DATEPART(yyyy, @DateTime)
		SET @Month = DATEPART(mm, @DateTime)
		
		--Set the beginning month for the Quarter depending on the current month.
		IF(@Month = 1 OR @Month = 2 OR @Month = 3)
			BEGIN
				SET @DateTimeBegin = CAST(@Year AS nvarchar(4)) + '-01-01'
			END
		ELSE IF(@Month = 4 OR @Month = 5 OR @Month = 6)
			BEGIN
				SET @DateTimeBegin = CAST(@Year AS nvarchar(4)) + '-04-01'
			END
		ELSE IF(@Month = 7 OR @Month = 8 OR @Month = 9)
			BEGIN
				SET @DateTimeBegin = CAST(@Year AS nvarchar(4)) + '-07-01'
			END
		ELSE IF(@Month = 10 OR @Month = 11 OR @Month = 12)
			BEGIN
				SET @DateTimeBegin = CAST(@Year AS nvarchar(4)) + '-10-01'
			END
		
		--Set the ending date to 3 months ahead.
		SET @DateTimeEnd = DATEADD(month, 3, @DateTimeBegin)
		
		--Set the ending date to one day less than the ending date of 3 months ahead.
		SET @DateTimeEnd = DATEADD(day, -1, @DateTimeEnd)
		
		--Set beginning and end of month date variables to a short date format.
		SET @StringDateBegin = SUBSTRING(CONVERT(nvarchar(25), @DateTimeBegin, 120), 1, 10)
		SET @StringDateEnd = SUBSTRING(CONVERT(nvarchar(25), @DateTimeEnd, 120), 1, 10)
		
		--Set two variables to the beginning and end of the current month.
		SET @StringDateBegin = @StringDateBegin + ' 00:00:00.000'
		SET @StringDateEnd = @StringDateEnd + ' 23:59:59.998'
		
		--Get approved quotes for current month.
		SELECT
			uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,
			COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
			pStyleQuoteItemStatus.Custom AS Status,
			pStyleQuoteItem.StyleQuoteItemApprovedDate,
			pStyleQuoteItem.StyleQuoteItemApprovedBy
		FROM	pStyleQuoteItem
			LEFT OUTER JOIN pStyleQuoteItemStatus ON 	(pStyleQuoteItem.StyleQuoteItemStatusID = pStyleQuoteItemStatus.CustomKey)
			INNER JOIN pStyleHeader sh ON (pStyleQuoteItem.StyleID = sh.StyleID)
			LEFT OUTER JOIN uTradePartner ON	(pStyleQuoteItem.TradePartnerID = uTradePartner.TradePartnerID)
			LEFT OUTER JOIN uTradePartnerVendor ON	(pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID)
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pStyleQuoteItem.StyleQuoteItemStatusID = 3)
			AND	(pStyleQuoteItem.StyleQuoteItemApprovedDate >= @StringDateBegin
				AND	pStyleQuoteItem.StyleQuoteItemApprovedDate <= @StringDateEnd)
		ORDER BY	uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass),
			COALESCE(sr.SizeRangeCode, sh.SizeRange)
	END
ELSE IF(@Flag = 8)	--Quotes approved this quarter, broken down by day.
	BEGIN
		--Get the integer equivalent of the month and the year.
		SET @Year = DATEPART(yyyy, @DateTime)
		SET @Month = DATEPART(mm, @DateTime)
		
		--Set the beginning month for the Quarter depending on the current month.
		IF(@Month = 1 OR @Month = 2 OR @Month = 3)
			BEGIN
				SET @DateTimeBegin = CAST(@Year AS nvarchar(4)) + '-01-01'
			END
		ELSE IF(@Month = 4 OR @Month = 5 OR @Month = 6)
			BEGIN
				SET @DateTimeBegin = CAST(@Year AS nvarchar(4)) + '-04-01'
			END
		ELSE IF(@Month = 7 OR @Month = 8 OR @Month = 9)
			BEGIN
				SET @DateTimeBegin = CAST(@Year AS nvarchar(4)) + '-07-01'
			END
		ELSE IF(@Month = 10 OR @Month = 11 OR @Month = 12)
			BEGIN
				SET @DateTimeBegin = CAST(@Year AS nvarchar(4)) + '-10-01'
			END
		
		--Set the ending date to 3 months ahead.
		SET @DateTimeEnd = DATEADD(month, 3, @DateTimeBegin)
		
		--Set the ending date to one day less than the ending date of 3 months ahead.
		SET @DateTimeEnd = DATEADD(day, -1, @DateTimeEnd)
		
		--Set beginning and end of month date variables to a short date format.
		SET @StringDateBegin = SUBSTRING(CONVERT(nvarchar(25), @DateTimeBegin, 120), 1, 10)
		SET @StringDateEnd = SUBSTRING(CONVERT(nvarchar(25), @DateTimeEnd, 120), 1, 10)
		
		--Set two variables to the beginning and end of the current month.
		SET @StringDateBegin = @StringDateBegin + ' 00:00:00.000'
		SET @StringDateEnd = @StringDateEnd + ' 23:59:59.998'
		
		--Set the datetime versions of the beginning and end of the date range to use for the loop.
		SET @DateTimeBegin = @StringDateBegin
		SET @DateTimeEnd = @StringDateEnd
		
		--Get approved samples for the specified date range.
		INSERT INTO #tempApprovedQuotes ([Count], StyleQuoteItemApprovedDate)
		SELECT	COUNT(*), SUBSTRING(CONVERT(nvarchar(25), pStyleQuoteItem.StyleQuoteItemApprovedDate, 120), 1, 10) AS StyleQuoteItemApprovedDate
		FROM	pStyleQuoteItem
		WHERE	(pStyleQuoteItem.StyleQuoteItemStatusID = 3)
			AND	(pStyleQuoteItem.StyleQuoteItemApprovedDate >= @StringDateBegin
				AND	pStyleQuoteItem.StyleQuoteItemApprovedDate <= @StringDateEnd)
		GROUP BY	SUBSTRING(CONVERT(nvarchar(25), pStyleQuoteItem.StyleQuoteItemApprovedDate, 120), 1, 10)
		
		--Loop to populate the broken down temp table with dates only.
		WHILE(@DateTimeBegin <= @DateTimeEnd)
			BEGIN
				--Add each day of the specified date range one day at a time.
				INSERT INTO #tempBrokenDown (StyleQuoteItemApprovedDate)
				VALUES (SUBSTRING(CONVERT(nvarchar(25), @DateTimeBegin, 120), 1, 10))
		
				--Move to the next day.
				SET @DateTimeBegin = DATEADD(day, 1, @DateTimeBegin)
			END
		
		--Update the broken down temp table with numbers.
		UPDATE	#tempBrokenDown
		SET	#tempBrokenDown.[Count] = #tempApprovedQuotes.[Count]
		FROM	#tempApprovedQuotes
			INNER JOIN #tempBrokenDown ON #tempApprovedQuotes.StyleQuoteItemApprovedDate = #tempBrokenDown.StyleQuoteItemApprovedDate
		
		--Fill in the NULLS with zeros.
		UPDATE	#tempBrokenDown
		SET	[Count] = 0
		WHERE	[Count] IS NULL
		
		--Get the data from the broken down temp table.
		SELECT	[Count], StyleQuoteItemApprovedDate
		FROM	#tempBrokenDown
	END
ELSE IF(@Flag = 9)	--Quotes approved this quarter, broken down by month.
	BEGIN
		--Get the integer equivalent of the month and the year.
		SET @Year = DATEPART(yyyy, @DateTime)
		SET @Month = DATEPART(mm, @DateTime)
		
		--Set the beginning month for the Quarter depending on the current month.
		IF(@Month = 1 OR @Month = 2 OR @Month = 3)
			BEGIN
				SET @DateTimeBegin = CAST(@Year AS nvarchar(4)) + '-01-01'
			END
		ELSE IF(@Month = 4 OR @Month = 5 OR @Month = 6)
			BEGIN
				SET @DateTimeBegin = CAST(@Year AS nvarchar(4)) + '-04-01'
			END
		ELSE IF(@Month = 7 OR @Month = 8 OR @Month = 9)
			BEGIN
				SET @DateTimeBegin = CAST(@Year AS nvarchar(4)) + '-07-01'
			END
		ELSE IF(@Month = 10 OR @Month = 11 OR @Month = 12)
			BEGIN
				SET @DateTimeBegin = CAST(@Year AS nvarchar(4)) + '-10-01'
			END
		
		--Set the ending date to 3 months ahead.
		SET @DateTimeEnd = DATEADD(month, 3, @DateTimeBegin)
		
		--Set the ending date to one day less than the ending date of 3 months ahead.
		SET @DateTimeEnd = DATEADD(day, -1, @DateTimeEnd)
		
		--Set beginning and end of month date variables to a short date format.
		SET @StringDateBegin = SUBSTRING(CONVERT(nvarchar(25), @DateTimeBegin, 120), 1, 10)
		SET @StringDateEnd = SUBSTRING(CONVERT(nvarchar(25), @DateTimeEnd, 120), 1, 10)
		
		--Set two variables to the beginning and end of the current month.
		SET @StringDateBegin = @StringDateBegin + ' 00:00:00.000'
		SET @StringDateEnd = @StringDateEnd + ' 23:59:59.998'
		
		--Set the datetime versions of the beginning and end of the date range to use for the loop.
		SET @DateTimeBegin = @StringDateBegin
		SET @DateTimeEnd = @StringDateEnd
		
		--Get approved samples for the specified date range.
		INSERT INTO #tempApprovedQuotes ([Count], StyleQuoteItemApprovedDate)
		SELECT	COUNT(*), SUBSTRING(CONVERT(nvarchar(25), pStyleQuoteItem.StyleQuoteItemApprovedDate, 120), 1, 7) AS StyleQuoteItemApprovedDate
		FROM	pStyleQuoteItem
		WHERE	(pStyleQuoteItem.StyleQuoteItemStatusID = 3)
			AND	(pStyleQuoteItem.StyleQuoteItemApprovedDate >= @StringDateBegin
				AND	pStyleQuoteItem.StyleQuoteItemApprovedDate <= @StringDateEnd)
		GROUP BY	SUBSTRING(CONVERT(nvarchar(25), pStyleQuoteItem.StyleQuoteItemApprovedDate, 120), 1, 7)
		
		--Loop to populate the broken down temp table with dates only.
		WHILE(@DateTimeBegin <= @DateTimeEnd)
			BEGIN
				--Add each day of the specified date range one day at a time.
				INSERT INTO #tempBrokenDown (StyleQuoteItemApprovedDate)
				VALUES (SUBSTRING(CONVERT(nvarchar(25), @DateTimeBegin, 120), 1, 7))
		
				--Move to the next month.
				SET @DateTimeBegin = DATEADD(month, 1, @DateTimeBegin)
			END
		
		--Update the broken down temp table with numbers.
		UPDATE	#tempBrokenDown
		SET	#tempBrokenDown.[Count] = #tempApprovedQuotes.[Count]
		FROM	#tempApprovedQuotes
			INNER JOIN #tempBrokenDown ON #tempApprovedQuotes.StyleQuoteItemApprovedDate = #tempBrokenDown.StyleQuoteItemApprovedDate
		
		--Fill in the NULLS with zeros.
		UPDATE	#tempBrokenDown
		SET	[Count] = 0
		WHERE	[Count] IS NULL
		
		--Get the data from the broken down temp table.
		SELECT	[Count], StyleQuoteItemApprovedDate
		FROM	#tempBrokenDown
	END
ELSE IF(@Flag = 10)	--Quotes approved this year.
	BEGIN
		--Get the integer equivalent of the year.
		SET @Year = DATEPART(yyyy, @DateTime)
		
		--Set the date for the beginning and end of the year.
		SET @DateTimeBegin = CAST(@Year AS nvarchar(4)) + '-01-01'
		SET @DateTimeEnd = CAST(@Year AS nvarchar(4)) + '-12-31'
		
		--Set beginning and end of month date variables to a short date format.
		SET @StringDateBegin = SUBSTRING(CONVERT(nvarchar(25), @DateTimeBegin, 120), 1, 10)
		SET @StringDateEnd = SUBSTRING(CONVERT(nvarchar(25), @DateTimeEnd, 120), 1, 10)
		
		--Set two variables to the beginning and end of the current month.
		SET @StringDateBegin = @StringDateBegin + ' 00:00:00.000'
		SET @StringDateEnd = @StringDateEnd + ' 23:59:59.998'
		
		--Get approved quotes for current month.
		SELECT
			uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,
			COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
			pStyleQuoteItemStatus.Custom AS Status,
			pStyleQuoteItem.StyleQuoteItemApprovedDate,
			pStyleQuoteItem.StyleQuoteItemApprovedBy
		FROM	pStyleQuoteItem
			LEFT OUTER JOIN pStyleQuoteItemStatus ON 	(pStyleQuoteItem.StyleQuoteItemStatusID = pStyleQuoteItemStatus.CustomKey)
			INNER JOIN pStyleHeader sh ON (pStyleQuoteItem.StyleID = sh.StyleID)
			LEFT OUTER JOIN uTradePartner ON	(pStyleQuoteItem.TradePartnerID = uTradePartner.TradePartnerID)
			LEFT OUTER JOIN uTradePartnerVendor ON	(pStyleQuoteItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID)
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pStyleQuoteItem.StyleQuoteItemStatusID = 3)
			AND	(pStyleQuoteItem.StyleQuoteItemApprovedDate >= @StringDateBegin
				AND	pStyleQuoteItem.StyleQuoteItemApprovedDate <= @StringDateEnd)
		ORDER BY	uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass),
			COALESCE(sr.SizeRangeCode, sh.SizeRange)
	END
ELSE IF(@Flag = 11)	--Quotes approved this year, broken down by month.
	BEGIN
		--Get the integer equivalent of the year.
		SET @Year = DATEPART(yyyy, @DateTime)
		
		--Set the date for the beginning and end of the year.
		SET @DateTimeBegin = CAST(@Year AS nvarchar(4)) + '-01-01'
		SET @DateTimeEnd = CAST(@Year AS nvarchar(4)) + '-12-31'
		
		--Set beginning and end of month date variables to a short date format.
		SET @StringDateBegin = SUBSTRING(CONVERT(nvarchar(25), @DateTimeBegin, 120), 1, 10)
		SET @StringDateEnd = SUBSTRING(CONVERT(nvarchar(25), @DateTimeEnd, 120), 1, 10)
		
		--Set two variables to the beginning and end of the current month.
		SET @StringDateBegin = @StringDateBegin + ' 00:00:00.000'
		SET @StringDateEnd = @StringDateEnd + ' 23:59:59.998'
		
		--Set the datetime versions of the beginning and end of the date range to use for the loop.
		SET @DateTimeBegin = @StringDateBegin
		SET @DateTimeEnd = @StringDateEnd
		
		--Get approved samples for the specified date range.
		INSERT INTO #tempApprovedQuotes ([Count], StyleQuoteItemApprovedDate)
		SELECT	COUNT(*), SUBSTRING(CONVERT(nvarchar(25), pStyleQuoteItem.StyleQuoteItemApprovedDate, 120), 1, 7) AS StyleQuoteItemApprovedDate
		FROM	pStyleQuoteItem
		WHERE	(pStyleQuoteItem.StyleQuoteItemStatusID = 3)
			AND	(pStyleQuoteItem.StyleQuoteItemApprovedDate >= @StringDateBegin
				AND	pStyleQuoteItem.StyleQuoteItemApprovedDate <= @StringDateEnd)
		GROUP BY	SUBSTRING(CONVERT(nvarchar(25), pStyleQuoteItem.StyleQuoteItemApprovedDate, 120), 1, 7)
		
		--Loop to populate the broken down temp table with dates only.
		WHILE(@DateTimeBegin <= @DateTimeEnd)
			BEGIN
				--Add each day of the specified date range one day at a time.
				INSERT INTO #tempBrokenDown (StyleQuoteItemApprovedDate)
				VALUES (SUBSTRING(CONVERT(nvarchar(25), @DateTimeBegin, 120), 1, 7))
		
				--Move to the next month.
				SET @DateTimeBegin = DATEADD(month, 1, @DateTimeBegin)
			END
		
		--Update the broken down temp table with numbers.
		UPDATE	#tempBrokenDown
		SET	#tempBrokenDown.[Count] = #tempApprovedQuotes.[Count]
		FROM	#tempApprovedQuotes
			INNER JOIN #tempBrokenDown ON #tempApprovedQuotes.StyleQuoteItemApprovedDate = #tempBrokenDown.StyleQuoteItemApprovedDate
		
		--Fill in the NULLS with zeros.
		UPDATE	#tempBrokenDown
		SET	[Count] = 0
		WHERE	[Count] IS NULL
		
		--Get the data from the broken down temp table.
		SELECT	[Count], StyleQuoteItemApprovedDate
		FROM	#tempBrokenDown
	END

--Drop Temp tables.
DROP TABLE #tempApprovedQuotes
DROP TABLE #tempBrokenDown

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09572', GetDate())
GO
