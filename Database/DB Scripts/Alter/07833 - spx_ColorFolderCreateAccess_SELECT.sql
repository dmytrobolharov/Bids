/****** Object:  StoredProcedure [dbo].[spx_ColorFolderCreateAccess_SELECT]    Script Date: 06/03/2014 13:04:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorFolderCreateAccess_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorFolderCreateAccess_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ColorFolderCreateAccess_SELECT]    Script Date: 06/03/2014 13:04:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_ColorFolderCreateAccess_SELECT](
@TeamID UNIQUEIDENTIFIER 
)
AS 

DECLARE @Role INT 
DECLARE @Create INT 

SELECT @Role = MAX ( PermissionRoleID ) , @Create = MAX(PermissionCreate ) 
FROM fnx_Permissions_GetIntProductTypePermissions(@TeamID, 7)

IF @Role  = 3 OR @Create = 1 
	SELECT 1 as nRes
ELSE
	SELECT  0 AS nRes

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07833', GetDate())
GO