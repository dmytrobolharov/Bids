IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_ImageVersion_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Material_ImageVersion_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_Material_ImageVersion_UPDATE]
	@MaterialID UNIQUEIDENTIFIER,
	@ImageVersion NVARCHAR(10)
AS
BEGIN	
	UPDATE pMaterial SET MaterialImageVersion = @ImageVersion WHERE MaterialID = @MaterialID
END




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07808', GetDate())
GO
