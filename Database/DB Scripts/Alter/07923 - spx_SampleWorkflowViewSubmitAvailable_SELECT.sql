/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowViewSubmitAvailable_SELECT]    Script Date: 06/05/2014 11:07:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowViewSubmitAvailable_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowViewSubmitAvailable_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowViewSubmitAvailable_SELECT]    Script Date: 06/05/2014 11:07:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleWorkflowViewSubmitAvailable_SELECT]  
(@TeamId uniqueidentifier)  
AS   
  
	SELECT SampleWorkflowID, SampleWorkflow, WorkflowID, GroupID, GroupName, Active  
	FROM  pSampleWorkflow WITH (NOLOCK)   
	WHERE 
	(
	SampleWorkflowID NOT IN   
	(
		SELECT SampleWorkflowId FROM  pSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId  
	)
	)  
	ORDER BY SampleWorkflowID  


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07923', GetDate())
GO