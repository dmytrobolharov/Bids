/****** Object:  StoredProcedure [dbo].[spx_sPermissionFolderType_UPDATE]    Script Date: 02/11/2014 16:54:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sPermissionFolderType_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_sPermissionFolderType_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_sPermissionFolderType_UPDATE]    Script Date: 02/11/2014 16:54:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_sPermissionFolderType_UPDATE]	
	@PermissionFolderTypeId int,
	@PermissionFolderTypeName nvarchar(50) = NULL,
	@CUser nvarchar(200) = NULL,
	@CDate datetime = NULL,
	@MUser nvarchar(200) = NULL,
	@MDate datetime = NULL,
	@Active int = 1
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE sPermissionFolderType SET PermissionFolderTypeName = @PermissionFolderTypeName, CUser = @CUser, CDate = @CDate, MUser = @MUser,MDate = @MDate,Active = @Active WHERE PermissionFolderTypeId = @PermissionFolderTypeId
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07669', GetDate())
GO
