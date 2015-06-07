/****** Object:  StoredProcedure [dbo].[spx_MaterialDocument_SELECT]    Script Date: 02/20/2015 15:18:49 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialDocument_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialDocument_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_MaterialDocument_SELECT] (
	@MaterialID uniqueidentifier,
	@MaterialRequest int,
	@Is3D INT = 0,
	@SqlFilter NVARCHAR(MAX) = NULL,
	@PageNo INT = NULL,
	@PageSize INT = NULL,
	@SortOrder NVARCHAR(MAX) = NULL
)
AS 

IF @MaterialRequest = 1
	BEGIN
		SELECT MaterialDocumentID, MaterialID, MaterialDocumentName, 
			MaterialDocumentDescription, MaterialDocumentExt, MaterialDocumentSize, 
			MaterialDocumentShared, CUser, CDate, MUser, MDate, MChange, 
			SystemServerStorageID
			INTO #tmp0
			FROM pMaterialDocument 
		WHERE MaterialID = @MaterialID AND MaterialDocumentShared = @MaterialRequest
		
		DECLARE @sqlString  NVARCHAR(MAX) = dbo.fnx_CreatePagingString('#tmp0',@PageNo,@PageSize,@SortOrder, @SqlFilter)

		exec sp_executesql @sqlString
	END
ELSE
	BEGIN
		SELECT MaterialDocumentID, MaterialID, MaterialDocumentName, 
			MaterialDocumentDescription, MaterialDocumentExt, MaterialDocumentSize, 
			MaterialDocumentShared, CUser, CDate, MUser, MDate, MChange, 
			SystemServerStorageID
			INTO #tmp1
			FROM pMaterialDocument 
		WHERE MaterialID = @MaterialID AND [3D] = @Is3D
		
		DECLARE @sqlString1  NVARCHAR(MAX) = dbo.fnx_CreatePagingString('#tmp1',@PageNo,@PageSize,@SortOrder, @SqlFilter)

		exec sp_executesql @sqlString1
	END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09508', GetDate())
GO
