IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SingleCADImage_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SingleCADImage_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SingleCADImage_SELECT]
(
	@ImageSN NVARCHAR(6)
	, @CADDatabaseServer NVARCHAR(MAX)
	, @CADDatabaseCatalog NVARCHAR(MAX)
)
AS
BEGIN
	DECLARE @strSQL NVARCHAR(MAX)

	SET @strSQL = 'SELECT ImageSerialNumber, ImageSize, ImageBLOB
				   FROM [' + @CADDatabaseServer + '].[' + @CADDatabaseCatalog + '].[dbo].PPFRepresentatives
				   WHERE ImageSerialNumber = ' + @ImageSN

	EXECUTE sp_executesql @strSQL

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09203', GetDate())
GO