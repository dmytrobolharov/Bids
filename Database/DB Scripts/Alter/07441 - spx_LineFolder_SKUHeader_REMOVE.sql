IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_SKUHeader_REMOVE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_SKUHeader_REMOVE]
GO

CREATE PROCEDURE [dbo].[spx_LineFolder_SKUHeader_REMOVE]
	@LineFolderSKUHeaderID UNIQUEIDENTIFIER
AS
BEGIN
	
	DELETE FROM pLineFolderSKUHeaderDimType WHERE LineFolderSKUHeaderID = @LineFolderSKUHeaderID
	DELETE FROM pLineFolderSKUHeader WHERE LineFolderSKUHeaderID = @LineFolderSKUHeaderID
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07441', GetDate())
GO
