IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkflowTemplateItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkflowTemplateItem_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_WorkflowTemplateItem_INSERT]    Script Date: 12/15/2011 17:15:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_WorkflowTemplateItem_INSERT]

(@WorkflowTemplateID uniqueidentifier,
@WorkflowID uniqueidentifier,
@WorkflowSort nvarchar(2))

AS

IF (SELECT  COUNT(WorkFlowSort)  FROM  dbo.pWorkflowTemplateItem WITH (NOLOCK) WHERE WorkflowTemplateID = @WorkflowTemplateID AND WorkflowID = @WorkflowID) = 0 

	BEGIN

   	 INSERT  INTO dbo.pWorkflowTemplateItem(WorkflowTemplateID, WorkflowID, WorkflowSort, WorkflowAlerts, WorkflowDays, WorkflowAssignedTo)
	VALUES  (@WorkflowTemplateID, @WorkflowID, @WorkflowSort, 0, 1, 0) 

	END

ELSE

	BEGIN

	UPDATE dbo.pWorkflowTemplateItem SET WorkflowSort = @WorkflowSort WHERE WorkflowTemplateID = @WorkflowTemplateID AND WorkflowID = @WorkflowID 

	END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02314'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02314', GetDate())
END	
GO 
