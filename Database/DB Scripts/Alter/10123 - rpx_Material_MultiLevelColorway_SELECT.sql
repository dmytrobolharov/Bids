IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Material_MultiLevelColorway_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Material_MultiLevelColorway_SELECT]
GO

CREATE    PROCEDURE [dbo].[rpx_Material_MultiLevelColorway_SELECT]
(
	@MaterialID nvarchar(255)
)

AS


--Show the colors of the material and sub-materials for the material.
SELECT	pMaterial.MaterialNo + ' - ' + pMaterial.MaterialName AS ParentMaterialName,
	'(' + pMaterialColor.ColorCode + ') ' + pMaterialColor.ColorName AS ParentMaterialColorChipName,
	dbo.fnx_GetStreamingColorImagePath(pMaterialColor.ColorFolderID, pMaterialColor.ColorPaletteID, '100') AS ParentMaterialColorChipFilePath,	
	pMaterial_Subs.MaterialNo + ' - ' + pMaterial_Subs.MaterialName AS SubMaterialName,
	'(' + pMaterialColor_Subs.ColorCode + ') ' + pMaterialColor_Subs.ColorName AS SubMaterialColorChipName,
	dbo.fnx_GetStreamingColorImagePath(pMaterialColor_Subs.ColorFolderID, pMaterialColor_Subs.ColorPaletteID, '100') AS SubMaterialColorChipFilePath,	
	CAST(pMaterialLinkColorwayItem.MaterialLinkID AS nvarchar(50)) AS MaterialLinkID
FROM	pMaterial
	LEFT OUTER JOIN	pMaterialColor	ON	pMaterial.MaterialID = pMaterialColor.MaterialID
 	LEFT OUTER JOIN	pMaterialLinkColorway	ON	(pMaterial.MaterialID = pMaterialLinkColorway.MaterialGroupID
												AND pMaterialColor.MaterialColorID = pMaterialLinkColorway.MaterialColorID)
	LEFT OUTER JOIN	pMaterialLinkColorwayItem	ON	pMaterialLinkColorway.MaterialLinkColorwayID = pMaterialLinkColorwayItem.MaterialLinkColorwayID
 	LEFT OUTER JOIN	pMaterial AS pMaterial_Subs	ON	pMaterialLinkColorwayItem.MaterialID = pMaterial_Subs.MaterialID
 	LEFT OUTER JOIN	pMaterialColor AS pMaterialColor_Subs	ON	(pMaterialLinkColorwayItem.MaterialID = pMaterialColor_Subs.MaterialID
																AND	pMaterialLinkColorwayItem.MaterialColorID = pMaterialColor_Subs.MaterialColorID)
WHERE	(pMaterial.MaterialID = @MaterialID
		AND	pMaterial.MultiDimension = 1)
ORDER BY	pMaterialColor.Sort, pMaterialColor.ColorCode, pMaterialColor.ColorName, pMaterial_Subs.MaterialNo, pMaterial_Subs.MaterialName


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10123', GetUTCDate())
GO