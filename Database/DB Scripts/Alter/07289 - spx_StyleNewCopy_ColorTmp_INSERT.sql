IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleNewCopy_ColorTmp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleNewCopy_ColorTmp_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleNewCopy_ColorTmp_INSERT](
	@TransactionID UNIQUEIDENTIFIER,
	@StyleColorwaySeasonYearID UNIQUEIDENTIFIER
)
AS 

IF EXISTS (SELECT * FROM pStyleColorwaySeasonYear WHERE StyleColorwaySeasonYearID = @StyleColorwaySeasonYearID AND StyleColorwayID IS NOT NULL)
BEGIN
	DECLARE @StyleColorID UNIQUEIDENTIFIER
	SELECT @StyleColorID = StyleColorwayID FROM pStyleColorwaySeasonYear WHERE StyleColorwaySeasonYearID = @StyleColorwaySeasonYearID
	
	INSERT INTO pStyleCopyColorTmp(StyleCopyColorTmpID, TransactionID, StyleColorwaySeasonYearID, StyleColorID, ColorPaletteID)
	VALUES (NEWID(), @TransactionID, @StyleColorwaySeasonYearID, @StyleColorID, NULL)
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07289', GetDate())
GO
