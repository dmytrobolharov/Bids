IF OBJECT_ID(N'[dbo].[spx_LineListDocument_SELECT]') IS NOT NULL
	DROP PROCEDURE [dbo].[spx_LineListDocument_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LineListDocument_SELECT]
	@LineFolderID UNIQUEIDENTIFIER,
	@Filter NVARCHAR(500)
AS
BEGIN
	IF @Filter IS NULL OR @Filter = ''
	BEGIN
		SELECT * FROM pLineListDocument 
		WHERE LineFolderID = @LineFolderID
		ORDER BY LineListDocumentName
	END
	ELSE
	BEGIN
		SELECT * FROM pLineListDocument 
		WHERE LineFolderID = @LineFolderID
			AND (LineListDocumentName LIKE '%' + @Filter + '%' OR LineListDocumentDescription LIKE '%' + @Filter + '%')
		ORDER BY LineListDocumentName
	END
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '6.1.0000', '09581', GetDate())
GO