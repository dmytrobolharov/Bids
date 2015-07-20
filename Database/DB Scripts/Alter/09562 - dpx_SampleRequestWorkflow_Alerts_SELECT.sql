IF OBJECT_ID(N'[dbo].[dpx_SampleRequestWorkflow_Alerts_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[dpx_SampleRequestWorkflow_Alerts_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_SampleRequestWorkflow_Alerts_SELECT]
(
	@Flag int
)
AS

/********************************************/
/*@Flag:									*/
/* 1 = Sample workflows alerts for today.	*/
/********************************************/


--Global Variables.
DECLARE @DateTime datetime
DECLARE @ShortStringDate nvarchar(10)
DECLARE @StringDateBegin nvarchar(25)
DECLARE @StringDateEnd nvarchar(25)

--Create Temp tables.
CREATE TABLE #tempSamples
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
	AlertDays int,
	AlertDate datetime
)

--Set the current date and time.
SET @DateTime = GETDATE()

--Set current date variable to a short date format.
SET @ShortStringDate = SUBSTRING(CONVERT(nvarchar(25), @DateTime, 120), 1, 10)

--Set two variables to the beginning and end of the current date.
SET @StringDateBegin = @ShortStringDate + ' 00:00:00.000'

SET @ShortStringDate = SUBSTRING(CONVERT(nvarchar(25), @DateTime, 120), 1, 10)
SET @StringDateEnd = @ShortStringDate + ' 23:59:59.998' 

--Choose the right output depending on the flag chosen.
IF(@Flag = 1)	--Sample workflows alerts for today.
	BEGIN
		--Get all of the samples.
		INSERT INTO #tempSamples(
			AssignedTo,
			StyleNo,
			SizeClass,
			SizeRange,
			Season,
			[Year],
			GroupName,
			Status,
			DueDate,
			AlertDays,
			AlertDate)
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
			pSampleWorkflowItemTemplate.SampleWorkflowAlerts AS AlertDays,
			DATEADD(day, -pSampleWorkflowItemTemplate.SampleWorkflowAlerts, pSampleRequestWorkflow.DueDate) AS AlertDate
		FROM pSampleRequestWorkflow
			INNER JOIN pStyleHeader sh ON pSampleRequestWorkflow.StyleID = sh.StyleID
			LEFT OUTER JOIN pSampleRequestSubmitStatus ON	pSampleRequestWorkflow.Status = pSampleRequestSubmitStatus.StatusID
			LEFT OUTER JOIN pSampleWorkflow ON	pSampleRequestWorkflow.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
			LEFT OUTER JOIN Users ON	pSampleRequestWorkflow.AssignedTo = Users.UserID
			LEFT OUTER JOIN pSampleWorkflowItemTemplate ON pSampleRequestWorkflow.SampleWorkflowTempItemID = pSampleWorkflowItemTemplate.SampleWorkflowTempItemID
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pSampleRequestWorkflow.Status = 0)

		--Show all of the samples that have an alert date of today.
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
			AlertDays,
			AlertDate
		FROM #tempSamples
		WHERE	(AlertDate >= @StringDateBegin
				AND	AlertDate <= @StringDateEnd)
		ORDER BY
			AssignedTo,
			StyleNo,
			SizeClass,
			SizeRange,
			Season,
			[Year],
			GroupName
	END

--Drop Temp tables.
DROP TABLE #tempSamples

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09562', GetDate())
GO
