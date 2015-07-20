/****** Object:  StoredProcedure [dbo].[spx_Workflow_Access_ByStringProductTypeId_TeamId_FolderTypeId]    Script Date: 05/27/2014 14:12:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Workflow_Access_ByStringProductTypeId_TeamId_FolderTypeId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Workflow_Access_ByStringProductTypeId_TeamId_FolderTypeId]
GO

/****** Object:  StoredProcedure [dbo].[spx_Workflow_Access_ByStringProductTypeId_TeamId_FolderTypeId]    Script Date: 05/27/2014 14:12:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_Workflow_Access_ByStringProductTypeId_TeamId_FolderTypeId]
	@ProductTypeID NVARCHAR(200),
	@TeamID uniqueidentifier,
	@FolderID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT * FROM fnx_Permissions_GetStringProductTypePermissions(@TeamID, @FolderID) perms
	WHERE perms.ProductTypeID = @ProductTypeID
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07761', GetDate())
GO
