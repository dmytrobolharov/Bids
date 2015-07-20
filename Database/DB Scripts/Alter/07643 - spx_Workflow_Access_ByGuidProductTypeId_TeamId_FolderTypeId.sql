/****** Object:  StoredProcedure [dbo].[spx_Workflow_Access_ByGuidProductTypeId_TeamId_FolderTypeId]    Script Date: 05/16/2014 18:20:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Workflow_Access_ByGuidProductTypeId_TeamId_FolderTypeId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Workflow_Access_ByGuidProductTypeId_TeamId_FolderTypeId]
GO

/****** Object:  StoredProcedure [dbo].[spx_Workflow_Access_ByGuidProductTypeId_TeamId_FolderTypeId]    Script Date: 05/16/2014 18:20:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_Workflow_Access_ByGuidProductTypeId_TeamId_FolderTypeId]
	@ProductTypeID uniqueidentifier,
	@TeamID uniqueidentifier,
	@FolderID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT * FROM fnx_Permissions_GetGuidProductTypePermissions(@TeamID, @FolderID) perms
	WHERE perms.ProductTypeID = @ProductTypeID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07643', GetDate())
GO
