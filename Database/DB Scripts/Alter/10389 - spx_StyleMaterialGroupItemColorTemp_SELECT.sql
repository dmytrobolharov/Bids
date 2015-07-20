IF OBJECT_ID(N'[dbo].[spx_StyleMaterialGroupItemColorTemp_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleMaterialGroupItemColorTemp_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleMaterialGroupItemColorTemp_SELECT](
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@MaterialCoreID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@CDate DATETIME
)
AS


INSERT INTO pStyleMaterialGroupItemColorTemp (StyleMaterialGroupItemColorTempID,MaterialCoreID , 
StyleColorID, StyleID, TeamID, MaterialCoreColorID)
SELECT NEWID(), @MaterialCoreID AS MaterialCoreID , 
a.StyleColorID, a.StyleID, @TeamID AS TeamID, b.MaterialCoreColorID
FROM pStylecolorway a WITH(NOLOCK)
	LEFT OUTER JOIN pStyleMaterialGroupItemColorTemp b WITH(NOLOCK) ON a.StyleColorID =  b.StyleColorID
		AND b.TeamID = @TeamID
		AND b.MaterialCoreID = @MaterialCoreID
WHERE a.StyleID = @StyleID
AND a.StyleSet = @StyleSet
AND b.StyleMaterialGroupItemColorTempID IS NULL


SELECT dbo.fnx_GetStreamingColorImageHTML(c.ColorFolderID, c.ColorPaletteID, 20, '') AS ColorUrl, 
       c.ColorCode , c.ColorName,	* 
FROM pStyleMaterialGroupItemColorTemp a WITH(NOLOCK)
	INNER JOIN dbo.pStyleColorway b ON a.StyleColorID =  b.StyleColorID 
	INNER JOIN dbo.pColorPalette c ON c.ColorPaletteID = b.ColorPaletteID
WHERE a.StyleID = @StyleID AND a.MaterialCoreID = @MaterialCoreID 
AND a.TeamID =  @TeamID 
ORDER BY c.ColorName


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10389', GetUTCDate())
GO
