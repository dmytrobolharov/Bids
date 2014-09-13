/****** Object:  StoredProcedure [dbo].[spx_Workflow_Access_ByIntProductTypeId_TeamId_FolderTypeId]    Script Date: 05/16/2014 18:20:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Workflow_Access_ByIntProductTypeId_TeamId_FolderTypeId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Workflow_Access_ByIntProductTypeId_TeamId_FolderTypeId]
GO

/****** Object:  StoredProcedure [dbo].[spx_Workflow_Access_ByIntProductTypeId_TeamId_FolderTypeId]    Script Date: 05/16/2014 18:20:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_Workflow_Access_ByIntProductTypeId_TeamId_FolderTypeId]
	@ProductTypeID int,
	@TeamID uniqueidentifier,
	@FolderID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM fnx_Permissions_GetIntProductTypePermissions(@TeamID, @FolderID) perms
	WHERE perms.ProductTypeID = @ProductTypeID
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07642', GetDate())
GO
