IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorLogic_UPDATE]
GO



CREATE PROCEDURE [dbo].[spx_ColorLogic_UPDATE](
@ColorPaletteID UNIQUEIDENTIFIER ,
@MUser NVARCHAR (200),
@MDate DATETIME 
)
AS 

DECLARE @ColorCode NVARCHAR (200) 
DECLARE @ColorName NVARCHAR (200) 
DECLARE @Sort NVARCHAR(10) 

--	July 17, 2012 - Added by Valentino Strappato
Declare @cColorType	nvarchar(50)	--	ColorType from ColorType SQL table. NOTE: this works if there is only 1 Corporate Color palette
Select top 1 @cColorType=ColorType from ColorType where CorpColor=1
--Select @cColorType

SELECT 	@ColorCode = ColorCode, @ColorName = ColorName , @Sort = Sort
FROM pColorPalette 
WHERE ColorPaletteID = @ColorPaletteID

DECLARE @nSort INT 


BEGIN TRY
	SET @nSort  =  CAST ( @Sort AS INT ) 
END TRY
BEGIN CATCH
	SET @nSort = 0 
END CATCH 

DECLARE @SortTmp NVARCHAR(15) 

SET @SortTmp = '0000' + CAST(@nSort as NVARCHAR(10))
SET @SortTmp = RIGHT( @SortTmp , 4) 


UPDATE pColorPalette SET Sort = @SortTmp WHERE ColorPaletteID = @ColorPaletteID

UPDATE pMaterialColor SET   ColorCode  = @ColorCode, 
ColorName = @ColorName, 	MUser = @MUser, MDate = @MDate 
WHERE ColorPaletteID = @ColorPaletteID 

-- UPDATE Style Colorway -- #01

UPDATE pStyleColorway Set StyleColorNo = @ColorCode,
StyleColorName = @ColorName, MainColor = @ColorName, MUser = @MUser, MDate = @MDate 
WHERE ColorPaletteID = @ColorPaletteID 

/* Begin UPDATE DimBOM colorways */

CREATE TABLE #tmpStyleColorway (ROW_ID INT IDENTITY(1,1), StyleColorID UNIQUEIDENTIFIER)
INSERT INTO #tmpStyleColorway (StyleColorID)
SELECT StyleColorID FROM pStyleColorway WHERE ColorPaletteID = @ColorPaletteID

DECLARE @iRow INT = 1
DECLARE @iCount INT
SELECT @iCount = COUNT(*) FROM #tmpStyleColorway
DECLARE @StyleColorID UNIQUEIDENTIFIER

WHILE (@iRow <= @iCount) 
BEGIN
	SELECT @StyleColorID = StyleColorID FROM #tmpStyleColorway WHERE ROW_ID = @iRow
	
	UPDATE pStyleBOMDimensionItem SET ItemDim1Name = @ColorName
	WHERE ItemDim1Id = @StyleColorID
	UPDATE pStyleBOMDimensionItems SET ItemDim1Name = @ColorName
	WHERE ItemDim1Id = @StyleColorID
	UPDATE pStyleBOMItem SET ItemDim1Name = @ColorName
	WHERE ItemDim1Id = @StyleColorID
	UPDATE pSampleRequestStyleBOM SET ItemDim1Name = @ColorName
	WHERE ItemDim1Id = @StyleColorID
	UPDATE pSourcingQuoteStyleBOM SET ItemDim1Name = @ColorName
	WHERE ItemDim1Id = @StyleColorID
	UPDATE pSourcingQuotationBOMDetails SET ItemDim1Name = @ColorName
	WHERE ItemDim1Id = @StyleColorID
	UPDATE pSourcingCommitmentBOM SET ItemDim1Name = @ColorName
	WHERE ItemDim1Id = @StyleColorID
	UPDATE pSourcingCommitmentBOMDetails SET ItemDim1Name = @ColorName
	WHERE ItemDim1Id = @StyleColorID

	UPDATE pStyleBOMDimensionItem SET ItemDim2Name = @ColorName
	WHERE ItemDim2Id = @StyleColorID
	UPDATE pStyleBOMDimensionItems SET ItemDim2Name = @ColorName
	WHERE ItemDim2Id = @StyleColorID
	UPDATE pStyleBOMItem SET ItemDim2Name = @ColorName
	WHERE ItemDim2Id = @StyleColorID
	UPDATE pSampleRequestStyleBOM SET ItemDim2Name = @ColorName
	WHERE ItemDim2Id = @StyleColorID
	UPDATE pSourcingQuoteStyleBOM SET ItemDim2Name = @ColorName
	WHERE ItemDim2Id = @StyleColorID
	UPDATE pSourcingQuotationBOMDetails SET ItemDim2Name = @ColorName
	WHERE ItemDim2Id = @StyleColorID
	UPDATE pSourcingCommitmentBOM SET ItemDim2Name = @ColorName
	WHERE ItemDim2Id = @StyleColorID
	UPDATE pSourcingCommitmentBOMDetails SET ItemDim2Name = @ColorName
	WHERE ItemDim2Id = @StyleColorID

	UPDATE pStyleBOMDimensionItem SET ItemDim3Name = @ColorName
	WHERE ItemDim3Id = @StyleColorID
	UPDATE pStyleBOMDimensionItems SET ItemDim3Name = @ColorName
	WHERE ItemDim3Id = @StyleColorID
	UPDATE pStyleBOMItem SET ItemDim3Name = @ColorName
	WHERE ItemDim3Id = @StyleColorID
	UPDATE pSampleRequestStyleBOM SET ItemDim3Name = @ColorName
	WHERE ItemDim3Id = @StyleColorID
	UPDATE pSourcingQuoteStyleBOM SET ItemDim3Name = @ColorName
	WHERE ItemDim3Id = @StyleColorID
	UPDATE pSourcingQuotationBOMDetails SET ItemDim3Name = @ColorName
	WHERE ItemDim3Id = @StyleColorID
	UPDATE pSourcingCommitmentBOM SET ItemDim3Name = @ColorName
	WHERE ItemDim3Id = @StyleColorID
	UPDATE pSourcingCommitmentBOMDetails SET ItemDim3Name = @ColorName
	WHERE ItemDim3Id = @StyleColorID
	
	SET @iRow = @iRow + 1
END

DROP TABLE #tmpStyleColorway

/* End UPDATE DimBOM colorways */


-- UPDATE COLOR LIBRARY

IF (SELECT COUNT(*) FROM ColorLibrary WHERE ColorPaletteID = @ColorPaletteID) = 0
BEGIN

		--	July 17, 2012 - INSERT modified by Valentino Strappato
		--	Use @cColorType instead of "Burberry Default"
		INSERT INTO ColorLibrary(PantoneType, PantoneNumber, PantoneName, Hex, R, G, B, C, M, Y, K, H, S, L, 
			LAB_L, LAB_A, LAB_B, CUser, CDate, MUser, MDate, ColorPaletteID, ColorSource)
		SELECT @cColorType AS ColorType, ColorCode, ColorName, Hex, R, G, B, C, M, Y, K, H, S, L, 
			LAB_L, LAB_A, LAB_B, CUser, CDate, MUser, MDate, ColorPaletteId, ColorSource 
		FROM pColorPalette WHERE ColorPaletteID = @ColorPaletteId

END
ELSE
BEGIN

		--	July 17, 2012 - Update modified by Valentino Strappato
		UPDATE ColorLibrary SET 
			PantoneNumber = b.ColorCode, PantoneName = b.ColorName, ColorSource = b.ColorSource, 
			Hex = RIGHT(b.Hex,6), 
			R = b.R, G = b.G, B = b.B, C = b.C, M = b.M, 
			Y = b.Y, K = b.K, H = b.H, S = b.S, L = b.L, 
			LAB_L = b.Lab_L, LAB_A = b.LAB_A, LAB_B = b.LAB_B, 
			MUser = b.MUser, MDate = b.MDate 
		FROM ColorLibrary a
			INNER JOIN pColorPalette b ON b.ColorPaletteID = a.ColorPaletteID
		WHERE b.ColorPaletteID = @ColorPaletteId 
		--	July 17, 2012 - Not only for Burberry Default
		--AND  a.PantoneType = 'Burberry Default'

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07302', GetDate())
GO
