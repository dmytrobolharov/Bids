/****** Object:  StoredProcedure [dbo].[spx_Group_ProductPermissionsOnFolder_SELECT]    Script Date: 05/16/2014 18:29:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_ProductPermissionsOnFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_ProductPermissionsOnFolder_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Group_ProductPermissionsOnFolder_SELECT]    Script Date: 05/16/2014 18:29:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_Group_ProductPermissionsOnFolder_SELECT]
@GroupID uniqueidentifier,
@FolderID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from sPermissionProductType as product where product.PermissionFolderId = @FolderID and product.GroupId = @GroupID
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07650', GetDate())
GO
