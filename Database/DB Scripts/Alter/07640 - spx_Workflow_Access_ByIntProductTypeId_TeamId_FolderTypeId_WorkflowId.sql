/****** Object:  StoredProcedure [dbo].[spx_Workflow_Access_ByIntProductTypeId_TeamId_FolderTypeId_WorkflowId]    Script Date: 05/16/2014 18:14:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Workflow_Access_ByIntProductTypeId_TeamId_FolderTypeId_WorkflowId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Workflow_Access_ByIntProductTypeId_TeamId_FolderTypeId_WorkflowId]
GO

/****** Object:  StoredProcedure [dbo].[spx_Workflow_Access_ByIntProductTypeId_TeamId_FolderTypeId_WorkflowId]    Script Date: 05/16/2014 18:14:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_Workflow_Access_ByIntProductTypeId_TeamId_FolderTypeId_WorkflowId]
	@ProductTypeID INT,
	@TeamID UNIQUEIDENTIFIER,
	@FolderTypeID INT,
	@WorkflowID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * FROM fnx_Permissions_GetIntProductType_WorkflowPermissions(@TeamID, @FolderTypeID, @ProductTypeID)
    WHERE WorkflowId = @WorkflowID
    
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07640', GetDate())
GO
