IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleWorkflowCalendarItems]'))
DROP VIEW [dbo].[vwx_StyleWorkflowCalendarItems]
GO

CREATE VIEW [dbo].[vwx_StyleWorkflowCalendarItems]
AS
SELECT     b.Map, b.MapDetail, b.MapUrl, c.WorkflowStatus, c.WorkflowStatusImage, a.StyleWorkflowID, a.StyleID, a.StyleSet, a.WorkflowID, a.WorkflowType, a.WorkflowOrder, 
                      a.WorkDate, a.WorkStart, a.WorkDue, ISNULL(a.WorkAssignedTo, 0) AS WorkAssignedTo, a.WorkComplete, a.WorkStatus, a.WorkStatusDate, a.WorkStatusBy, 
                      a.WorkVersion, a.WorkComments, a.WorkSort, a.CUser, a.CDate, a.MUser, a.MDate, a.WorkDay, d.StyleNo, e.WorkflowSort, e.WorkflowTemplateID, b.IsSeasonal, 
                      ssy.SeasonYearID, dbo.pStyleWorkflow.WorkAssignedTo AS Expr1, dbo.pStyleWorkflow.ActualStart, dbo.pStyleWorkflow.ActualEnd
FROM         dbo.pStyleWorkflow AS a WITH (NOLOCK) INNER JOIN
                      dbo.Mapping AS b WITH (NOLOCK) ON a.WorkflowID = b.Map INNER JOIN
                      dbo.pWorkflowStatus AS c WITH (NOLOCK) ON a.WorkStatus = c.WorkflowStatusID INNER JOIN
                      dbo.pStyleHeader AS d WITH (NOLOCK) ON a.StyleID = d.StyleID INNER JOIN
                      dbo.pWorkflowTemplateItem AS e WITH (NOLOCK) ON e.WorkflowID = b.Map INNER JOIN
                      dbo.pStyleWorkflow ON a.StyleWorkflowID = dbo.pStyleWorkflow.StyleWorkflowID LEFT OUTER JOIN
                      dbo.pStyleSeasonYear AS ssy WITH (NOLOCK) ON a.StyleSeasonYearID = ssy.StyleSeasonYearID
WHERE     (NOT (a.StyleSeasonYearID IS NOT NULL)) OR
                      (NOT (ssy.StyleSeasonYearID IS NULL))


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08487', GetDate())
GO





