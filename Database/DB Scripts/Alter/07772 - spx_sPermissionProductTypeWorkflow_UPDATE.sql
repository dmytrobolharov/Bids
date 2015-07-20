/****** Object:  StoredProcedure [dbo].[spx_sPermissionProductTypeWorkflow_UPDATE]    Script Date: 05/28/2014 18:46:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sPermissionProductTypeWorkflow_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_sPermissionProductTypeWorkflow_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_sPermissionProductTypeWorkflow_UPDATE]    Script Date: 05/28/2014 18:46:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_sPermissionProductTypeWorkflow_UPDATE]
	@PermissionFolderId uniqueidentifier,
	@PermissionProductTypeId uniqueidentifier,
	@GroupID uniqueidentifier,
	@PermissionRoleId int,
	@PermissionView int,
	@PermissionCreate int,
	@PermissionRemove int,
	@PermissionModify int,
	@PermissionDelete int,
	@PermissionPrint int,
	@MUser nvarchar(200) = NULL,
	@MDate datetime = NULL
AS
BEGIN

	SET NOCOUNT ON;
    UPDATE sPermissionWorkflow SET PermissionRoleId = @PermissionRoleId,PermissionView = @PermissionView,PermissionCreate = @PermissionCreate,PermissionRemove = @PermissionRemove,PermissionModify = @PermissionModify,PermissionDelete = @PermissionDelete,PermissionPrint = @PermissionPrint,MUser = @MUser,MDate = @MDate WHERE PermissionFolderId = @PermissionFolderId AND PermissionProductTypeId = @PermissionProductTypeId AND GroupID = @GroupID
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07772', GetDate())
GO