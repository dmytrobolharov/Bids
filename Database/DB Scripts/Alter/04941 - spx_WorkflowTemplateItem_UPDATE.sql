
/****** Object:  StoredProcedure [dbo].[spx_WorkflowTemplateItem_UPDATE]    Script Date: 01/31/2013 00:43:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkflowTemplateItem_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkflowTemplateItem_UPDATE]
GO


/****** Object:  StoredProcedure [dbo].[spx_WorkflowTemplateItem_UPDATE]    Script Date: 01/31/2013 00:43:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_WorkflowTemplateItem_UPDATE](@WorkflowTemplateItemID uniqueidentifier,
@WorkflowAssignedTo nvarchar(50),
@WorkflowDays nvarchar(50),
@WorkflowAlerts nvarchar(50),
@CreatedBy nvarchar(50),
@WorkflowSort nvarchar(50),
@CreatedDate nvarchar(50))
AS UPDATE    dbo.pWorkflowTemplateItem
SET              WorkflowAssignedTo = @WorkflowAssignedTo, WorkflowDays = @WorkflowDays, WorkflowAlerts = @WorkflowAlerts, CUser = @CreatedBy, 
                      CDate = @CreatedDate, MUser = @CreatedBy, MDate = @CreatedDate, WorkflowSort = @WorkflowSort
WHERE     (WorkflowTemplateItemID = @WorkflowTemplateItemID)


GO





INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04941', GetDate())
GO