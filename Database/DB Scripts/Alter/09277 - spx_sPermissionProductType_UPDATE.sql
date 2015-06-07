/****** Object:  StoredProcedure [dbo].[spx_sPermissionProductType_UPDATE]    Script Date: 24.01.2015 12:29:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sPermissionProductType_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_sPermissionProductType_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_sPermissionProductType_UPDATE]    Script Date: 24.01.2015 12:29:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_sPermissionProductType_UPDATE]
	@PermissionProductTypeId uniqueidentifier,
	@PermissionFolderId uniqueidentifier = NULL,
	@PermissionProductTypeMapId int = NULL,
	@PermissionProductTypeLocked int = NULL,
	@GroupId uniqueidentifier = NULL,
	@MUser nvarchar(200) = NULL,
	@MDate datetime = NULL,
	@PermissionProductTypeName nvarchar(256) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE sPermissionProductType SET 
	PermissionFolderId = @PermissionFolderId,
	PermissionProductTypeMapId = @PermissionProductTypeMapId,
	PermissionProductTypeNotLocked = @PermissionProductTypeLocked,
	GroupId = @GroupId,
	MUser = @MUser,
	MDate = @MDate,
	PermissionProductTypeName = @PermissionProductTypeName 
	WHERE PermissionProductTypeId = @PermissionProductTypeId
END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09277', GetDate())
GO
