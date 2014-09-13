IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialDocument_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialDocument_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_MaterialDocument_SELECT] (
	@MaterialID uniqueidentifier,
	@MaterialRequest int,
	@Is3D INT = 0
)
AS 

IF @MaterialRequest = 1
	BEGIN
		SELECT MaterialDocumentID, MaterialID, MaterialDocumentName, 
			MaterialDocumentDescription, MaterialDocumentExt, MaterialDocumentSize, 
			MaterialDocumentShared, CUser, CDate, MUser, MDate, MChange, 
			SystemServerStorageID
		FROM pMaterialDocument 
		WHERE MaterialID = @MaterialID AND MaterialDocumentShared = @MaterialRequest
	END
ELSE
	BEGIN
		SELECT MaterialDocumentID, MaterialID, MaterialDocumentName, 
			MaterialDocumentDescription, MaterialDocumentExt, MaterialDocumentSize, 
			MaterialDocumentShared, CUser, CDate, MUser, MDate, MChange, 
			SystemServerStorageID
		FROM pMaterialDocument 
		WHERE MaterialID = @MaterialID AND [3D] = @Is3D
	END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08990', GetDate())
GO
