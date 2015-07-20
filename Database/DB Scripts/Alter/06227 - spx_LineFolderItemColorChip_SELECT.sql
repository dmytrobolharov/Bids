-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 21 August 2013                                                                             */
-- *                                                                                            */
-- * Copyright (c) 2002-2013 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS:
--
--
--
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItemColorChip_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_LineFolderItemColorChip_SELECT]
GO

/**************************************************
-- @nOption 	= 0	Select all
		= 1	Select with LineFolderItemColorDrop = 1  (DROPPED)
		= 2	Select with LineFolderItemColorDrop = 0   (ACTIVE)

**************************************************/
CREATE PROCEDURE [dbo].[spx_LineFolderItemColorChip_SELECT]
(
	@LineFolderItemID uniqueidentifier,
	@nOption int = 0 
)
AS

SET NOCOUNT ON

SET @nOption = 0

/*****************************************************
@nColorName 	= 0 COLOR COMBO (Color Combo name.)
				= 1	COLOR NAME (For some reason, this is also the color combo name.)
				= 2 MATERIAL COLOR (The name of the Main Material chip.)
*****************************************************/
DECLARE @nColorName as int 
SET @nColorName = 0


IF @nOption = 1
	BEGIN 
	
			-- DROPPED
			IF @nColorName = 0
			BEGIN
			
				SELECT dbo.pColorPalette.ColorFolderID, dbo.pColorPalette.ColorPaletteID, dbo.pMaterialColor.ColorCode, dbo.pMaterialColor.ColorName, 
					  dbo.pStyleColorway.StyleColorNo, dbo.pStyleColorway.StyleColorName, dbo.pMaterialColor.MaterialColorImageID, 
					  dbo.pMaterialColor.MaterialColorImageVersion
				FROM  dbo.pLineFolderItemColor WITH (NOLOCK) INNER JOIN
					  dbo.pMaterialColor WITH (NOLOCK) INNER JOIN
					  dbo.pStyleColorwayItem WITH (NOLOCK) ON dbo.pMaterialColor.MaterialColorID = dbo.pStyleColorwayItem.MaterialColorID INNER JOIN
					  dbo.pStyleColorway WITH (NOLOCK) ON dbo.pStyleColorwayItem.StyleColorID = dbo.pStyleColorway.StyleColorID ON 
					  dbo.pLineFolderItemColor.StyleColorID = dbo.pStyleColorway.StyleColorID INNER JOIN
					  dbo.pColorPalette ON dbo.pStyleColorway.ColorPaletteID = dbo.pColorPalette.ColorPaletteID
				WHERE (pLineFolderItemColor.LineFolderItemID = @LineFolderItemID) AND (pLineFolderItemColor.LineFolderItemColorDrop = 1)
				ORDER BY pStyleColorway.Sort, pStyleColorway.StyleColorNo, pStyleColorway.StyleColorName
				
				--SELECT  pMaterialColor.ColorFolderID, pMaterialColor.ColorPaletteID, pMaterialColor.ColorCode, pMaterialColor.ColorName, pStyleColorway.StyleColorNo, 
				--	pStyleColorway.StyleColorName, pMaterialColor.MaterialColorImageID, pMaterialColor.MaterialColorImageVersion
				--FROM  pLineFolderItemColor WITH (NOLOCK) INNER JOIN
				--	pMaterialColor WITH (NOLOCK) INNER JOIN
				--	pStyleColorwayItem WITH (NOLOCK) ON pMaterialColor.MaterialColorID = pStyleColorwayItem.MaterialColorID INNER JOIN
				--	pStyleColorway WITH (NOLOCK) ON pStyleColorwayItem.StyleColorID = pStyleColorway.StyleColorID ON 
				--	pLineFolderItemColor.StyleColorID = pStyleColorway.StyleColorID
				--WHERE (pLineFolderItemColor.LineFolderItemID = @LineFolderItemID) AND (pLineFolderItemColor.LineFolderItemColorDrop = 1)
				--ORDER BY pStyleColorway.Sort, pStyleColorway.StyleColorNo, pStyleColorway.StyleColorName
			END	
			ELSE
			BEGIN
				SELECT  pMaterialColor.ColorFolderID, pMaterialColor.ColorPaletteID, pMaterialColor.ColorCode, pMaterialColor.ColorName, pStyleColorway.StyleColorNo, 
					pStyleColorway.StyleColorName, pMaterialColor.MaterialColorImageID ,  pMaterialColor.MaterialColorImageVersion
				FROM pStyleColorwayItem WITH (NOLOCK) INNER JOIN
					pMaterialColor WITH (NOLOCK) ON pStyleColorwayItem.MaterialColorID = pMaterialColor.MaterialColorID INNER JOIN
					pStyleColorway WITH (NOLOCK) ON pStyleColorwayItem.StyleColorID = pStyleColorway.StyleColorID INNER JOIN
					pLineFolderItemColor WITH (NOLOCK) ON pStyleColorway.StyleColorID = pLineFolderItemColor.StyleColorID INNER JOIN
					pStyleMaterials WITH (NOLOCK) ON pStyleColorwayItem.StyleMaterialID = pStyleMaterials.StyleMaterialID
				WHERE (pStyleMaterials.MainMaterial = 1) AND (pLineFolderItemColor.LineFolderItemID = @LineFolderItemID)
				AND  pLineFolderItemColor.LineFolderItemColorDrop =  1
				ORDER BY pStyleColorway.Sort, pStyleColorway.StyleColorNo, pStyleColorway.StyleColorName
			END
	END 
ELSE  IF @nOption = 2 
	BEGIN 
		-- ACTIVE 
		DECLARE @MaterialID  as uniqueidentifier 
		DECLARE @StyleMaterialID  as uniqueidentifier 
		
		SELECT TOP 1 @MaterialID =  pStyleColorwayItem.MaterialID , @StyleMaterialID =  pStyleMaterials.StyleMaterialID
		FROM pLineFolderItemColor WITH (NOLOCK) INNER JOIN
			pStyleColorway WITH (NOLOCK) ON pLineFolderItemColor.StyleColorID = pStyleColorway.StyleColorID INNER JOIN
			pStyleColorwayItem WITH (NOLOCK) ON pStyleColorway.StyleColorID = pStyleColorwayItem.StyleColorID INNER JOIN
			pStyleMaterials WITH (NOLOCK) ON pStyleColorwayItem.StyleMaterialID = pStyleMaterials.StyleMaterialID
		WHERE (pLineFolderItemColor.LineFolderItemID = @LineFolderItemID) AND (pLineFolderItemColor.LineFolderItemColorDrop <> 1)
		ORDER BY pStyleMaterials.MainMaterial DESC			
				
		--SELECT @MaterialID as MATERIAL 
			
		IF   @MaterialID is not null 
			BEGIN 
				select '1' AS One,  c.MainMaterial , a.StyleColorID, a.StyleID,
				b.StyleColorNo, b.StyleColorName,  b.MainColor ,   d.MaterialID , d.MaterialColorID,
		
				Case c.MainMaterial 
					WHEN 0 THEN NULL
					WHEN 1 THEN 
						CASE @nColorName 
							WHEN 0 THEN 	NULL
							ELSE e.ColorCode
						END 
				END as ColorCode ,
		
				CASE @nColorName
					WHEN 0 THEN b.MainColor
					WHEN 1 THEN b.StyleColorName 
					WHEN 2 THEN e.ColorName 
				END as ColorName, 
		
				Case c.MainMaterial 
					WHEN 0 THEN NULL 
					WHEN 1 THEN pColorPalette.ColorFolderID 
				END as ColorFolderID ,
				Case c.MainMaterial 
					WHEN 0 THEN NULL
					WHEN 1 THEN pColorPalette.ColorPaletteID
				END as ColorPaletteID , 
				Case c.MainMaterial 
					WHEN 0 THEN NULL
					WHEN 1 THEN e.MaterialColorImageID 
				END as MaterialColorImageID  , 			
				Case c.MainMaterial 
					WHEN 0 THEN NULL
					WHEN 1 THEN e.MaterialColorImageVersion
				END as MaterialColorImageVersion
		  
				FROM         dbo.pColorPalette INNER JOIN
					  dbo.pStyleColorwayItem AS d WITH (NOLOCK) INNER JOIN
					  dbo.pLineFolderItemColor AS a WITH (NOLOCK) INNER JOIN
					  dbo.pStyleColorway AS b WITH (NOLOCK) ON a.StyleColorID = b.StyleColorID AND a.StyleID = b.StyleID INNER JOIN
					  dbo.pStyleMaterials AS c WITH (NOLOCK) ON b.StyleID = c.StyleID ON d.StyleMaterialID = c.StyleMaterialID AND d.StyleColorID = a.StyleColorID ON 
					  dbo.pColorPalette.ColorPaletteID = b.ColorPaletteID LEFT OUTER JOIN
					  dbo.pMaterialColor AS e WITH (NOLOCK) ON d.MaterialColorID = e.MaterialColorID
		
				WHERE     (a.LineFolderItemID = @LineFolderItemId) AND 
				a.LineFolderItemColorDrop <> 1 AND 
				(d.MaterialID = @MaterialID) AND 
				(c.StyleMaterialID = @StyleMaterialID)
				ORDER BY b.Sort, b.StyleColorName, b.StyleColorID               

			END
		ELSE
			BEGIN		
				IF  ( select  count(*) 
				from pStyleColorWay a WITH (NOLOCK), pLinefolderItemColor   b WITH (NOLOCK) 
				where b.LineFolderItemId   = @LineFolderItemId 
				AND a.StyleId = b.StyleID 
				AND (b.LineFolderItemColorDrop = 0 OR b.LineFolderItemColorDrop IS NULL)
				and a.StyleColorId = b.StyleColorID  ) > 0 
					select  NULL AS  MainMaterial, NULL AS  StyleColorID, NULL AS StyleID ,
					NULL AS  StyleColorNo,  NULL AS StyleColorName,  NULL AS MainColor ,  NULL AS MaterialID , 
					NULL AS MaterialColorID, a.MainColor AS ColorCode , NULL AS ColorName , NULL AS ColorFolderID ,
					NULL AS  ColorPaletteID ,   
					NULL AS MaterialColorImageID ,  NULL AS MaterialColorImageVersion
					FROM pStyleColorWay a WITH (NOLOCK), pLinefolderItemColor   b WITH (NOLOCK) 
					where b.LineFolderItemId   = @LineFolderItemId
					AND A.StyleId = b.StyleID 
					and a.StyleColorId = b.StyleColorID 
					AND (b.LineFolderItemColorDrop = 0 OR b.LineFolderItemColorDrop IS NULL)	
		
			END 
	
	END
ELSE --@nOption = NULL
	BEGIN 
		-- ALL
		IF @nColorName = 0
			BEGIN
				--SELECT dbo.pColorPalette.ColorFolderID, dbo.pColorPalette.ColorPaletteID, dbo.pColorPalette.ColorCode, dbo.pColorPalette.ColorName, 
				--  dbo.pStyleColorway.StyleColorNo, dbo.pStyleColorway.StyleColorName, NULL AS MaterialColorImageID, 
				-- NULL AS MaterialColorImageVersion
				--FROM  dbo.pStyleColorway WITH (NOLOCK) INNER JOIN
                --      dbo.pLineFolderItemColor WITH (NOLOCK) ON dbo.pStyleColorway.StyleColorID = dbo.pLineFolderItemColor.StyleColorID INNER JOIN
                --      dbo.pColorPalette ON dbo.pStyleColorway.ColorPaletteID = dbo.pColorPalette.ColorPaletteID
				SELECT * FROM vwx_LineFolderItemColorChip_SEL
				WHERE (LineFolderItemID = @LineFolderItemID) 
				ORDER BY Sort, StyleColorNo, StyleColorName
			END	
		ELSE
			BEGIN
				--SELECT dbo.pColorPalette.ColorFolderID, dbo.pColorPalette.ColorPaletteID, dbo.pColorPalette.ColorCode, dbo.pColorPalette.ColorName, 
				--  dbo.pStyleColorway.StyleColorNo, dbo.pStyleColorway.StyleColorName, NULL AS MaterialColorImageID, 
				-- NULL AS MaterialColorImageVersion
				--FROM  dbo.pStyleColorway WITH (NOLOCK) INNER JOIN
                --      dbo.pLineFolderItemColor WITH (NOLOCK) ON dbo.pStyleColorway.StyleColorID = dbo.pLineFolderItemColor.StyleColorID INNER JOIN
                --      dbo.pColorPalette ON dbo.pStyleColorway.ColorPaletteID = dbo.pColorPalette.ColorPaletteID
				SELECT * FROM vwx_LineFolderItemColorChip_SEL
				WHERE (LineFolderItemID = @LineFolderItemID) 
				ORDER BY Sort, StyleColorNo, StyleColorName
			END
	END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06227', GetDate())
GO
