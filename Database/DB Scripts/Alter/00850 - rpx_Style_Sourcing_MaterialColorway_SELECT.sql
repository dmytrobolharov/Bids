/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.

#02 - Ryan Cabanas - September 23, 2009
	Replace the old color image string with the new color image string using function.
Deleted old code.
*/


ALTER      PROCEDURE [dbo].[rpx_Style_Sourcing_MaterialColorway_SELECT]
(
	@StyleMaterialID nvarchar(255)
)

AS

-- --Test values
-- DECLARE @StyleMaterialID nvarchar(255)
-- SET @StyleMaterialID = '3b810db7-ed87-4a09-bc04-23e6bfc06bf8'


--Temp tables
CREATE TABLE #tempMaterials(
	ParentMaterialName varchar(100)
	,ParentMaterialColorChipName varchar(100)
	,ParentMaterialColorChipFilePath varchar(255)
	,SubMaterialName varchar(100)
	,SubMaterialColorChipName varchar(100)
	,SubMaterialColorChipFilePath varchar(255)
	,MaterialLinkID varchar(50)
	,ParentMaterialColorImageID varchar(50)
	,ParentMaterialColorImageVersion int
	,SubMaterialColorImageID varchar(50)
	,SubMaterialColorImageVersion int
)


--Get all materials for the style
INSERT INTO #tempMaterials(
	ParentMaterialName
	,ParentMaterialColorChipName
	,ParentMaterialColorChipFilePath
	,SubMaterialName
	,SubMaterialColorChipName
	,SubMaterialColorChipFilePath
	,MaterialLinkID
	,ParentMaterialColorImageID
	,ParentMaterialColorImageVersion
	,SubMaterialColorImageID
	,SubMaterialColorImageVersion
)
SELECT	pStyleMaterials.MaterialNo + ' - ' + pStyleMaterials.MaterialName AS ParentMaterialName,
	'(' + pMaterialColor.ColorCode + ') ' + pMaterialColor.ColorName AS ParentMaterialColorChipName,
	dbo.fnx_GetStreamingColorImagePath(pMaterialColor.ColorFolderID, pMaterialColor.ColorPaletteID) AS ParentMaterialColorChipFilePath,	--Comment #02
	pMaterial_Subs.MaterialNo + ' - ' + pMaterial_Subs.MaterialName AS SubMaterialName,
	'(' + pMaterialColor_Subs.ColorCode + ') ' + pMaterialColor_Subs.ColorName AS SubMaterialColorChipName,
	dbo.fnx_GetStreamingColorImagePath(pMaterialColor_Subs.ColorFolderID, pMaterialColor_Subs.ColorPaletteID) AS SubMaterialColorChipFilePath,	--Comment #02
	CAST(pMaterialLink.MaterialLinkID AS varchar(50)) AS MaterialLinkID,
	pMaterialColor.MaterialColorImageID AS ParentMaterialColorImageID,
	pMaterialColor.MaterialColorImageVersion AS ParentMaterialColorImageVersion,
	pMaterialColor_Subs.MaterialColorImageID AS SubMaterialColorImageID,
	pMaterialColor_Subs.MaterialColorImageVersion AS SubMaterialColorImageVersion
FROM	pStyleMaterials
	INNER JOIN pMaterial ON	pStyleMaterials.MaterialID = pMaterial.MaterialID
	INNER JOIN pStyleColorwayItem ON	pStyleMaterials.StyleMaterialID = pStyleColorwayItem.StyleMaterialID
	INNER JOIN pMaterialColor ON	pStyleColorwayItem.MaterialColorID = pMaterialColor.MaterialColorID
	INNER JOIN pStyleColorway ON	pStyleColorwayItem.StyleColorID = pStyleColorway.StyleColorID
	INNER JOIN pMaterialLink ON	pStyleMaterials.MaterialID = pMaterialLink.MaterialGroupID
	INNER JOIN pMaterial AS pMaterial_Subs ON	pMaterialLink.MaterialID = pMaterial_Subs.MaterialID
	INNER JOIN pMaterialLinkColorway ON	(pStyleColorwayItem.MaterialID = pMaterialLinkColorway.MaterialGroupID
										AND	pStyleColorwayItem.MaterialColorID = pMaterialLinkColorway.MaterialColorID)
	INNER JOIN pMaterialLinkColorwayItem ON	(pMaterialLinkColorway.MaterialLinkColorwayID = pMaterialLinkColorwayItem.MaterialLinkColorwayID
											AND	pMaterial_Subs.MaterialID = pMaterialLinkColorwayItem.MaterialID
											AND pMaterialLink.MaterialLinkID = pMaterialLinkColorwayItem.MaterialLinkID)
	LEFT OUTER JOIN pMaterialColor AS pMaterialColor_Subs ON	pMaterialLinkColorwayItem.MaterialColorID = pMaterialColor_Subs.MaterialColorID
WHERE	(pStyleMaterials.StyleMaterialID = @StyleMaterialID)
	AND	(pStyleMaterials.Colorway = 1 )
	AND	(pMaterial.MultiDimension = 1)
ORDER BY	pStyleColorway.Sort,
	pStyleColorway.MainColor,
	pMaterial_Subs.MaterialType,
	pMaterial_Subs.MaterialNo,
	pMaterial_Subs.MaterialName

--Update the temp table for the Parent Material chips that are images from the Image folder.
UPDATE #tempMaterials
SET ParentMaterialColorChipFilePath = dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version])	--Comment #01
FROM #tempMaterials
	INNER JOIN hImage ON	(#tempMaterials.ParentMaterialColorImageID = hImage.ImageID
							AND #tempMaterials.ParentMaterialColorImageVersion = hImage.Version)

--Update the temp table for the Sub Material chips that are images from the Image folder.
UPDATE #tempMaterials
SET SubMaterialColorChipFilePath = dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version])	--Comment #01
FROM #tempMaterials
	INNER JOIN hImage ON	(#tempMaterials.SubMaterialColorImageID = hImage.ImageID
							AND #tempMaterials.SubMaterialColorImageVersion = hImage.Version)

--SELECT the records
SELECT
	ParentMaterialName
	,ParentMaterialColorChipName
	,ParentMaterialColorChipFilePath
	,SubMaterialName
	,SubMaterialColorChipName
	,SubMaterialColorChipFilePath
	,MaterialLinkID
	,*
FROM #tempMaterials

--Drop temp tables
DROP TABLE #tempMaterials
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '850', GetDate())
GO