IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItem_SortOrder_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItem_SortOrder_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_LineFolderItem_SortOrder_UPDATE]
(
	@LineFolderID UNIQUEIDENTIFIER
)
AS
BEGIN
	DECLARE @MaxSort AS INTEGER
	DECLARE @LineFolderItemNoSort TABLE (LineFolderItemID UNIQUEIDENTIFIER, LineFolderItemSort NVARCHAR(5))

	INSERT INTO @LineFolderItemNoSort (LineFolderItemID, LineFolderItemSort)
	SELECT
		LineFolderItemID
		, RIGHT('0000' + CAST(ROW_NUMBER() OVER (ORDER BY sh.StyleNo, sh.Description) AS NVARCHAR(5)), 4)
	FROM pLineFolderItem lfi
		INNER JOIN pStyleHeader sh on lfi.StyleID = sh.StyleID
	WHERE LineFolderItemSort IS NULL AND LineFolderID = @LineFolderID

	SET @MaxSort = @@ROWCOUNT + 1

	SELECT @MaxSort

	UPDATE pLineFolderItem SET LineFolderItemSort = lfi.LineFolderItemSort
	FROM @LineFolderItemNoSort lfi
	WHERE pLineFolderItem.LineFolderItemID = lfi.LineFolderItemID

	;WITH lfins AS (
	SELECT
		pLineFolderItem.LineFolderItemID
		, RIGHT('0000' + CAST(CAST(pLineFolderItem.LineFolderItemSort AS INT) + @MaxSort AS NVARCHAR(5)), 4) AS LineFolderItemSort
	FROM pLineFolderItem
		LEFT JOIN @LineFolderItemNoSort lfi ON pLineFolderItem.LineFolderItemID = lfi.LineFolderItemID
	WHERE lfi.LineFolderItemID IS NULL
	)
	UPDATE pLineFolderItem SET LineFolderItemSort = lfins.LineFolderItemSort
	FROM lfins
	WHERE pLineFolderItem.LineFolderItemID = lfins.LineFolderItemID
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10212', GetUTCDate())
GO
