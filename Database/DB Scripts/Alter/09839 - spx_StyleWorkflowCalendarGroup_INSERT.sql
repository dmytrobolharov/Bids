IF OBJECT_ID(N'[dbo].[spx_StyleWorkflowCalendarGroup_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleWorkflowCalendarGroup_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleWorkflowCalendarGroup_INSERT] (
@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime
)
AS 

	INSERT INTO pStyleCalendarTemp
		(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
	SELECT  @CalendarId AS CalendarId, pStyleWorkflow.StyleID, pStyleWorkflow.WorkflowID, Mapping.MapDetail, 
		pStyleWorkflow.WorkDue, 'Style' AS CalendarType, pStyleWorkflow.WorkStatus, 
		sh.StyleNo + ' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription
	FROM pStyleWorkflow WITH (NOLOCK) INNER JOIN
    Mapping WITH (NOLOCK) ON pStyleWorkflow.WorkflowID = Mapping.Map INNER JOIN
    pWorkflowStatus WITH (NOLOCK) ON pStyleWorkflow.WorkStatus = pWorkflowStatus.WorkflowStatusID INNER JOIN
    pStyleHeader sh WITH (NOLOCK) ON pStyleWorkflow.StyleID = sh.StyleID
	LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	WHERE (sh.Active = 1) AND (pStyleWorkflow.WorkDue BETWEEN @StartDate AND @EndDate)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09839', GetDate())
GO
