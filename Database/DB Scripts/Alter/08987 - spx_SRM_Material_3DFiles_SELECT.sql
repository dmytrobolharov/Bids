IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SRM_Material_3DFiles_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SRM_Material_3DFiles_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SRM_Material_3DFiles_SELECT]
(
	@MaterialID UNIQUEIDENTIFIER
	, @SearchString NVARCHAR(MAX) = ''
)

AS

BEGIN
	SELECT *
	FROM pMaterialDocument
	WHERE [3D] = 1
		AND MaterialDocumentShared = 1
		AND MaterialID = @MaterialID
		AND (MaterialDocumentDescription LIKE '%' + @SearchString + '%' OR MaterialDocumentName LIKE '%' + @SearchString + '%')
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08987', GetDate())
GO
