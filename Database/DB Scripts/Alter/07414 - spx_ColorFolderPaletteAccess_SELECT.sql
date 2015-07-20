IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorFolderPaletteAccess_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorFolderPaletteAccess_SELECT]
GO


Create PROCEDURE [dbo].[spx_ColorFolderPaletteAccess_SELECT](
@TeamID UNIQUEIDENTIFIER 
)
AS 

DECLARE @Role INT 
DECLARE @Create INT 

SELECT @Role = MAX ( AccessRoleID ) , @Create = MAX(AccessCreate ) 
FROM dbo.sAccessColorFolder
WHERE TeamID = @TeamID  AND ColorTypeId <> '0'

IF @Role  = 3 OR @Create = 1 
	SELECT 1 as nRes
ELSE
	SELECT 0 AS nRes

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07414', GetDate())
GO
