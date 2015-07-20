/****** Object:  StoredProcedure [dbo].[spx_sPermissionProductType_INSERT]    Script Date: 24.01.2015 12:30:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sPermissionProductType_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_sPermissionProductType_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_sPermissionProductType_INSERT]    Script Date: 24.01.2015 12:30:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_sPermissionProductType_INSERT]	
	@PermissionFolderId uniqueidentifier = NULL,
	@PermissionProductTypeMapId int = NULL,
	@PermissionProductTypeNotLocked int = NULL,
	@GroupId uniqueidentifier = NULL,
	@CUser  nvarchar(200) = NULL,
	@CDate datetime = NULL,
	@MUser nvarchar(200) = NULL,
	@MDate datetime = NULL,
	@Active int = 1,
	@PermissionProductTypeName nvarchar(256) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @MyIdentity uniqueidentifier;
	SET @MyIdentity = NewID();
	INSERT INTO sPermissionProductType(PermissionProductTypeId,PermissionFolderId,PermissionProductTypeMapId,
	PermissionProductTypeNotLocked,GroupId,CUser,CDate,MUser,MDate,
	Active,PermissionProductTypeName) 
	VALUES(@MyIdentity,@PermissionFolderId,@PermissionProductTypeMapId,
	@PermissionProductTypeNotLocked,@GroupId,ISNULL(@CUser, 'System'),ISNULL(@CDate, CURRENT_TIMESTAMP),@MUser,@MDate,
	ISNULL(@Active, 1),@PermissionProductTypeName)
	SELECT @MyIdentity;
END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09276', GetDate())
GO
