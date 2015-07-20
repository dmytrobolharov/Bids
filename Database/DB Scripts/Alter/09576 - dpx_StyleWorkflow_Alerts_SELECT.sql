IF OBJECT_ID(N'[dbo].[dpx_StyleWorkflow_Alerts_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[dpx_StyleWorkflow_Alerts_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_StyleWorkflow_Alerts_SELECT]
(
	@Flag int
)
AS

/****************************************************/
/*@Flag:											*/
/* 1 = Style development workflow alerts for today.	*/
/****************************************************/



--Global Variables.
DECLARE @DateTime datetime
DECLARE @ShortStringDate nvarchar(10)
DECLARE @StringDateBegin nvarchar(25)
DECLARE @StringDateEnd nvarchar(25)

--Create Temp tables.
CREATE TABLE #tempStyleDevelopmentWorkflows
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
	AlertDays int,
	AlertDate datetime
)

--Set the current date and time.
SET @DateTime = GETDATE()

--Set current date variable to a short date format.
SET @ShortStringDate = SUBSTRING(CONVERT(nvarchar(25), @DateTime, 120), 1, 10)

--Set two variables to the beginning and end of the current date.
SET @StringDateBegin = @ShortStringDate + ' 00:00:00.000'
SET @StringDateEnd = @ShortStringDate + ' 23:59:59.998'

--Choose the right output depending on the flag chosen.
IF(@Flag = 1)	--Style development workflows outstanding, by user with days late.
	BEGIN
		--Get all of the outstanding samples.
		INSERT INTO #tempStyleDevelopmentWorkflows(
			AssignedTo,
			StyleNo,
			SizeClass,
			SizeRange,
			Season,
			[Year],
			Workflow,
			WorkflowStatus,
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
			pWorkflow.Workflow,
			pWorkflowStatus.WorkflowStatus,
			pStyleWorkflow.WorkDue AS DueDate,
			pWorkflowTemplateItem.WorkflowAlerts AS AlertDays,
			DATEADD(day, -pWorkflowTemplateItem.WorkflowAlerts, pStyleWorkflow.WorkDue) AS AlertDate
		FROM	pStyleWorkflow
			INNER JOIN pStyleHeader sh ON pStyleWorkflow.StyleID = sh.StyleID
			INNER JOIN pWorkflowTemplateItem ON	(sh.StyleWorkflowID = pWorkflowTemplateItem.WorkflowTemplateID
												AND	pStyleWorkflow.WorkflowID = pWorkflowTemplateItem.WorkflowID)
			LEFT OUTER JOIN pWorkflowStatus ON	pStyleWorkflow.WorkStatus = pWorkflowStatus.WorkflowStatusID
			LEFT OUTER JOIN pWorkflow ON	pStyleWorkflow.WorkflowID = pWorkflow.WorkflowID
			LEFT JOIN Users ON	pStyleWorkflow.WorkAssignedTo = Users.UserID
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
			LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
		WHERE	(pStyleWorkflow.WorkStatus = 1
				OR pStyleWorkflow.WorkStatus = 6)

		--Show all of the style development workflows that have an alert date of today.
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
			AlertDays,
			AlertDate
		FROM #tempStyleDevelopmentWorkflows
		WHERE	(AlertDate >= @StringDateBegin
				AND	AlertDate <= @StringDateEnd)
		ORDER BY
			AssignedTo,
			StyleNo,
			SizeClass,
			SizeRange,
			Season,
			[Year],
			Workflow
	END

--Drop Temp tables.
DROP TABLE #tempStyleDevelopmentWorkflows

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09576', GetDate())
GO
