IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_LineFolder_Image_3x0_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_LineFolder_Image_3x0_SELECT]
GO

CREATE  PROCEDURE [dbo].[rpx_LineFolder_Image_3x0_SELECT]	 
	@LineFolderID AS nvarchar(255)
AS


SELECT
	identity(int,0,1) AS RowNumber,
	fi.LineFolderItemID AS LineFolderItemID, 
	sh.StyleNo,
	sh.StyleType,
	sh.DevelopmentNo,
	COALESCE(scc.Custom, sh.SizeClass) AS SizeClass,
	sc.StyleCategory,
	sh.[Description], 
	sh.MaterialName, 
	(dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version], 2000)) AS FilePath,	--Comment #01
	ch.StyleCostingCustomField23 AS TargetFOB,
	ch.StyleCostingCustomField22 AS TargetLDP, 
	ch.StyleCostingCustomField21 AS TargetWHSL,
	ch.StyleCostingCustomField20 AS TargetMSRP, 
	ch.StyleCostingCustomField24 AS PricingComment,
	st.StyleTypeDescription AS StyleTypeDescription
INTO	#TblTemp 
FROM         pLineFolderItem fi
	LEFT OUTER JOIN pStyleHeader sh ON fi.StyleID = sh.StyleID
	LEFT OUTER JOIN hImage hi ON sh.DesignSketchID = hi.ImageID
		AND sh.DesignSketchVersion = hi.Version
	LEFT OUTER JOIN pStyleCostingHeader ch ON sh.StyleID = ch.StyleID
	LEFT OUTER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
	LEFT OUTER JOIN pStyleType st ON sh.StyleType = st.StyleTypeID
	LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId
WHERE fi.LineFolderID = @LineFolderID
ORDER BY fi.Sort, sh.StyleNo

SELECT
	RowNumber / 3 AS Row,
	RowNumber % 3 AS [Column],
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


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10113', GetUTCDate())
GO