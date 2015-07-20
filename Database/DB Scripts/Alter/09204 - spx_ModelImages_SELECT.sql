IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ModelImages_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ModelImages_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_ModelImages_SELECT]
(
	@StyleID UNIQUEIDENTIFIER
	, @StyleSet INT
)
AS
BEGIN

	SELECT sp.ID, sp.Piece_Name, sp.Piece_Image_SN, sp.ModelID
	FROM pBodyPatternSheetModel sm
		INNER JOIN pBodyPatternSheetPiece sp ON sm.ID = sp.ModelID
	WHERE sm.StyleID = @StyleID
		AND sm.StyleSet = @StyleSet
		AND sm.IsLinked = 1
	ORDER BY sp.ModelID, sp.PiecePosition

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09204', GetDate())
GO