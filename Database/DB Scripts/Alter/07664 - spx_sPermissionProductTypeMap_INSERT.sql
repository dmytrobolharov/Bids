/****** Object:  StoredProcedure [dbo].[spx_sPermissionProductTypeMap_INSERT]    Script Date: 02/11/2014 16:48:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sPermissionProductTypeMap_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_sPermissionProductTypeMap_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_sPermissionProductTypeMap_INSERT]    Script Date: 02/11/2014 16:48:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_sPermissionProductTypeMap_INSERT]	
	@PermissionFolderTypeId int,
	@GuidProductTypeId uniqueidentifier = null,
	@IntProductTypeId int = NULL,
	@StrProductTypeId nvarchar(100) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF (@GuidProductTypeId IS NULL AND @IntProductTypeId IS NULL AND @StrProductTypeId IS NULL)
		RETURN
	
	DECLARE @ProductTypeMapId int
	
	IF NOT @GuidProductTypeId IS NULL
		SELECT @ProductTypeMapId = map.PermissionProductTypeMapId FROM sPermissionProductTypeMap AS map WHERE map.PermissionFolderTypeId = @PermissionFolderTypeId AND map.GuidProductTypeId = @GuidProductTypeId
	ELSE IF NOT @IntProductTypeId IS NULL
		SELECT @ProductTypeMapId = map.PermissionProductTypeMapId FROM sPermissionProductTypeMap AS map WHERE map.PermissionFolderTypeId = @PermissionFolderTypeId AND map.IntProductTypeId = @IntProductTypeId
	ELSE IF NOT @StrProductTypeId IS NULL
		SELECT @ProductTypeMapId = map.PermissionProductTypeMapId FROM sPermissionProductTypeMap AS map WHERE map.PermissionFolderTypeId = @PermissionFolderTypeId AND map.StrProductTypeId = @StrProductTypeId

	IF(@ProductTypeMapId IS NULL)
	BEGIN
		INSERT INTO sPermissionProductTypeMap(PermissionFolderTypeId,GuidProductTypeId,IntProductTypeId,StrProductTypeId) 
		VALUES(@PermissionFolderTypeId,@GuidProductTypeId,@IntProductTypeId,@StrProductTypeId)
		SELECT @@IDENTITY;
    END
    ELSE 
		SELECT @ProductTypeMapId
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07664', GetDate())
GO
