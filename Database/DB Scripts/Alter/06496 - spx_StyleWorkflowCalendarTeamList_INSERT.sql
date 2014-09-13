IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowCalendarTeamList_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowCalendarTeamList_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleWorkflowCalendarTeamList_INSERT] (
	@CalendarId NVARCHAR(50)
	, @StartDate DATETIME
	, @EndDate DATETIME
	, @StyleType INT
	, @TeamID UNIQUEIDENTIFIER
	)
AS


/*Holiday's INSERT SELECT Statement.*/
INSERT INTO pStyleCalendarTemp (CalendarID, PKeyID, CalendarLinkID, CalendarLinkSubID, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
SELECT @CalendarID AS CalendarID, '00000000-0000-0000-0000-000000000000' AS PKeyID, '00000000-0000-0000-0000-000000000000' AS CalendarLinkID, '00000000-0000-0000-0000-000000000000' AS CalendarLinkSubID, CalendarEventDate AS CalendarDate, 'Holiday' AS CalendarType, 0 AS CalendarStatus, CalendarEventCountry + ' - ' + CalendarEventName AS CalendarDescription
FROM cCalendarEvent

INSERT INTO dbo.pStyleCalendarTemp (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription, SeasonYearID)
SELECT @CalendarId AS CalendarId, LOWER(dbo.pStyleWorkflow.StyleID), dbo.pStyleWorkflow.WorkflowID, dbo.Mapping.MapDetail + ISNULL(' (' + dbo.vwx_SeasonYear_SEL.SeasonYear + ')', ''), dbo.pStyleWorkflow.WorkDue, 'Style' AS CalendarType, dbo.pStyleWorkflow.WorkStatus, dbo.pStyleHeader.StyleNo + ' (' + dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription, dbo.pStyleSeasonYear.SeasonYearID
FROM dbo.pStyleWorkflowpPlanningFlashEditQuickFill
INNER JOIN dbo.MappingpPlanningFlashEditQuickFill ON dbo.pStyleWorkflow.WorkflowID = dbo.Mapping.Map
INNER JOIN dbo.pWorkflowStatuspPlanningFlashEditQuickFill ON dbo.pStyleWorkflow.WorkStatus = dbo.pWorkflowStatus.WorkflowStatusID
INNER JOIN dbo.pStyleHeaderpPlanningFlashEditQuickFill ON dbo.pStyleWorkflow.StyleID = dbo.pStyleHeader.StyleID
LEFT JOIN dbo.pStyleSeasonYear ON dbo.pStyleWorkflow.StyleSeasonYearID = dbo.pStyleSeasonYear.StyleSeasonYearID
LEFT JOIN dbo.vwx_SeasonYear_SEL ON dbo.pStyleSeasonYear.SeasonYearID = dbo.vwx_SeasonYear_SEL.SeasonYearID
WHERE (dbo.pStyleHeader.Active = 1) AND (dbo.pStyleWorkflow.WorkDue BETWEEN @StartDate AND @EndDate) AND (pStyleHeader.StyleType IN (SELECT StyleTypeID FROM sAccessStyleFolderpPlanningFlashEditQuickFill	WHERE (AccessRoleId = 3 OR AccessView = 1) AND TeamId = @TeamID	))

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06496', GetDate())
GO
