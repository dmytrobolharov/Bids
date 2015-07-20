IF OBJECT_ID(N'[dbo].[rpx_LineFolder_Image_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[rpx_LineFolder_Image_SELECT]
GO

/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.
*/

CREATE  PROCEDURE [dbo].[rpx_LineFolder_Image_SELECT]	 
	@LineFolderID AS nvarchar(255)
AS

--DECLARE @LineFolderID AS varchar(255)
--SET @LineFolderID = '99D3733B-2D08-44D0-8DC5-3417E465181D'

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
	(dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS FilePath,	--Comment #01
	ch.StyleCostingCustomField23 AS TargetFOB,
	ch.StyleCostingCustomField22 AS TargetLDP, 
	ch.StyleCostingCustomField21 AS TargetWHSL,
	ch.StyleCostingCustomField20 AS TargetMSRP, 
	ch.StyleCostingCustomField24 AS PricingComment,
	st.StyleTypeDescription AS StyleTypeDescription
INTO	#TblTemp 
FROM         pLineFolderItem fi
	LEFT OUTER JOIN pStyleHeader sh ON fi.StyleID = sh.StyleID
	LEFT OUTER JOIN hImage hi ON sh.DesignSketchID = hi.ImageID AND sh.DesignSketchVersion = hi.Version
	LEFT OUTER JOIN pStyleCostingHeader ch ON sh.StyleID = ch.StyleID
	LEFT OUTER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
	LEFT OUTER JOIN pStyleType st ON sh.StyleType = st.StyleTypeID
	LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId
WHERE fi.LineFolderID = @LineFolderID 

SELECT
	RowNumber / 6 AS Row,
	RowNumber % 6 AS [Column],
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
VALUES ('DB_Version', '6.1.0000', '09599', GetDate())
GO
