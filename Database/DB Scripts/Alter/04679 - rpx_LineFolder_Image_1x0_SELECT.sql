IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_LineFolder_Image_1x0_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_LineFolder_Image_1x0_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[rpx_LineFolder_Image_1x0_SELECT]
	@LineFolderID AS varchar(255)
AS


SELECT
	fi.LineFolderItemID AS LineFolderItemID
	, sh.StyleNo
	, sh.[Description]
	, sc.StyleCategory
	, sh.SizeClass
	, sh.SizeRange
	, sh.MaterialName
	, (dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS FilePath
	, sh.StyleID
	, @LineFolderID as LineFolderID
FROM
	pLineFolderItem fi
	LEFT OUTER JOIN pStyleHeader sh ON fi.StyleID = sh.StyleID
	LEFT OUTER JOIN hImage hi ON sh.DesignSketchID = hi.ImageID
								 AND sh.DesignSketchVersion = hi.Version
	LEFT OUTER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
WHERE
	fi.LineFolderID = @LineFolderID 
ORDER BY
	fi.LineFolderItemSort
	, sh.StyleNo
	, sh.[Description]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04679', GetDate())
GO
