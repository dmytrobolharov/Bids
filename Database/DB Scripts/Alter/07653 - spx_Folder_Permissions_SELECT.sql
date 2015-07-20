/****** Object:  StoredProcedure [dbo].[spx_Folder_Permissions_SELECT]    Script Date: 02/11/2014 16:11:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Folder_Permissions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Folder_Permissions_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Folder_Permissions_SELECT]    Script Date: 02/11/2014 16:11:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_Folder_Permissions_SELECT]
	-- Add the parameters for the stored procedure here
	@GroupID uniqueidentifier,
	@FolderID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
  SELECT workFlow.*, product.PermissionProductTypeName AS TypeName FROM sPermissionWorkflow AS workFlow 
 INNER JOIN sPermissionProductType as product on workFlow.PermissionProductTypeId = product.PermissionProductTypeId  WHERE workFlow.GroupID = @GroupID AND product.PermissionFolderId = @FolderID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07653', GetDate())
GO
