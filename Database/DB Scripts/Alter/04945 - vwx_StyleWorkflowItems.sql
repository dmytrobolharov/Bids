
/****** Object:  View [dbo].[vwx_StyleWorkflowItems]    Script Date: 01/31/2013 00:51:05 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleWorkflowItems]'))
DROP VIEW [dbo].[vwx_StyleWorkflowItems]
GO


/****** Object:  View [dbo].[vwx_StyleWorkflowItems]    Script Date: 01/31/2013 00:51:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



create VIEW [dbo].[vwx_StyleWorkflowItems]
AS
SELECT     b.Map, b.MapDetail, b.MapUrl, c.WorkflowStatus, c.WorkflowStatusImage, a.StyleWorkflowID, a.StyleID, a.StyleSet, a.WorkflowID, a.WorkflowType, 
                      a.WorkflowOrder, a.WorkDate, a.WorkStart, a.WorkDue, ISNULL(a.WorkAssignedTo, 0) AS WorkAssignedTo, a.WorkComplete, a.WorkStatus, 
                      a.WorkStatusDate, a.WorkStatusBy, a.WorkVersion, a.WorkComments, a.WorkSort, a.CUser, a.CDate, a.MUser, a.MDate, a.WorkDay, d.StyleNo, 
                      e.WorkflowSort, e.WorkflowTemplateID
FROM         dbo.pStyleWorkflow AS a WITH (NOLOCK) INNER JOIN
                      dbo.Mapping AS b WITH (NOLOCK) ON a.WorkflowID = b.Map INNER JOIN
                      dbo.pWorkflowStatus AS c WITH (NOLOCK) ON a.WorkStatus = c.WorkflowStatusID INNER JOIN
                      dbo.pStyleHeader AS d WITH (NOLOCK) ON a.StyleID = d.StyleID INNER JOIN
                      dbo.pWorkflowTemplateItem AS e WITH (NOLOCK) ON e.WorkflowID = b.Map



GO






INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04945', GetDate())
GO