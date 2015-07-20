/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowCalendarGroupTeam_INSERT]    Script Date: 06/05/2014 12:35:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowCalendarGroupTeam_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowCalendarGroupTeam_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowCalendarGroupTeam_INSERT]    Script Date: 06/05/2014 12:35:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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
		pStyleWorkflow.WorkDue, 'Style' AS CalendarType, pStyleWorkflow.WorkStatus, pStyleHeader.StyleNo + ' (' + pStyleHeader.SizeClass + ') ' + pStyleHeader.Description AS CalendarDescription
	FROM pStyleWorkflow WITH (NOLOCK) INNER JOIN
    Mapping WITH (NOLOCK) ON pStyleWorkflow.WorkflowID = Mapping.Map INNER JOIN
    pWorkflowStatus WITH (NOLOCK) ON pStyleWorkflow.WorkStatus = pWorkflowStatus.WorkflowStatusID INNER JOIN
    pStyleHeader WITH (NOLOCK) ON pStyleWorkflow.StyleID = pStyleHeader.StyleID
	WHERE (pStyleHeader.Active = 1) AND (pStyleWorkflow.WorkDue BETWEEN @StartDate AND @EndDate)
		 AND pStyleHeader.StyleType  IN  (SELECT StyleTypeID FROM sAccessStyleFolder WITH (NOLOCK) WHERE ( AccessRoleId =3 OR AccessView = 1 )  AND TeamId =  @TeamID )

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07927', GetDate())
GO