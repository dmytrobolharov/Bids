IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineListFlashCosting_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineListFlashCosting_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_LineListFlashCosting_INSERT]
	@LineFolderID uniqueidentifier
AS
BEGIN
	INSERT INTO pLineListFlashCosting(LineFolderItemID)
	SELECT
		LineFolderItemID
	FROM
		pLineFolder lf
		, pLineFolderItem lfi
	WHERE
		lf.LineFolderID = @LineFolderID
		AND (SELECT COUNT (*) FROM pLineListFlashCosting WHERE LineFolderItemID=lfi.LineFolderItemID)=0
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04632', GetDate())
GO
