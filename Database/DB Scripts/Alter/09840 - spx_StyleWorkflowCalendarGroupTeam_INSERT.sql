IF OBJECT_ID(N'[dbo].[spx_StyleWorkflowCalendarGroupTeam_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleWorkflowCalendarGroupTeam_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleWorkflowCalendarGroupTeam_INSERT] (
@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime, 
@TeamID uniqueidentifier 
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
    pStyleHeader sh WITH (NOLOCK) ON pStyleWorkflow.StyleID = sh.StyleID INNER JOIN
    fnx_Permissions_GetIntProductTypePermissions(@TeamID, 2) access ON access.ProductTypeId = sh.StyleType
	LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	WHERE (sh.Active = 1) AND (pStyleWorkflow.WorkDue BETWEEN @StartDate AND @EndDate)
		 AND (access.PermissionRoleId <> 0)



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09840', GetDate())
GO
