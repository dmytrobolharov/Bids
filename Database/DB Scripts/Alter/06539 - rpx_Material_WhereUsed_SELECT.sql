IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Material_WhereUsed_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Material_WhereUsed_SELECT]
GO
CREATE PROCEDURE [dbo].[rpx_Material_WhereUsed_SELECT] (@Season NVARCHAR(100) = NULL, @Year NVARCHAR(100) = NULL, @ShowImage NVARCHAR(50) = NULL, @MaterialNo NVARCHAR(50) = NULL, @MaterialType NVARCHAR(200) = NULL, @MaterialName NVARCHAR(200) = NULL)
AS
/************/
/*Logic.	*/
/************/
/*Prep parameters for the WHERE conditions.*/
IF (@Season IS NULL OR @Season = '')
BEGIN
	SET @Season = '(ALL)'
END

IF (@Year IS NULL OR @Year = '')
BEGIN
	SET @Year = '(ALL)'
END

IF (@ShowImage IS NULL OR @ShowImage = '')
BEGIN
	SET @ShowImage = 'No'
END

IF (@MaterialNo IS NULL OR @MaterialNo = '')
BEGIN
	SET @MaterialNo = '(ALL)'
END

IF (@MaterialType IS NULL OR @MaterialType = '')
BEGIN
	SET @MaterialType = '(ALL)'
END

IF (@MaterialName IS NULL OR @MaterialName = '')
BEGIN
	SET @MaterialName = '(ALL)'
END

/*SELECT statements, with or without image.*/
IF (@ShowImage = 'Yes')
BEGIN
	SELECT sy.Season AS Season, sy.year AS [Year], (
			SELECT TOP 1 dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version])
			FROM pStyleHeader
			LEFT OUTER JOIN hImage ON pStyleHeader.DesignSketchID = hImage.ImageID AND pStyleHeader.DesignSketchVersion = hImage.Version
			WHERE pStyleHeader.StyleID = s.StyleID
			) AS FilePath, m.MaterialNo AS MaterialsCode, m.MaterialName, m.Q AS VendorMill, m.R AS VendorMillRefNO, m.B AS Content, m.E AS Construction, m.F AS YarnSizeCount, m.D AS Weight, UOM.UOM, xc.Custom AS STATUS, CAST(s.QTY AS DECIMAL(18, 4)) AS Quantity, s.Placement, t.ComponentDescription AS [MaterialType], h.StyleNo, h.[Description], h.STYLENO AS StylesWhereUsed, h.SizeClass, 1 AS GrandTotalGroup --- only to get the entire row group for grand total of the record count
	FROM pMaterial m WITH (NOLOCK)
	INNER JOIN pStyleMaterials s WITH (NOLOCK) ON m.MaterialID = s.MaterialID
	LEFT OUTER JOIN pComponentType t WITH (NOLOCK) ON m.MaterialType = t.ComponentTypeID
	LEFT OUTER JOIN pStyleHeader h WITH (NOLOCK) ON s.StyleID = h.StyleID
	INNER JOIN pMaterialSeasonYear msy ON m.MaterialID = msy.MaterialID
	INNER JOIN pSeasonYear sy ON msy.SeasonYearID = sy.SeasonYearID
	LEFT OUTER JOIN xCustom8 xc ON m.S = xc.CustomKey
	LEFT OUTER JOIN UOM ON m.UOM = UOM.UOMValue
	WHERE m.MaterialNo IS NOT NULL AND m.MaterialNo <> '' AND ((sy.Season = @Season) OR (@Season = '(ALL)')) AND ((sy.Year = @Year) OR (@Year = '(ALL)')) AND ((LTRIM(RTRIM(m.MaterialNo)) = LTRIM(RTRIM(@MaterialNo))) OR (@MaterialNo = '(ALL)')) AND ((LTRIM(RTRIM(t.ComponentDescription)) = LTRIM(RTRIM(@MaterialType))) OR (@MaterialType = '(ALL)')) AND ((LTRIM(RTRIM(m.MaterialName)) = LTRIM(RTRIM(@MaterialName))) OR (@MaterialName = '(ALL)'))
	
	UNION
	
	SELECT sy.Season AS Season, sy.year AS [Year], (
			SELECT TOP 1 dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version])
			FROM pStyleHeader
			LEFT OUTER JOIN hImage ON pStyleHeader.DesignSketchID = hImage.ImageID AND pStyleHeader.DesignSketchVersion = hImage.Version
			WHERE pStyleHeader.StyleID = s.StyleID
			) AS FilePath, m.MaterialNo AS MaterialsCode, m.MaterialName, m.Q AS VendorMill, m.R AS VendorMillRefNO, m.B AS Content, m.E AS Construction, m.F AS YarnSizeCount, m.D AS Weight, UOM.UOM, xc.Custom AS STATUS, CAST(s.QTY AS DECIMAL(18, 4)) AS Quantity, s.Placement, t.ComponentDescription AS [MaterialType], h.StyleNo, h.[Description], h.STYLENO AS StylesWhereUsed, h.SizeClass, 1 AS GrandTotalGroup --- only to get the entire row group for grand total of the record count
	FROM pMaterial m WITH (NOLOCK)
	INNER JOIN pStyleBOM s WITH (NOLOCK) ON m.MaterialID = s.MaterialID
	LEFT OUTER JOIN pComponentType t WITH (NOLOCK) ON m.MaterialType = t.ComponentTypeID
	LEFT OUTER JOIN pStyleHeader h WITH (NOLOCK) ON s.StyleID = h.StyleID
	INNER JOIN pMaterialSeasonYear msy ON m.MaterialID = msy.MaterialID
	INNER JOIN pSeasonYear sy ON msy.SeasonYearID = sy.SeasonYearID
	LEFT OUTER JOIN xCustom8 xc ON m.S = xc.CustomKey
	LEFT OUTER JOIN UOM ON m.UOM = UOM.UOMValue
	WHERE m.MaterialNo IS NOT NULL AND m.MaterialNo <> '' AND ((sy.Season = @Season) OR (@Season = '(ALL)')) AND ((sy.Year = @Year) OR (@Year = '(ALL)')) AND ((LTRIM(RTRIM(m.MaterialNo)) = LTRIM(RTRIM(@MaterialNo))) OR (@MaterialNo = '(ALL)')) AND ((LTRIM(RTRIM(t.ComponentDescription)) = LTRIM(RTRIM(@MaterialType))) OR (@MaterialType = '(ALL)')) AND ((LTRIM(RTRIM(m.MaterialName)) = LTRIM(RTRIM(@MaterialName))) OR (@MaterialName = '(ALL)'))
	ORDER BY t.ComponentDescription, m.MaterialNo, m.MaterialName, h.StyleNo
END
ELSE
BEGIN
	SELECT sy.Season AS Season, sy.year AS [Year], '' AS FilePath, m.MaterialNo AS MaterialsCode, m.MaterialName, m.Q AS VendorMill, m.R AS VendorMillRefNO, m.B AS Content, m.E AS Construction, m.F AS YarnSizeCount, m.D AS Weight, UOM.UOM, xc.Custom AS STATUS, CAST(s.QTY AS DECIMAL(18, 4)) AS Quantity, s.Placement, t.ComponentDescription AS [MaterialType], h.StyleNo, h.[Description], h.STYLENO AS StylesWhereUsed, h.SizeClass, 1 AS GrandTotalGroup --- only to get the entire row group for grand total of the record count
	FROM pMaterial m WITH (NOLOCK)
	INNER JOIN pStyleMaterials s WITH (NOLOCK) ON m.MaterialID = s.MaterialID
	LEFT OUTER JOIN pComponentType t WITH (NOLOCK) ON m.MaterialType = t.ComponentTypeID
	LEFT OUTER JOIN pStyleHeader h WITH (NOLOCK) ON s.StyleID = h.StyleID
	INNER JOIN pMaterialSeasonYear msy ON m.MaterialID = msy.MaterialID
	INNER JOIN pSeasonYear sy ON msy.SeasonYearID = sy.SeasonYearID
	LEFT OUTER JOIN xCustom8 xc ON m.S = xc.CustomKey
	LEFT OUTER JOIN UOM ON m.UOM = UOM.UOMValue
	WHERE m.MaterialNo IS NOT NULL AND m.MaterialNo <> '' AND ((sy.Season = @Season) OR (@Season = '(ALL)')) AND ((sy.Year = @Year) OR (@Year = '(ALL)')) AND ((LTRIM(RTRIM(m.MaterialNo)) = LTRIM(RTRIM(@MaterialNo))) OR (@MaterialNo = '(ALL)')) AND ((LTRIM(RTRIM(t.ComponentDescription)) = LTRIM(RTRIM(@MaterialType))) OR (@MaterialType = '(ALL)')) AND ((LTRIM(RTRIM(m.MaterialName)) = LTRIM(RTRIM(@MaterialName))) OR (@MaterialName = '(ALL)'))
	
	UNION
	
	SELECT sy.Season AS Season, sy.year AS [Year], '' AS FilePath, m.MaterialNo AS MaterialsCode, m.MaterialName, m.Q AS VendorMill, m.R AS VendorMillRefNO, m.B AS Content, m.E AS Construction, m.F AS YarnSizeCount, m.D AS Weight, UOM.UOM, xc.Custom AS STATUS, CAST(s.QTY AS DECIMAL(18, 4)) AS Quantity, s.Placement, t.ComponentDescription AS [MaterialType], h.StyleNo, h.[Description], h.STYLENO AS StylesWhereUsed, h.SizeClass, 1 AS GrandTotalGroup --- only to get the entire row group for grand total of the record count
	FROM pMaterial m WITH (NOLOCK)
	INNER JOIN pStyleBOM s WITH (NOLOCK) ON m.MaterialID = s.MaterialID
	LEFT OUTER JOIN pComponentType t WITH (NOLOCK) ON m.MaterialType = t.ComponentTypeID
	LEFT OUTER JOIN pStyleHeader h WITH (NOLOCK) ON s.StyleID = h.StyleID
	INNER JOIN pMaterialSeasonYear msy ON m.MaterialID = msy.MaterialID
	INNER JOIN pSeasonYear sy ON msy.SeasonYearID = sy.SeasonYearID
	LEFT OUTER JOIN xCustom8 xc ON m.S = xc.CustomKey
	LEFT OUTER JOIN UOM ON m.UOM = UOM.UOMValue
	WHERE m.MaterialNo IS NOT NULL AND m.MaterialNo <> '' AND ((sy.Season = @Season) OR (@Season = '(ALL)')) AND ((sy.Year = @Year) OR (@Year = '(ALL)')) AND ((LTRIM(RTRIM(m.MaterialNo)) = LTRIM(RTRIM(@MaterialNo))) OR (@MaterialNo = '(ALL)')) AND ((LTRIM(RTRIM(t.ComponentDescription)) = LTRIM(RTRIM(@MaterialType))) OR (@MaterialType = '(ALL)')) AND ((LTRIM(RTRIM(m.MaterialName)) = LTRIM(RTRIM(@MaterialName))) OR (@MaterialName = '(ALL)'))
	ORDER BY t.ComponentDescription, m.MaterialNo, m.MaterialName, h.StyleNo
END
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06539', GetDate())
GO
