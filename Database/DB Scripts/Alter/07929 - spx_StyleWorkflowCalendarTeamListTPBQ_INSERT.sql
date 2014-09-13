/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowCalendarTeamListTPBQ_INSERT]    Script Date: 06/05/2014 12:59:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowCalendarTeamListTPBQ_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowCalendarTeamListTPBQ_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowCalendarTeamListTPBQ_INSERT]    Script Date: 06/05/2014 12:59:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE   PROCEDURE [dbo].[spx_StyleWorkflowCalendarTeamListTPBQ_INSERT]
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
SELECT     @CalendarId AS CalendarId, dbo.pStyleWorkflow.StyleID, dbo.pStyleWorkflow.WorkflowID, dbo.Mapping.MapDetail, dbo.pStyleWorkflow.WorkDue, 
                      'StyleTPBQ' AS CalendarType, dbo.pStyleWorkflow.WorkStatus, 
                      dbo.pStyleHeader.StyleNo + ' (' + dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription
FROM         dbo.pStyleWorkflow WITH (NOLOCK) INNER JOIN
                      dbo.Mapping WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkflowID = dbo.Mapping.Map INNER JOIN
                      dbo.pWorkflowStatus WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkStatus = dbo.pWorkflowStatus.WorkflowStatusID INNER JOIN
                      dbo.pStyleHeader WITH (NOLOCK) ON dbo.pStyleWorkflow.StyleID = dbo.pStyleHeader.StyleID INNER JOIN
                      fnx_Permissions_GetIntProductTypePermissions(@TeamID, 2) access ON access.ProductTypeId = pStyleHeader.StyleType
WHERE     (dbo.pStyleHeader.Active = 1) AND (dbo.pStyleWorkflow.WorkDue BETWEEN @StartDate AND @EndDate) 
		AND (access.PermissionRoleId = 3 OR access.PermissionView = 1)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07929', GetDate())
GO