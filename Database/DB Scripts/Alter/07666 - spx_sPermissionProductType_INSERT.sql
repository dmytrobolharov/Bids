/****** Object:  StoredProcedure [dbo].[spx_sPermissionProductType_INSERT]    Script Date: 02/11/2014 16:50:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sPermissionProductType_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_sPermissionProductType_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_sPermissionProductType_INSERT]    Script Date: 02/11/2014 16:50:35 ******/
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
	@Active int = NULL,
	@PermissionProductTypeName nvarchar(256) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @MyIdentity uniqueidentifier;
	SET @MyIdentity = NewID();
INSERT INTO sPermissionProductType(PermissionProductTypeId,PermissionFolderId,PermissionProductTypeMapId,PermissionProductTypeNotLocked,GroupId,CUser,CDate,MUser,MDate,Active,PermissionProductTypeName) VALUES(@MyIdentity,@PermissionFolderId,@PermissionProductTypeMapId,@PermissionProductTypeNotLocked,@GroupId,@CUser,@CDate,@MUser,@MDate,@Active,@PermissionProductTypeName)
SELECT @MyIdentity;
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07666', GetDate())
GO
