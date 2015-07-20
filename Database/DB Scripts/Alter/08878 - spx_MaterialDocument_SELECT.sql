IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialDocument_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialDocument_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialDocument_SELECT]
(
	@MaterialID UNIQUEIDENTIFIER
	, @MaterialRequest INT
)
AS

IF @MaterialRequest = 1
BEGIN
	SELECT MaterialDocumentID
		, MaterialID
		, MaterialDocumentName
		, MaterialDocumentDescription
		, MaterialDocumentExt
		, MaterialDocumentSize
		, MaterialDocumentShared
		, CUser
		, CDate
		, MUser
		, MDate
		, MChange
		, SystemServerStorageID
	FROM pMaterialDocument
	WHERE MaterialID = @MaterialID
		AND MaterialDocumentShared = @MaterialRequest
END
ELSE
BEGIN
	SELECT MaterialDocumentID
		, MaterialID
		, MaterialDocumentName
		, MaterialDocumentDescription
		, MaterialDocumentExt
		, MaterialDocumentSize
		, MaterialDocumentShared
		, CUser
		, CDate
		, MUser
		, MDate
		, MChange
		, SystemServerStorageID
	FROM pMaterialDocument
	WHERE MaterialID = @MaterialID
		AND [3D] = 0 OR ([3D] = 1 AND MaterialDocumentShared = 1)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08878', GetDate())
GO
