IF OBJECT_ID(N'[dbo].[spx_StyleWorkflowCalendarListTPBQ_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleWorkflowCalendarListTPBQ_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleWorkflowCalendarListTPBQ_INSERT]
(@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime,
@StyleType int)
AS INSERT INTO dbo.pStyleCalendarTemp
                      (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
SELECT @CalendarId AS CalendarId, dbo.pStyleWorkflow.StyleID, dbo.pStyleWorkflow.WorkflowID, dbo.Mapping.MapDetail, dbo.pStyleWorkflow.WorkDue, 
       'StyleTPBQ' AS CalendarType, dbo.pStyleWorkflow.WorkStatus, 
       sh.StyleNo + ' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription
FROM dbo.pStyleWorkflow WITH (NOLOCK) 
INNER JOIN dbo.Mapping WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkflowID = dbo.Mapping.Map 
INNER JOIN dbo.pWorkflowStatus WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkStatus = dbo.pWorkflowStatus.WorkflowStatusID 
INNER JOIN dbo.pStyleHeader sh WITH (NOLOCK) ON dbo.pStyleWorkflow.StyleID = sh.StyleID
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
WHERE (sh.Active = 1) AND (dbo.pStyleWorkflow.WorkDue BETWEEN @StartDate AND @EndDate) AND (sh.StyleType = @StyleType)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09842', GetDate())
GO
