-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 16 May 2012                                                                              */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
/****** Object:  StoredProcedure [dbo].[spx_StyleColorwayItems_AutoColorLogic_UPDATE]    Script Date: 05/16/2012 12:14:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwayItems_AutoColorLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorwayItems_AutoColorLogic_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleColorwayItems_AutoColorLogic_UPDATE]    Script Date: 05/16/2012 12:14:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Comment #01 - Clayton Parker Dec 16 2009
	Burberry requested that the main material auto selection only pull through colors by ColorCode
	and not ColorName. I disabled the ColorName match.
*/

CREATE PROCEDURE [dbo].[spx_StyleColorwayItems_AutoColorLogic_UPDATE] (
@StyleID UNIQUEIDENTIFIER,
@StyleSet INT, 
@SeasonYearID UNIQUEIDENTIFIER,
@MUser NVARCHAR(200),
@MDate DATETIME
)
AS 



CREATE TABLE #sc(
ROW_ID INT IDENTITY(1,1),
StyleColorID UNIQUEIDENTIFIER,
ColorPaletteID UNIQUEIDENTIFIER,
ColorName NVARCHAR(200),
ColorCode NVARCHAR(200)
)

CREATE TABLE #mat (
ROW_ID INT IDENTITY(1,1),
StyleMaterialID UNIQUEIDENTIFIER,
MaterialID UNIQUEIDENTIFIER,
MainMaterial INT
)

INSERT INTO  #mat( StyleMaterialID, MaterialID, MainMaterial ) 
SELECT a.StyleMaterialID, a.MaterialID, a.MainMaterial  
FROM pStyleMaterials a
WHERE a.StyleID = @StyleID
AND a.StyleSet =  @StyleSet

INSERT INTO #sc (StyleColorID, ColorPaletteID, ColorName, ColorCode)
SELECT c.StyleColorID ,c.ColorPaletteID , d.ColorName, d.ColorCode
FROM pStyleColorwaySeasonYear a
INNER JOIN pStyleSeasonYear b ON a.StyleSeasonYearID = b.StyleSeasonYearID 
INNER JOIN pStyleColorway c ON a.StyleColorwayID = c.StyleColorID 
INNER JOIN pColorPalette d ON d.ColorPaletteID =  c.ColorPaletteID
WHERE b.StyleID = @StyleID
AND b.SeasonYearID = @SeasonYearID



DECLARE @TOTAL_M INT
DECLARE @ROW_M INT
DECLARE @TOTAL_C INT
DECLARE @ROW_C INT

DECLARE @StyleMaterialID UNIQUEIDENTIFIER
DECLARE @MaterialID UNIQUEIDENTIFIER
DECLARE @MainMaterial INT 
DECLARE @MaterialColorID UNIQUEIDENTIFIER
DECLARE @StyleColorID UNIQUEIDENTIFIER
DECLARE @ColorPaletteID UNIQUEIDENTIFIER
DECLARE @ColorName NVARCHAR(200)
DECLARE @ColorCode NVARCHAR(200)


SELECT @TOTAL_M = COUNT(*) FROM #mat
SET @ROW_M = 1 

WHILE @ROW_M <= @TOTAL_M
BEGIN

	SELECT @StyleMaterialID = StyleMaterialID, @MaterialID = MaterialID, @MainMaterial  = MainMaterial 
	FROM #mat WHERE ROW_ID = @ROW_M
	
	
	SELECT @TOTAL_C = COUNT(*) FROM #sc
	SET @ROW_C = 1 
	
	WHILE @ROW_C <= @TOTAL_C 
	BEGIN
	
		SELECT @StyleColorID = StyleColorID, @ColorPaletteID = ColorPaletteID, 
		@ColorName = ColorName, @ColorCode = ColorCode FROM #sc WHERE ROW_ID = @ROW_C
		
		SET @MaterialColorID = NULL 
		
		SELECT @MaterialColorID = MaterialColorID FROM pStyleColorwayItem 
		WHERE StyleMaterialID = @StyleMaterialID 
		AND StyleColorID = @StyleColorID
		AND StyleSet = @StyleSet  

		
				
		IF @MaterialColorID IS NULL 
		BEGIN 

			
			IF @MainMaterial =  1 
			BEGIN
				/**
				** Asign colorchips to the main material
				**/
				SELECT @MaterialColorID = a.MaterialColorID
				FROM pMaterialColor a
				INNER JOIN pColorPalette b ON a.ColorPaletteID = b.ColorPaletteID 
				INNER JOIN pMaterialColorSeasonYear c ON c.MaterialColorID = a.MaterialColorID
				WHERE a.MaterialID = @MaterialID
				AND b.ColorCode = @ColorCode
				--AND b.ColorName = @ColorName				-- Comment #01 
				AND c.SeasonYearID = @SeasonYearID
			END  
			ELSE
			BEGIN
				/**
				** No main material
				**/

				IF ( SELECT COUNT(*) FROM pMaterialColorSeasonYear WHERE MaterialID = @MaterialID AND SeasonYearID = @SeasonYearID ) > 0
				BEGIN
					/**
					** For No main Material it will pick any Colorchip for that seasonYear
					This change work for non materials having one colorchip and for multiple colorchips as well.
					**/
					SELECT @MaterialColorID = MaterialColorID 
					FROM pMaterialColorSeasonYear 
					WHERE MaterialID = @MaterialID 
					AND SeasonYearID = @SeasonYearID
				END
				
			END 
							
			IF @MaterialColorID  IS NOT NULL
			BEGIN
			
				UPDATE pStyleColorwayItem  
				SET MaterialColorID = @MaterialColorID, MUser = @MUser, MDate =  @MDate
				WHERE StyleMaterialID = @StyleMaterialID 
				AND StyleColorID = @StyleColorID
				AND StyleSet = @StyleSet  
			END 
	
		END
		
		SET @ROW_C = @ROW_C + 1
	END
	SET @ROW_M= @ROW_M + 1 
END 


DROP TABLE #sc
DROP TABLE #mat 

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03460', GetDate())
	
GO



