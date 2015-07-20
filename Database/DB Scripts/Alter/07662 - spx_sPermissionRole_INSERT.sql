/****** Object:  StoredProcedure [dbo].[spx_sPermissionRole_INSERT]    Script Date: 02/11/2014 16:46:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sPermissionRole_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_sPermissionRole_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_sPermissionRole_INSERT]    Script Date: 02/11/2014 16:46:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_sPermissionRole_INSERT]	
	@PermissionRoleCode nvarchar(10) = NULL,
	@PermissionRoleName nvarchar(100) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO	sPermissionRole(PermissionRoleCode,PermissionRoleName) VALUES(@PermissionRoleCode,@PermissionRoleName)
	SELECT @@IDENTITY;
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07662', GetDate())
GO
