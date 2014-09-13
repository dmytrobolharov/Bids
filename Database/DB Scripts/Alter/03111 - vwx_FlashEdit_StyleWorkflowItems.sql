SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_FlashEdit_StyleWorkflowItems]'))
DROP VIEW [dbo].[vwx_FlashEdit_StyleWorkflowItems]
GO


/*
The below statement will create a new view that is used in the Flash edit style work flow schema
*/
CREATE VIEW [dbo].[vwx_FlashEdit_StyleWorkflowItems]
AS
SELECT     b.Map, b.MapDetail, b.MapUrl, c.WorkflowStatus,c.WorkflowStatusImage, a.StyleWorkflowID, a.StyleID, a.StyleSet, a.WorkflowID, a.WorkflowType, a.WorkflowOrder, 
                      a.WorkDate, a.WorkStart, a.WorkDue, ISNULL(a.WorkAssignedTo, 0) AS WorkAssignedTo, a.WorkComplete, a.WorkStatus, a.WorkStatusDate, a.WorkStatusBy, 
                      a.WorkVersion, a.WorkComments, a.WorkSort, a.CUser, a.CDate, a.MUser, a.MDate, a.WorkDay, d.StyleNo, d.StyleType, e.StyleTypeDescription, f.StyleSeason, f.StyleYear
FROM         dbo.pStyleWorkflow AS a WITH (NOLOCK) INNER JOIN
                      dbo.Mapping AS b WITH (NOLOCK) ON a.WorkflowID = b.Map INNER JOIN
                      dbo.pWorkflowStatus AS c WITH (NOLOCK) ON a.WorkStatus = c.WorkflowStatusID INNER JOIN
                      dbo.pStyleHeader AS d WITH (NOLOCK) ON a.StyleID = d.StyleID INNER JOIN
                      dbo.pStyleType AS e WITH (NOLOCK) ON d.StyleType = e.StyleTypeID INNER JOIN
                      dbo.pStyleSeasonYear AS f WITH (NOLOCK) ON d.StyleID = f.StyleID
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03111'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03111', GetDate())

END
GO