/****** Object:  StoredProcedure [dbo].[spx_sPermissionProductTypeMap_UPDATE]    Script Date: 02/11/2014 16:49:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sPermissionProductTypeMap_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_sPermissionProductTypeMap_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_sPermissionProductTypeMap_UPDATE]    Script Date: 02/11/2014 16:49:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_sPermissionProductTypeMap_UPDATE]
	@PermissionProductTypeMapId int,
	@PermissionFolderTypeId int,
	@GuidProductTypeId uniqueidentifier = null,
	@IntProductTypeId int = null,
	@StrProductTypeId nvarchar(100) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
UPDATE sPermissionProductTypeMap SET PermissionFolderTypeId = @PermissionFolderTypeId,GuidProductTypeId = @GuidProductTypeId,IntProductTypeId = @IntProductTypeId, StrProductTypeId = @StrProductTypeId WHERE PermissionProductTypeMapId = @PermissionProductTypeMapId
    
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07665', GetDate())
GO
