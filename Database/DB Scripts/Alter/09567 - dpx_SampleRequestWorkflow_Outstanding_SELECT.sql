IF OBJECT_ID(N'[dbo].[dpx_SampleRequestWorkflow_Outstanding_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[dpx_SampleRequestWorkflow_Outstanding_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_SampleRequestWorkflow_Outstanding_SELECT]
(
	@Flag int
)
AS

/********************************************************/
/*@Flag:												*/
/* 1 = Submits outstanding, by category.				*/
/* 2 = Submits outstanding, by season and year.			*/
/* 3 = Submits outstanding, by vendor.					*/
/* 4 = Submits outstanding, number of days late.		*/
/* 5 = Submits outstanding, by user with days late.		*/
/********************************************************/

--Global Variables.
DECLARE @DateTime datetime
DECLARE @DateTimeYesterday datetime
DECLARE @StringDateYesterday nvarchar(25)

DECLARE @RowCounter int
DECLARE @TotalCount int
DECLARE @YearDifference int

--Create all of the Temp tables, even if they're not used because the Query will break otherwise.
CREATE TABLE #tempLateSamples
(
	TableRow int identity(1,1),
	AssignedTo nvarchar(100),
	StyleNo nvarchar(20),
	SizeClass nvarchar(400),
	SizeRange nvarchar(200),
	Season nvarchar(200),
	[Year] nvarchar(200),
	GroupName nvarchar(50),
	Status nvarchar(200),
	DueDate datetime,
	SampleRequestWorkflowID uniqueidentifier,
	CurrentYear int,
	CurrentDayNumber int,
	DueDateYear int,
	DueDateDayNumber int,
	DaysLate int
)

--Set the current date and time.
SET @DateTime = GETDATE()

--Get the date of one day less than the current date.
SET @DateTimeYesterday = DATEADD(day, -1, @DateTime)

--Set yesterday's date to a short date format.
SET @StringDateYesterday = SUBSTRING(CONVERT(nvarchar(25), @DateTimeYesterday, 120), 1, 10)

--Set the yesterday string variable to the very end of yesterday's date.
SET @StringDateYesterday = @StringDateYesterday + ' 23:59:59.998'

--Set the yesterday date time variable.
SET @DateTimeYesterday = @StringDateYesterday

--Choose the right output depending on the flag chosen.
IF(@Flag = 1)	--Submits outstanding, by category.
	BEGIN
		--Get all of the outstanding samples by category.
		SELECT
			COUNT(*) AS [Count],
		--	pSampleRequestWorkflow.SampleRequestWorkflowID,
			pStyleCategory.StyleCategory
		FROM pSampleRequestWorkflow
			INNER JOIN pStyleHeader sh ON	pSampleRequestWorkflow.StyleID = sh.StyleID
			LEFT OUTER JOIN pStyleCategory ON	sh.StyleCategory = pStyleCategory.StyleCategoryID
		WHERE	(pSampleRequestWorkflow.Status = 0)
			AND	(pSampleRequestWorkflow.DueDate <= @DateTimeYesterday)
		GROUP BY	pStyleCategory.StyleCategory
	END
ELSE IF(@Flag = 2)	--Submits outstanding, by season and year.
	BEGIN
		--Get all of the outstanding samples by category.
		SELECT
			COUNT(*) AS [Count],
		--	pSampleRequestWorkflow.SampleRequestWorkflowID,
			sh.CustomField2 AS Season,
			sh.CustomField4 AS [Year]
		FROM pSampleRequestWorkflow
			INNER JOIN pStyleHeader sh ON	pSampleRequestWorkflow.StyleID = sh.StyleID
		WHERE	(pSampleRequestWorkflow.status = 0)
			AND	(pSampleRequestWorkflow.DueDate <= @DateTimeYesterday)
		GROUP BY	sh.CustomField2, sh.CustomField4
	END
ELSE IF(@Flag = 3)	--Submits outstanding, by vendor.
	BEGIN
		--Get all of the outstanding samples by category.
		SELECT
			COUNT(*) AS [Count],
		--	pSampleRequestWorkflow.SampleRequestWorkflowID,
			uTradePartner.TradePartnerName,
			uTradePartnerVendor.VendorName
		FROM pSampleRequestWorkflow
			INNER JOIN pStyleHeader sh ON	pSampleRequestWorkflow.StyleID = sh.StyleID
			LEFT OUTER JOIN uTradePartner ON	(pSampleRequestWorkflow.TradePartnerID = uTradePartner.TradePartnerID)
			LEFT OUTER JOIN uTradePartnerVendor ON	(pSampleRequestWorkflow.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID)
		WHERE	(pSampleRequestWorkflow.Status = 0)
			AND	(pSampleRequestWorkflow.DueDate <= @DateTimeYesterday)
		GROUP BY	uTradePartner.TradePartnerName, uTradePartnerVendor.VendorName
		ORDER BY	uTradePartner.TradePartnerName, uTradePartnerVendor.VendorName
	END
ELSE IF(@Flag = 4)	--Submits outstanding, number of days late.
	BEGIN
		--Get all of the outstanding samples.
		INSERT INTO #tempLateSamples(
			SampleRequestWorkflowID,
			CurrentYear,
			CurrentDayNumber,
			DueDateYear,
			DueDateDayNumber)
		SELECT
			SampleRequestWorkflowID,
			DATEPART(yyyy, @DateTime) AS CurrentYear,
			DATEPART(dy, @DateTime) AS CurrentDayNumber,
			DATEPART(yyyy, DueDate) AS DueDateYear,
			DATEPART(dy, DueDate) AS DueDateDayNumber
		FROM	pSampleRequestWorkflow
		WHERE	(Status = 0)
			AND	(DueDate <= @DateTimeYesterday)
		
		--Get count of all outstanding samples.
		SELECT	@TotalCount = COUNT(*)
		FROM	#tempLateSamples
		
		--Set row counter.
		SET	@RowCounter = 1
		
		--Loop to calculate late days.
		WHILE(@RowCounter <= @TotalCount)
			BEGIN
				--Get the year difference.
				SELECT	@YearDifference = CurrentYear - DueDateYear
				FROM	#tempLateSamples
				WHERE	TableRow = @RowCounter
		
				--Begin calculating the days late based upon the differences of the years and days.
				IF(@YearDifference = 0)
					BEGIN
						UPDATE	#tempLateSamples
						SET	DaysLate = CurrentDayNumber - DueDateDayNumber
						WHERE	TableRow = @RowCounter
					END
				ELSE IF(@YearDifference = 1)
					BEGIN
						UPDATE	#tempLateSamples
						SET	DaysLate = (365 - DueDateDayNumber) + CurrentDayNumber
						WHERE	TableRow = @RowCounter
					END
				ELSE IF(@YearDifference > 1)
					BEGIN
						UPDATE	#tempLateSamples
						SET	DaysLate = ((@YearDifference - 1) * 365) + (365 - DueDateDayNumber) + CurrentDayNumber
						WHERE	TableRow = @RowCounter
					END
		
				--Up the row counter.
				SET @RowCounter = @RowCounter + 1
			END
		
		--Show the number of late items grouped by the number of days late.
		SELECT	COUNT(*) AS [Count], DaysLate
		FROM	#tempLateSamples
		GROUP BY	DaysLate
		ORDER BY	DaysLate DESC
	END
ELSE IF(@Flag = 5)	--Submits outstanding, by user with days late.
	BEGIN
		--Get all of the outstanding samples.
		INSERT INTO #tempLateSamples(
			AssignedTo,
			StyleNo,
			SizeClass,
			SizeRange,
			Season,
			[Year],
			GroupName,
			Status,
			DueDate,
			CurrentYear,
			CurrentDayNumber,
			DueDateYear,
			DueDateDayNumber)
		SELECT
			Users.Firstname + ' ' + Users.LastName AS AssignedTo,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass),
			COALESCE(sr.SizeRangeCode, sh.SizeRange),
			sh.CustomField2 AS Season,
			sh.CustomField4 AS [Year],
			pSampleWorkflow.GroupName,
			pSampleRequestSubmitStatus.Status,
			pSampleRequestWorkflow.DueDate,
			DATEPART(yyyy, @DateTime) AS CurrentYear,
			DATEPART(dy, @DateTime) AS CurrentDayNumber,
			DATEPART(yyyy, pSampleRequestWorkflow.DueDate) AS DueDateYear,
			DATEPART(dy, pSampleRequestWorkflow.DueDate) AS DueDateDayNumber
		FROM pSampleRequestWorkflow
			INNER JOIN pStyleHeader sh ON pSampleRequestWorkflow.StyleID = sh.StyleID
			LEFT OUTER JOIN pSampleRequestSubmitStatus ON	pSampleRequestWorkflow.Status = pSampleRequestSubmitStatus.StatusID
			LEFT OUTER JOIN pSampleWorkflow ON	pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
			LEFT OUTER JOIN Users ON	pSampleRequestWorkflow.AssignedTo = Users.UserID
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pSampleRequestWorkflow.Status = 0)
			AND	(pSampleRequestWorkflow.DueDate <= @DateTimeYesterday)

		--Get count of all outstanding samples.
		SELECT	@TotalCount = COUNT(*)
		FROM	#tempLateSamples
		
		--Set row counter.
		SET	@RowCounter = 1
		
		--Loop to calculate late days.
		WHILE(@RowCounter <= @TotalCount)
			BEGIN
				--Get the year difference.
				SELECT	@YearDifference = CurrentYear - DueDateYear
				FROM	#tempLateSamples
				WHERE	TableRow = @RowCounter
		
				--Begin calculating the days late based upon the differences of the years and days.
				IF(@YearDifference = 0)
					BEGIN
						UPDATE	#tempLateSamples
						SET	DaysLate = CurrentDayNumber - DueDateDayNumber
						WHERE	TableRow = @RowCounter
					END
				ELSE IF(@YearDifference = 1)
					BEGIN
						UPDATE	#tempLateSamples
						SET	DaysLate = (365 - DueDateDayNumber) + CurrentDayNumber
						WHERE	TableRow = @RowCounter
					END
				ELSE IF(@YearDifference > 1)
					BEGIN
						UPDATE	#tempLateSamples
						SET	DaysLate = ((@YearDifference - 1) * 365) + (365 - DueDateDayNumber) + CurrentDayNumber
						WHERE	TableRow = @RowCounter
					END
		
				--Up the row counter.
				SET @RowCounter = @RowCounter + 1
			END

		--Show all of the outstanding samples.
		SELECT
			AssignedTo,
			StyleNo,
			SizeClass,
			SizeRange,
			Season,
			[Year],
			GroupName,
			Status,
			DueDate,
			DaysLate
		FROM #tempLateSamples
		ORDER BY
			AssignedTo,
			DaysLate DESC,
			StyleNo,
			SizeClass,
			SizeRange,
			Season,
			[Year],
			GroupName
	END

--Drop Temp tables.
DROP TABLE #tempLateSamples

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09567', GetDate())
GO
