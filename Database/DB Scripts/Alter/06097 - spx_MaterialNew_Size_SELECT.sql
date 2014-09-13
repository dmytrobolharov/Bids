IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialNew_Size_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialNew_Size_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialNew_Size_SELECT]
	@MaterialID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT * FROM pMaterialSize WHERE MaterialID = @MaterialID
	ORDER BY MaterialSize
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06097', GetDate())
GO
