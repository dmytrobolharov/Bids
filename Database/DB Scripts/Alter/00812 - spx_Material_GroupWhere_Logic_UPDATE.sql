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


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_GroupWhere_Logic_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_Material_GroupWhere_Logic_UPDATE]
GO


CREATE PROCEDURE dbo.spx_Material_GroupWhere_Logic_UPDATE(
	@MaterialCoreItemID UNIQUEIDENTIFIER,
	@MaterialCoreColorID UNIQUEIDENTIFIER,
	@MaterialColorID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME
)
AS 


DECLARE
	@ColorCode NVARCHAR(200),
	@ColorName NVARCHAR(200),
	@ROWID INT, 
	@TOTAL INT,
	@StyleMaterialID UNIQUEIDENTIFIER


SELECT 
	@ColorCode = b.ColorCode,
	@ColorName = b.ColorName
FROM pMaterialCoreColor a  WITH(NOLOCK)
	INNER JOIN dbo.pColorPalette b WITH(NOLOCK) ON b.ColorPaletteID = a.ColorPaletteID
WHERE a.MaterialCoreColorID = @MaterialCoreColorID 


CREATE TABLE #sm(
	ROWID INT IDENTITY ( 1,1), 
	StyleMaterialID UNIQUEIDENTIFIER
)


INSERT INTO  #sm (StyleMaterialID) 
SELECT DISTINCT b.StyleMaterialID
FROM dbo.pStyleMaterials a WITH(NOLOCK)
	INNER JOIN pStyleColorwayItem b WITH(NOLOCK) ON a.StyleMaterialID = b.StyleMaterialID
	INNER JOIN pStyleColorway c WITH(NOLOCK) ON c.StyleColorID =  b.StyleColorID 
	INNER JOIN pColorPalette d WITH(NOLOCK) ON d.ColorPaletteID = c.ColorPaletteID 
WHERE MaterialCoreItemID IS NOT NULL 
	AND d.ColorCode = @ColorCode  
	AND d.ColorName = @ColorName
	AND a.MaterialCoreItemID = @MaterialCoreItemID
	


SELECT @TOTAL  = COUNT(*) FROM #sm
SET @ROWID = 1 

WHILE @ROWID <= @TOTAL 
BEGIN 

	SELECT @StyleMaterialID = StyleMaterialID FROM #sm WHERE ROWID = @ROWID
	
	EXECUTE dbo.spx_StyleMaterialCoreItem_Logic_UPDATE 
		@StyleMaterialID = @StyleMaterialID,
		@MaterialCoreItemID = @MaterialCoreItemID,
		@MUser = @MUser,
		@MDate = @MDate
	
	SET @ROWID = @ROWID	+ 1 

END




