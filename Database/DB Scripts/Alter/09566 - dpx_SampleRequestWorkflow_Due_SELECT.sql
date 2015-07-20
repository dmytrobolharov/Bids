IF OBJECT_ID(N'[dbo].[dpx_SampleRequestWorkflow_Due_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[dpx_SampleRequestWorkflow_Due_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_SampleRequestWorkflow_Due_SELECT]
(
	@Flag int
)
AS

/****************************************************************************/
/*@Flag:																	*/
/* 1 = Sample workflows due today.											*/
/* 2 = Sample workflows due this week.										*/
/* 3 = Sample workflows due this month. 									*/
/* 4 = Sample workflows due this quarter. 									*/
/* 5 = Sample workflows due this year.										*/
/****************************************************************************/


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



--Set the current date.
SET	@DateTime = GETDATE()

--Choose the right output depending on the flag chosen.
IF(@Flag = 1)	--Sample workflows due today.
	BEGIN
		--Set current date variable to a short date format.
		SET @ShortStringDate = SUBSTRING(CONVERT(nvarchar(25), @DateTime, 120), 1, 10)
		
		--Set two variables to the beginning and end of the current date.
		SET @StringDateBegin = @ShortStringDate + ' 00:00:00.000'
		SET @StringDateEnd = @ShortStringDate + ' 23:59:59.998'
		
		--Get sample workflows due for the specified date range.
		SELECT
			Users.Firstname + ' ' + Users.LastName AS AssignedTo,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,
			COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
			sh.CustomField2 AS Season,
			sh.CustomField4 AS [Year],
			pSampleWorkflow.GroupName,
			pSampleRequestSubmitStatus.Status,
			pSampleRequestWorkflow.DueDate
		FROM pSampleRequestWorkflow
			INNER JOIN pStyleHeader sh ON pSampleRequestWorkflow.StyleID = sh.StyleID
			LEFT OUTER JOIN pSampleRequestSubmitStatus ON	pSampleRequestWorkflow.Status = pSampleRequestSubmitStatus.StatusID
			LEFT OUTER JOIN pSampleWorkflow ON	pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
			LEFT OUTER JOIN Users ON	pSampleRequestWorkflow.AssignedTo = Users.UserID
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pSampleRequestWorkflow.Status = 0)
			AND	(pSampleRequestWorkflow.DueDate >= @StringDateBegin
				AND	pSampleRequestWorkflow.DueDate <= @StringDateEnd)
		ORDER BY
			Users.Firstname + ' ' + Users.LastName,
			pSampleRequestWorkflow.DueDate,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass),
			COALESCE(sr.SizeRangeCode, sh.SizeRange),
			sh.CustomField2,
			sh.CustomField4,
			pSampleWorkflow.GroupName
	END
ELSE IF(@Flag = 2)	--Sample workflows due this week.
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
		
		--Set beginning and end of week date variables to a string date format, including today.
		SET @StringDateBegin = SUBSTRING(CONVERT(nvarchar(25), @DateTimeBegin, 120), 1, 10)
		SET @StringDateEnd = SUBSTRING(CONVERT(nvarchar(25), @DateTimeEnd, 120), 1, 10)
		
		--Set variables to the beginning and end of the current week and today's variable.
		SET @StringDateBegin = @StringDateBegin + ' 00:00:00.000'
		SET @StringDateEnd = @StringDateEnd + ' 23:59:59.998'
		
		--Get sample workflows due for the specified date range.
		SELECT
			Users.Firstname + ' ' + Users.LastName AS AssignedTo,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,
			COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
			sh.CustomField2 AS Season,
			sh.CustomField4 AS [Year],
			pSampleWorkflow.GroupName,
			pSampleRequestSubmitStatus.Status,
			pSampleRequestWorkflow.DueDate
		FROM pSampleRequestWorkflow
			INNER JOIN pStyleHeader sh ON pSampleRequestWorkflow.StyleID = sh.StyleID
			LEFT OUTER JOIN pSampleRequestSubmitStatus ON	pSampleRequestWorkflow.Status = pSampleRequestSubmitStatus.StatusID
			LEFT OUTER JOIN pSampleWorkflow ON	pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
			LEFT OUTER JOIN Users ON	pSampleRequestWorkflow.AssignedTo = Users.UserID
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pSampleRequestWorkflow.Status = 0)
			AND	(pSampleRequestWorkflow.DueDate >= @StringDateBegin
				AND	pSampleRequestWorkflow.DueDate <= @StringDateEnd)
		ORDER BY
			Users.Firstname + ' ' + Users.LastName,
			pSampleRequestWorkflow.DueDate,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass),
			COALESCE(sr.SizeRangeCode, sh.SizeRange),
			sh.CustomField2,
			sh.CustomField4,
			pSampleWorkflow.GroupName
	END
ELSE IF(@Flag = 3)	--Sample workflows due this month.
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
		
		--Get sample workflows due for the specified date range.
		SELECT
			Users.Firstname + ' ' + Users.LastName AS AssignedTo,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,
			COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
			sh.CustomField2 AS Season,
			sh.CustomField4 AS [Year],
			pSampleWorkflow.GroupName,
			pSampleRequestSubmitStatus.Status,
			pSampleRequestWorkflow.DueDate
		FROM pSampleRequestWorkflow
			INNER JOIN pStyleHeader sh ON pSampleRequestWorkflow.StyleID = sh.StyleID
			LEFT OUTER JOIN pSampleRequestSubmitStatus ON	pSampleRequestWorkflow.Status = pSampleRequestSubmitStatus.StatusID
			LEFT OUTER JOIN pSampleWorkflow ON	pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
			LEFT OUTER JOIN Users ON	pSampleRequestWorkflow.AssignedTo = Users.UserID
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pSampleRequestWorkflow.Status = 0)
			AND	(pSampleRequestWorkflow.DueDate >= @StringDateBegin
				AND	pSampleRequestWorkflow.DueDate <= @StringDateEnd)
		ORDER BY
			Users.Firstname + ' ' + Users.LastName,
			pSampleRequestWorkflow.DueDate,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass),
			COALESCE(sr.SizeRangeCode, sh.SizeRange),
			sh.CustomField2,
			sh.CustomField4,
			pSampleWorkflow.GroupName
	END
ELSE IF(@Flag = 4)	--Sample workflows due this quarter.
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
		
		--Get sample workflows due for the specified date range.
		SELECT
			Users.Firstname + ' ' + Users.LastName AS AssignedTo,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,
			COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
			sh.CustomField2 AS Season,
			sh.CustomField4 AS [Year],
			pSampleWorkflow.GroupName,
			pSampleRequestSubmitStatus.Status,
			pSampleRequestWorkflow.DueDate
		FROM pSampleRequestWorkflow
			INNER JOIN pStyleHeader sh ON pSampleRequestWorkflow.StyleID = sh.StyleID
			LEFT OUTER JOIN pSampleRequestSubmitStatus ON	pSampleRequestWorkflow.Status = pSampleRequestSubmitStatus.StatusID
			LEFT OUTER JOIN pSampleWorkflow ON	pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
			LEFT OUTER JOIN Users ON	pSampleRequestWorkflow.AssignedTo = Users.UserID
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pSampleRequestWorkflow.Status = 0)
			AND	(pSampleRequestWorkflow.DueDate >= @StringDateBegin
				AND	pSampleRequestWorkflow.DueDate <= @StringDateEnd)
		ORDER BY
			Users.Firstname + ' ' + Users.LastName,
			pSampleRequestWorkflow.DueDate,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass),
			COALESCE(sr.SizeRangeCode, sh.SizeRange),
			sh.CustomField2,
			sh.CustomField4,
			pSampleWorkflow.GroupName
	END
ELSE IF(@Flag = 5)	--Sample workflows due this year.
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

		--Get sample workflows due for the specified date range.
		SELECT
			Users.Firstname + ' ' + Users.LastName AS AssignedTo,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,
			COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange,
			sh.CustomField2 AS Season,
			sh.CustomField4 AS [Year],
			pSampleWorkflow.GroupName,
			pSampleRequestSubmitStatus.Status,
			pSampleRequestWorkflow.DueDate
		FROM pSampleRequestWorkflow
			INNER JOIN pStyleHeader sh ON pSampleRequestWorkflow.StyleID = sh.StyleID
			LEFT OUTER JOIN pSampleRequestSubmitStatus ON	pSampleRequestWorkflow.Status = pSampleRequestSubmitStatus.StatusID
			LEFT OUTER JOIN pSampleWorkflow ON	pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
			LEFT OUTER JOIN Users ON	pSampleRequestWorkflow.AssignedTo = Users.UserID
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pSampleRequestWorkflow.Status = 0)
			AND	(pSampleRequestWorkflow.DueDate >= @StringDateBegin
				AND	pSampleRequestWorkflow.DueDate <= @StringDateEnd)
		ORDER BY
			Users.Firstname + ' ' + Users.LastName,
			pSampleRequestWorkflow.DueDate,
			sh.StyleNo,
			COALESCE(sc.Custom, sh.SizeClass),
			COALESCE(sr.SizeRangeCode, sh.SizeRange),
			sh.CustomField2,
			sh.CustomField4,
			pSampleWorkflow.GroupName
	END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09566', GetDate())
GO
