-- if drop...etc..
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflow_SELECT]'))
drop procedure spx_StyleWorkflow_SELECT
go


/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflow_SELECT]    Script Date: 05/01/2012 12:33:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[spx_StyleWorkflow_SELECT](@StyleID uniqueidentifier,
@StyleSet int)
AS 

DECLARE @StyleWorkflowID as uniqueidentifier  

SELECT @StyleWorkflowID = StyleWorkflowId  FROM pStyleHeader WITH (NOLOCK) where StyleID = @StyleID

IF @StyleWorkflowID IS NOT NULL 
BEGIN 
	SELECT b.Map, b.MapDetail, b.MapUrl,
		    	c.WorkflowStatus, c.WorkflowStatusImage, 
			a.StyleWorkflowID, a.StyleID, a.StyleSet, a.WorkflowID,  a.WorkflowType,  a.WorkflowOrder,  a.WorkDate, a.WorkStart, 
			a.WorkDue, a.WorkAssignedTo, a.WorkComplete, a.WorkStatus, a.WorkStatusDate, a.WorkStatusBy, a.WorkVersion, a.WorkComments, 
			a.CUser, a.CDate, a.MUser, a.MDate, a.WorkDay,
			d.StyleNo, a.WorkflowAccessTypeID, e.StartDate,
			CAST(a.WorkSort as int) WorkSort
	FROM dbo.pStyleWorkflow a WITH (NOLOCK) INNER JOIN dbo.Mapping  b WITH (NOLOCK) ON a.WorkflowID = b.Map INNER JOIN
	                      dbo.pWorkflowStatus  c WITH (NOLOCK) ON a.WorkStatus = c.WorkflowStatusID INNER JOIN
	                      dbo.pStyleHeader d WITH (NOLOCK) ON a.StyleID = d.StyleID
		         INNER JOIN dbo.pWorkflowTemplateItem e WITH (NOLOCK) ON  e.WorkflowID  = b.Map 
	WHERE a.StyleID = @StyleID  AND  a.StyleSet  =  @StyleSet 
	AND e.WorkflowTemplateID = @StyleWorkflowID
	ORDER BY WorkSort ,  e.WorkflowID
	
END 
ELSE 
BEGIN 
	SELECT     dbo.Mapping.Map, dbo.Mapping.MapDetail, dbo.pWorkflowStatus.WorkflowStatus, dbo.pWorkflowStatus.WorkflowStatusImage, 
	                      dbo.pStyleWorkflow.StyleWorkflowID, dbo.pStyleWorkflow.StyleID, dbo.pStyleWorkflow.StyleSet, dbo.pStyleWorkflow.WorkflowID, 
	                      dbo.pStyleWorkflow.WorkflowType, dbo.pStyleWorkflow.WorkflowOrder, dbo.pStyleWorkflow.WorkDate, dbo.pStyleWorkflow.WorkStart, 
	                      dbo.pStyleWorkflow.WorkDue, dbo.pStyleWorkflow.WorkAssignedTo, dbo.pStyleWorkflow.WorkComplete, dbo.pStyleWorkflow.WorkStatus, 
	                      dbo.pStyleWorkflow.WorkStatusDate, dbo.pStyleWorkflow.WorkStatusBy, dbo.pStyleWorkflow.WorkVersion, dbo.pStyleWorkflow.WorkComments, 
	                      dbo.pStyleWorkflow.WorkSort, dbo.pStyleWorkflow.CUser, dbo.pStyleWorkflow.CDate, dbo.pStyleWorkflow.MUser, dbo.pStyleWorkflow.MDate, 
	                      dbo.pStyleHeader.StyleNo, dbo.pStyleWorkflow.WorkDay , dbo.Mapping.MapUrl
	FROM         dbo.pStyleWorkflow WITH (NOLOCK) INNER JOIN
	                      dbo.Mapping WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkflowID = dbo.Mapping.Map INNER JOIN
	                      dbo.pWorkflowStatus WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkStatus = dbo.pWorkflowStatus.WorkflowStatusID INNER JOIN
	                      dbo.pStyleHeader WITH (NOLOCK) ON dbo.pStyleWorkflow.StyleID = dbo.pStyleHeader.StyleID
	WHERE     (dbo.pStyleWorkflow.StyleID = @StyleID) AND (dbo.pStyleWorkflow.StyleSet = @StyleSet)
	ORDER BY dbo.pStyleWorkflow.WorkSort ,  dbo.pStyleWorkflow.WorkflowID

END

go




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03447', GetDate())
	

GO

