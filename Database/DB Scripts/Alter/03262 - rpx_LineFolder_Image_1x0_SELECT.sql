IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_LineFolder_Image_1x0_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_LineFolder_Image_1x0_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_LineFolder_Image_1x0_SELECT]
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
	st.StyleTypeDescription AS StyleTypeDescription
INTO	#TblTemp 
FROM         pLineFolderItem fi
	LEFT OUTER JOIN pStyleHeader sh ON fi.StyleID = sh.StyleID
	LEFT OUTER JOIN hImage hi ON	sh.DesignSketchID = hi.ImageID
									AND sh.DesignSketchVersion = hi.Version
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
	StyleTypeDescription
FROM #TblTemp

DROP TABLE #TblTemp
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03262', GetDate())
GO