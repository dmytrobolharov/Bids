IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_SKUHeader_DUPLICATE_CHECK]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_SKUHeader_DUPLICATE_CHECK]
GO

CREATE PROCEDURE [dbo].[spx_LineFolder_SKUHeader_DUPLICATE_CHECK]
	@LineFolderID UNIQUEIDENTIFIER,	
	@LineFolderSKUHeaderID UNIQUEIDENTIFIER = NULL,
	@Name NVARCHAR(400) = '' 
AS
BEGIN
	
	IF @LineFolderSKUHeaderID IS NULL -- for new item
		SELECT COUNT(*) FROM pLineFolderSKUHeader
		WHERE LineFolderID = @LineFolderID AND LineFolderSKUHeaderName = @Name
	ELSE
		SELECT COUNT(*) FROM pLineFolderSKUHeader
		WHERE LineFolderID = @LineFolderID
			AND LineFolderSKUHeaderID <> @LineFolderSKUHeaderID
			AND LineFolderSKUHeaderName = @Name
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07443', GetDate())
GO
