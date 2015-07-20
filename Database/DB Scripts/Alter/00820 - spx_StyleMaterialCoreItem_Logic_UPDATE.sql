IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterialCoreItem_Logic_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleMaterialCoreItem_Logic_UPDATE]
GO

CREATE PROCEDURE dbo.spx_StyleMaterialCoreItem_Logic_UPDATE(
	@StyleMaterialID UNIQUEIDENTIFIER,
	@MaterialCoreItemID UNIQUEIDENTIFIER, 
	@MUser NVARCHAR(200),
	@MDate DATETIME
)
AS


DECLARE 
	@ROWID INT, 
	@TOTAL INT, 
	@MaterialColorID UNIQUEIDENTIFIER,
	@ColorCode NVARCHAR(200),
	@ColorName	NVARCHAR(200) 
	

CREATE TABLE #color (
	ROWID INT IDENTITY(1,1),
	MaterialColorID UNIQUEIDENTIFIER,
	ColorCode NVARCHAR(200),
	ColorName NVARCHAR(200)
)	

INSERT INTO #color (MaterialColorID, ColorCode, ColorName )
SELECT a.MaterialColorID , c.ColorCode, c.ColorName
FROM dbo.pMaterialCoreColorItem a WITH (NOLOCK)
	INNER JOIN dbo.pMaterialCoreColor b  WITH (NOLOCK) ON a.MaterialCoreColorID =  b.MaterialCoreColorID
	INNER JOIN dbo.pColorPalette c  WITH (NOLOCK) ON c.ColorPaletteID =  b.ColorPaletteID
	INNER JOIN  (
		SELECT DISTINCT c.ColorCode, c.ColorName
		FROM dbo.pStyleColorwayItem a  WITH (NOLOCK)
			INNER JOIN dbo.pStyleColorway b  WITH (NOLOCK) ON a.StyleColorID = b.StyleColorID
			INNER JOIN dbo.pColorPalette c  WITH (NOLOCK) ON c.ColorPaletteID =  b.ColorPaletteID
		WHERE StyleMaterialID = @StyleMaterialID
	) AS foo ON foo.ColorCode =  c.ColorCode AND foo.ColorName = c.ColorName
WHERE MaterialCoreItemID = @MaterialCoreItemID	


SELECT @TOTAL = COUNT(*) FROM #color
SET @ROWID = 1 

WHILE @ROWID <= @TOTAL
BEGIN
	
	SELECT @MaterialColorID = MaterialColorID, @ColorCode = ColorCode, @ColorName = ColorName
	FROM #color WHERE ROWID = @ROWID 
	
	UPDATE pStyleColorwayItem
	SET MaterialColorID = @MaterialColorID 
	FROM pStyleColorwayItem 
		INNER JOIN dbo.pStyleColorway b  ON pStyleColorwayItem.StyleColorID =  b.StyleColorID 
		INNER JOIN dbo.pColorPalette c ON c.ColorPaletteID =  b.ColorPaletteID
	WHERE pStyleColorwayItem.StyleMaterialID = @StyleMaterialID
		AND c.ColorCode = @ColorCode 
		AND c.ColorName = @ColorName
		
	SET @ROWID = @ROWID + 1 
END 


DROP TABLE #color
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '820', GetDate())
GO