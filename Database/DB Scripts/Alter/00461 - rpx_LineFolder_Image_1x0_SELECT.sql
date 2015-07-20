CREATE  PROCEDURE [dbo].[rpx_LineFolder_Image_1x0_SELECT]
	@LineFolderID AS varchar(255)
AS


SELECT
	identity(int,0,1) AS RowNumber,
	fi.LineFolderItemID AS LineFolderItemID, 
	sh.StyleNo,
	sh.StyleType,
	sh.DevelopmentNo,
	sh.SizeClass,
	sc.StyleCategory,
	sh.[Description], 
	sh.MaterialName, 
	(dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS FilePath,
	ch.StyleCostingCustomField23 AS TargetFOB,
	ch.StyleCostingCustomField22 AS TargetLDP, 
	ch.StyleCostingCustomField21 AS TargetWHSL,
	ch.StyleCostingCustomField20 AS TargetMSRP, 
	ch.StyleCostingCustomField24 AS PricingComment,
	st.StyleTypeDescription AS StyleTypeDescription
INTO	#TblTemp 
FROM         pLineFolderItem fi
	LEFT OUTER JOIN pStyleHeader sh ON fi.StyleID = sh.StyleID
	LEFT OUTER JOIN hImage hi ON	sh.DesignSketchID = hi.ImageID
									AND sh.DesignSketchVersion = hi.Version
	LEFT OUTER JOIN pStyleCostingHeader ch ON sh.StyleID = ch.StyleID
	LEFT OUTER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
	LEFT OUTER JOIN pStyleType st ON sh.StyleType = st.StyleTypeID
WHERE fi.LineFolderID = @LineFolderID 
ORDER BY fi.LineFolderItemSort, sh.StyleNo, sh.[Description]

SELECT
	RowNumber / 1 AS [Row],
	RowNumber % 1 AS [Column],
	LineFolderItemID,
	StyleType,
	DevelopmentNo,
	SizeClass,
	StyleCategory,
	[Description], 
	MaterialName,
	FilePath,
	TargetFOB,
	TargetLDP,
	TargetWHSL,
	TargetMSRP,
	PricingComment,
	StyleTypeDescription
FROM #TblTemp

DROP TABLE #TblTemp