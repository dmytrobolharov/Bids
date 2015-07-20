IF OBJECT_ID(N'[dbo].[spx_StyleWorkflowCalendarTeamListTPBQ_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleWorkflowCalendarTeamListTPBQ_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleWorkflowCalendarTeamListTPBQ_INSERT]
(
@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime,
@StyleType int ,
@TeamID uniqueidentifier 
)
AS

/*Holiday's INSERT SELECT Statement.*/
INSERT INTO pStyleCalendarTemp
		(CalendarID, PKeyID, CalendarLinkID, CalendarLinkSubID, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
SELECT	@CalendarID AS CalendarID, '00000000-0000-0000-0000-000000000000' AS PKeyID, '00000000-0000-0000-0000-000000000000' AS CalendarLinkID, 
	'00000000-0000-0000-0000-000000000000' AS CalendarLinkSubID, CalendarEventDate AS CalendarDate, 'HolidayTPBQ' AS CalendarType, 0 AS CalendarStatus,
	CalendarEventCountry +  ' - ' + CalendarEventName as CalendarDescription
FROM	cCalendarEvent WITH (NOLOCK)


INSERT INTO dbo.pStyleCalendarTemp
                      (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
SELECT @CalendarId AS CalendarId, dbo.pStyleWorkflow.StyleID, dbo.pStyleWorkflow.WorkflowID, dbo.Mapping.MapDetail, dbo.pStyleWorkflow.WorkDue, 
       'StyleTPBQ' AS CalendarType, dbo.pStyleWorkflow.WorkStatus, 
       sh.StyleNo + ' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription
FROM dbo.pStyleWorkflow WITH (NOLOCK) 
INNER JOIN dbo.Mapping WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkflowID = dbo.Mapping.Map 
INNER JOIN dbo.pWorkflowStatus WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkStatus = dbo.pWorkflowStatus.WorkflowStatusID 
INNER JOIN dbo.pStyleHeader sh WITH (NOLOCK) ON dbo.pStyleWorkflow.StyleID = sh.StyleID 
INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 2) access ON access.ProductTypeId = sh.StyleType
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
WHERE (sh.Active = 1) AND (dbo.pStyleWorkflow.WorkDue BETWEEN @StartDate AND @EndDate) 
		AND (access.PermissionRoleId = 3 OR access.PermissionView = 1)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09844', GetDate())
GO
