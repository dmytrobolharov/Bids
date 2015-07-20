/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowCalendarTeamList_INSERT]    Script Date: 06/05/2014 15:32:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowCalendarTeamList_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowCalendarTeamList_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowCalendarTeamList_INSERT]    Script Date: 06/05/2014 15:32:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_StyleWorkflowCalendarTeamList_INSERT] (@CalendarId NVARCHAR(50), @StartDate DATETIME, @EndDate DATETIME, @StyleType INT, @TeamID UNIQUEIDENTIFIER)
AS

/*Holiday's INSERT SELECT Statement.*/
INSERT INTO pStyleCalendarTemp (CalendarID, PKeyID, CalendarLinkID, CalendarLinkSubID, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
SELECT @CalendarID AS CalendarID, '00000000-0000-0000-0000-000000000000' AS PKeyID, '00000000-0000-0000-0000-000000000000' AS CalendarLinkID, '00000000-0000-0000-0000-000000000000' AS CalendarLinkSubID, CalendarEventDate AS CalendarDate, 'Holiday' AS CalendarType, 0 AS CalendarStatus, CalendarEventCountry + ' - ' + CalendarEventName AS CalendarDescription
FROM cCalendarEvent

INSERT INTO dbo.pStyleCalendarTemp (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, SeasonYearID)
SELECT @CalendarId AS CalendarId, LOWER(dbo.pStyleWorkflow.StyleID), dbo.pStyleWorkflow.WorkflowID, dbo.Mapping.MapDetail + ISNULL(' (' + dbo.vwx_SeasonYear_SEL.SeasonYear + ')', ''), dbo.pStyleWorkflow.WorkDue, 'Style' AS CalendarType, dbo.pStyleWorkflow.WorkStatus, dbo.pStyleHeader.StyleNo + ' (' + dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, dbo.pStyleSeasonYear.SeasonYearID
FROM dbo.pStyleWorkflow
INNER JOIN dbo.Mapping ON dbo.pStyleWorkflow.WorkflowID = dbo.Mapping.Map
INNER JOIN dbo.pWorkflowStatus ON dbo.pStyleWorkflow.WorkStatus = dbo.pWorkflowStatus.WorkflowStatusID
INNER JOIN dbo.pStyleHeader ON dbo.pStyleWorkflow.StyleID = dbo.pStyleHeader.StyleID
LEFT JOIN dbo.pStyleSeasonYear ON dbo.pStyleWorkflow.StyleSeasonYearID = dbo.pStyleSeasonYear.StyleSeasonYearID
LEFT JOIN dbo.vwx_SeasonYear_SEL ON dbo.pStyleSeasonYear.SeasonYearID = dbo.vwx_SeasonYear_SEL.SeasonYearID INNER JOIN
fnx_Permissions_GetIntProductTypePermissions(@TeamID, 2) access ON access.ProductTypeId = pStyleHeader.StyleType
WHERE (dbo.pStyleHeader.Active = 1) AND (dbo.pStyleWorkflow.WorkDue BETWEEN @StartDate AND @EndDate)
	AND (access.PermissionRoleId <> 0)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07928', GetDate())
GO