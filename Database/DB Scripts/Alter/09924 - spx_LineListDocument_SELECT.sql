IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineListDocument_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineListDocument_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LineListDocument_SELECT]
	@LineFolderID UNIQUEIDENTIFIER,
	@Filter NVARCHAR(500),
	@PageNo INT = NULL,
	@PageSize INT = NULL
AS
BEGIN
	IF @Filter IS NULL OR @Filter = ''
	BEGIN
	
		SELECT * 
		INTO #tmp0
		FROM pLineListDocument 
		WHERE LineFolderID = @LineFolderID
		
		DECLARE @sqlString  NVARCHAR(MAX) = dbo.fnx_CreatePagingString('#tmp0', @PageNo, @PageSize, 'LineListDocumentName', NULL)
		exec sp_executesql @sqlString
		DROP TABLE #tmp0
		
	END
	ELSE
	BEGIN
	
		SELECT * 
		INTO #tmp1
		FROM pLineListDocument 
		WHERE LineFolderID = @LineFolderID
			AND (LineListDocumentName LIKE '%' + @Filter + '%' OR LineListDocumentDescription LIKE '%' + @Filter + '%')
		
		DECLARE @sqlString1  NVARCHAR(MAX) = dbo.fnx_CreatePagingString('#tmp1', @PageNo, @PageSize, 'LineListDocumentName', NULL)
		exec sp_executesql @sqlString1
		DROP TABLE #tmp1
		
	END
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09924', GetDate())
GO
