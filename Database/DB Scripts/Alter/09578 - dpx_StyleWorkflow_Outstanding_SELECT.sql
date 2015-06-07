IF OBJECT_ID(N'[dbo].[dpx_StyleWorkflow_Outstanding_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[dpx_StyleWorkflow_Outstanding_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_StyleWorkflow_Outstanding_SELECT]
(
	@Flag int
)
AS

/************************************************************************/
/*@Flag:																*/
/* 1 = Style development workflows outstanding, by user with days late.	*/
/************************************************************************/


--Global Variables.
DECLARE @DateTime datetime
DECLARE @DateTimeYesterday datetime
DECLARE @StringDateYesterday nvarchar(25)

DECLARE @RowCounter int
DECLARE @TotalCount int
DECLARE @YearDifference int

--Create all of the Temp tables, even if they're not used because the Query will break otherwise.
CREATE TABLE #tempLateStyleDevelopmentWorkflows
(
	TableRow int identity(1,1),
	AssignedTo nvarchar(100),
	StyleNo nvarchar(20),
	SizeClass nvarchar(400),
	SizeRange nvarchar(200),
	Season nvarchar(200),
	[Year] nvarchar(200),
	Workflow nvarchar(100),
	WorkflowStatus nvarchar(100),
	DueDate datetime,
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
IF(@Flag = 1)	--Style development workflows outstanding, by user with days late.
	BEGIN
		--Get all of the outstanding samples.
		INSERT INTO #tempLateStyleDevelopmentWorkflows(
			AssignedTo,
			StyleNo,
			SizeClass,
			SizeRange,
			Season,
			[Year],
			Workflow,
			WorkflowStatus,
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
			pWorkflow.Workflow,
			pWorkflowStatus.WorkflowStatus,
			pStyleWorkflow.WorkDue AS DueDate,
			DATEPART(yyyy, @DateTime) AS CurrentYear,
			DATEPART(dy, @DateTime) AS CurrentDayNumber,
			DATEPART(yyyy, pStyleWorkflow.WorkDue) AS DueDateYear,
			DATEPART(dy, pStyleWorkflow.WorkDue) AS DueDateDayNumber
		FROM	pStyleWorkflow
			INNER JOIN pStyleHeader sh ON (pStyleWorkflow.StyleID = sh.StyleID)
			LEFT OUTER JOIN pWorkflowStatus ON	pStyleWorkflow.WorkStatus = pWorkflowStatus.WorkflowStatusID
			LEFT OUTER JOIN pWorkflow ON	pStyleWorkflow.WorkflowID = pWorkflow.WorkflowID
			LEFT JOIN Users ON	pStyleWorkflow.WorkAssignedTo = Users.UserID
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pStyleWorkflow.WorkStatus = 1
				OR pStyleWorkflow.WorkStatus = 6)
			AND	(pStyleWorkflow.WorkDue <= @DateTimeYesterday)

		--Get count of all outstanding samples.
		SELECT	@TotalCount = COUNT(*)
		FROM	#tempLateStyleDevelopmentWorkflows
		
		--Set row counter.
		SET	@RowCounter = 1
		
		--Loop to calculate late days.
		WHILE(@RowCounter <= @TotalCount)
			BEGIN
				--Get the year difference.
				SELECT	@YearDifference = CurrentYear - DueDateYear
				FROM	#tempLateStyleDevelopmentWorkflows
				WHERE	TableRow = @RowCounter
		
				--Begin calculating the days late based upon the differences of the years and days.
				IF(@YearDifference = 0)
					BEGIN
						UPDATE	#tempLateStyleDevelopmentWorkflows
						SET	DaysLate = CurrentDayNumber - DueDateDayNumber
						WHERE	TableRow = @RowCounter
					END
				ELSE IF(@YearDifference = 1)
					BEGIN
						UPDATE	#tempLateStyleDevelopmentWorkflows
						SET	DaysLate = (365 - DueDateDayNumber) + CurrentDayNumber
						WHERE	TableRow = @RowCounter
					END
				ELSE IF(@YearDifference > 1)
					BEGIN
						UPDATE	#tempLateStyleDevelopmentWorkflows
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
			Workflow,
			WorkflowStatus,
			DueDate,
			DaysLate
		FROM #tempLateStyleDevelopmentWorkflows
		ORDER BY
			AssignedTo,
			DaysLate DESC,
			StyleNo,
			SizeClass,
			SizeRange,
			Season,
			[Year],
			Workflow
	END

--Drop Temp tables.
DROP TABLE #tempLateStyleDevelopmentWorkflows

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09578', GetDate())
GO
