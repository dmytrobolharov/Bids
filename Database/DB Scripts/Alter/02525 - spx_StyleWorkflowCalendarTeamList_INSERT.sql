

/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowCalendarTeamList_INSERT]    Script Date: 12/29/2011 19:27:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowCalendarTeamList_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowCalendarTeamList_INSERT]
GO

CREATE   PROCEDURE [dbo].[spx_StyleWorkflowCalendarTeamList_INSERT](@CalendarId varchar(50),
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
	'00000000-0000-0000-0000-000000000000' AS CalendarLinkSubID, CalendarEventDate AS CalendarDate, 'Holiday' AS CalendarType, 0 AS CalendarStatus,
	CalendarEventCountry +  ' - ' + CalendarEventName as CalendarDescription
FROM	cCalendarEvent WITH (NOLOCK)


INSERT INTO dbo.pStyleCalendarTemp
                      (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
SELECT     @CalendarId AS CalendarId, LOWER(dbo.pStyleWorkflow.StyleID), dbo.pStyleWorkflow.WorkflowID, dbo.Mapping.MapDetail, dbo.pStyleWorkflow.WorkDue, 
                      'Style' AS CalendarType, dbo.pStyleWorkflow.WorkStatus, 
                      dbo.pStyleHeader.StyleNo + ' (' + dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription
FROM         dbo.pStyleWorkflow WITH (NOLOCK) INNER JOIN
                      dbo.Mapping WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkflowID = dbo.Mapping.Map INNER JOIN
                      dbo.pWorkflowStatus WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkStatus = dbo.pWorkflowStatus.WorkflowStatusID INNER JOIN
                      dbo.pStyleHeader WITH (NOLOCK) ON dbo.pStyleWorkflow.StyleID = dbo.pStyleHeader.StyleID
WHERE     (dbo.pStyleHeader.Active = 1) AND (dbo.pStyleWorkflow.WorkDue BETWEEN @StartDate AND @EndDate) 
		AND ( pStyleHeader.StyleType  IN  (SELECT StyleTypeID FROM sAccessStyleFolder WITH (NOLOCK) WHERE ( AccessRoleId =3 OR AccessView = 1 )  AND TeamId = @TeamID  )  )




/*
		AND (dbo.pStyleHeader.StyleType = @StyleType)
		AND ( pStyleHeader.StyleType  IN  (SELECT StyleTypeID FROM sAccessStyleFolder WITH (NOLOCK) WHERE ( AccessRoleId =3 OR AccessView = 1 )  AND TeamId = @TeamID  )  )
*/

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02525'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02525', GetDate())
END
GO