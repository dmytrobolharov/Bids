IF OBJECT_ID(N'[dbo].[spx_StyleWorkflowCalendarTeamList_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleWorkflowCalendarTeamList_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleWorkflowCalendarTeamList_INSERT] (@CalendarId NVARCHAR(50), @StartDate DATETIME, @EndDate DATETIME, @StyleType INT, @TeamID UNIQUEIDENTIFIER)
AS

/*Holiday's INSERT SELECT Statement.*/
INSERT INTO pStyleCalendarTemp (CalendarID, PKeyID, CalendarLinkID, CalendarLinkSubID, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
SELECT @CalendarID AS CalendarID, '00000000-0000-0000-0000-000000000000' AS PKeyID, '00000000-0000-0000-0000-000000000000' AS CalendarLinkID, '00000000-0000-0000-0000-000000000000' AS CalendarLinkSubID, CalendarEventDate AS CalendarDate, 'Holiday' AS CalendarType, 0 AS CalendarStatus, CalendarEventCountry + ' - ' + CalendarEventName AS CalendarDescription
FROM cCalendarEvent

INSERT INTO dbo.pStyleCalendarTemp (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, SeasonYearID)
SELECT @CalendarId AS CalendarId, LOWER(dbo.pStyleWorkflow.StyleID), dbo.pStyleWorkflow.WorkflowID, 
       dbo.Mapping.MapDetail + ISNULL(' (' + dbo.vwx_SeasonYear_SEL.SeasonYear + ')', ''), dbo.pStyleWorkflow.WorkDue, 
	   'Style' AS CalendarType, dbo.pStyleWorkflow.WorkStatus, sh.StyleNo + ' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 
	   dbo.pStyleSeasonYear.SeasonYearID
FROM dbo.pStyleWorkflow
INNER JOIN dbo.Mapping ON dbo.pStyleWorkflow.WorkflowID = dbo.Mapping.Map
INNER JOIN dbo.pWorkflowStatus ON dbo.pStyleWorkflow.WorkStatus = dbo.pWorkflowStatus.WorkflowStatusID
INNER JOIN dbo.pStyleHeader sh ON dbo.pStyleWorkflow.StyleID = sh.StyleID
LEFT JOIN dbo.pStyleSeasonYear ON dbo.pStyleWorkflow.StyleSeasonYearID = dbo.pStyleSeasonYear.StyleSeasonYearID
LEFT JOIN dbo.vwx_SeasonYear_SEL ON dbo.pStyleSeasonYear.SeasonYearID = dbo.vwx_SeasonYear_SEL.SeasonYearID INNER JOIN
fnx_Permissions_GetIntProductTypePermissions(@TeamID, 2) access ON access.ProductTypeId = sh.StyleType
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
WHERE (sh.Active = 1) AND (dbo.pStyleWorkflow.WorkDue BETWEEN @StartDate AND @EndDate)
	AND (access.PermissionRoleId <> 0)


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09843', GetDate())
GO
