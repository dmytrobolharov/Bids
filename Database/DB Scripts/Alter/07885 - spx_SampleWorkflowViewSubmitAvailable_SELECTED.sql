/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowViewSubmitAvailable_SELECTED]    Script Date: 06/04/2014 12:54:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowViewSubmitAvailable_SELECTED]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowViewSubmitAvailable_SELECTED]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowViewSubmitAvailable_SELECTED]    Script Date: 06/04/2014 12:54:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleWorkflowViewSubmitAvailable_SELECTED]
(@TeamId uniqueidentifier)
AS 

	SELECT SampleWorkflowID, SampleWorkflow, WorkflowID, GroupID, GroupName, Active  
	FROM  pSampleWorkflow WITH (NOLOCK)   
	WHERE 
	(
	SampleWorkflowID IN   
		(
			SELECT SampleWorkflowId FROM  pSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId = @TeamId  
		)
	)  
	AND  pSampleWorkflow.Active='Yes'
	ORDER BY SampleWorkflowID  


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07885', GetDate())
GO