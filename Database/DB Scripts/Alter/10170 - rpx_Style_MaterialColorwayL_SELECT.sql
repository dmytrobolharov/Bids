IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_MaterialColorwayL_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_MaterialColorwayL_SELECT]
GO

CREATE   PROCEDURE [dbo].[rpx_Style_MaterialColorwayL_SELECT]  
(
	@StyleID AS nvarchar(50), 	
	@StyleSet AS int
)
AS


--Create temp table.
CREATE TABLE #tempTable
(
	TableRow int identity(0,1),
	MaterialDescription nvarchar(255),
	StyleMaterialId nvarchar(50),
	Placement nvarchar(1000),
	MainColor nvarchar(255),
	Qty nvarchar(18),
	MaterialSize nvarchar(200),
	ColorName nvarchar(150),
	ColorCode nvarchar(50),
	FilePath nvarchar(255),
	MaterialColorNote nvarchar(1000),
	MaterialColorImageID nvarchar(50),
	MaterialColorImageVersion int
)


--Get the material colorway squares and put them in the temp table.
INSERT INTO #tempTable(
	MaterialDescription,
	StyleMaterialId,
	Placement,
	MainColor,
	Qty,
	MaterialSize,
	ColorName,
	ColorCode,
	FilePath,
	MaterialColorNote,
	MaterialColorImageID,
	MaterialColorImageVersion)
SELECT
	('(' + pStyleMaterials.MaterialNo + ') ' + pStyleMaterials.MaterialName) AS MaterialDescription, 
	CAST(pStyleMaterials.StyleMaterialId AS nvarchar(50)) AS StyleMaterialId,
	pStyleMaterials.Placement, 
	isnull('(' + pStyleColorway.StyleColorNo + ') ','') +  pStyleColorway.MainColor AS MainColor,
	pStyleMaterials.Qty,
	pStyleMaterials.MaterialSize,
	pMaterialColor.ColorName,
	pMaterialColor.ColorCode,
	dbo.fnx_GetStreamingColorImagePath(pMaterialColor.ColorFolderID, pMaterialColor.ColorPaletteID, '100') AS FilePath,	
	pMaterialColor.MaterialColorNote,
	pMaterialColor.MaterialColorImageID,
	pMaterialColor.MaterialColorImageVersion
FROM pStyleColorway WITH (NOLOCK) LEFT OUTER JOIN pStyleMaterials WITH (NOLOCK) ON
pStyleColorway.StyleID = pStyleMaterials.StyleID AND		
pStyleMaterials.Colorway = '1' LEFT OUTER JOIN pStyleColorwayItem WITH (NOLOCK) ON
pStyleMaterials.StyleMaterialID = pStyleColorwayItem.StyleMaterialID AND
pStyleColorway.StyleColorID = pStyleColorwayItem.StyleColorID LEFT OUTER JOIN pMaterialColor WITH (NOLOCK) ON
pStyleColorwayItem.MaterialColorID = pMaterialColor.MaterialColorID
WHERE pStyleMaterials.StyleID = @StyleID AND pStyleMaterials.StyleSet = @StyleSet		
ORDER BY pStyleColorway.Sort, pStyleColorway.StyleColorName, pStyleColorway.StyleColorID,
pStyleMaterials.MainMaterial DESC, pStyleMaterials.MaterialType,
pStyleMaterials.MaterialSort, pStyleMaterials.MaterialNo

--Update the temp folder for the chips that are images from the Image folder.
UPDATE #tempTable
SET FilePath = dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version], 2000),	
	ColorName = '(' + hImage.ImageNo + ')'
FROM #tempTable
	INNER JOIN hImage WITH (NOLOCK) ON	(#tempTable.MaterialColorImageID = hImage.ImageID
							AND #tempTable.MaterialColorImageVersion = hImage.Version)


--Update the temp table to include the "Die To Match (DTM)" feature request.
UPDATE #tempTable
SET ColorCode = 'DTM'
WHERE (ColorName IS NULL)
	AND (ColorCode IS NULL)
	AND (FilePath IS NULL)


--Get the desired columns from the original temp table.
SELECT
	TableRow % 3 AS [Column],
	MaterialDescription, 
	StyleMaterialId,
	Placement, 
	MainColor,
	Qty,
	MaterialSize,
	ColorName,
	ColorCode,
	FilePath,
	MaterialColorNote
FROM #tempTable

--Drop the Temp Table.
DROP TABLE #tempTable


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10170', GetUTCDate())
GO