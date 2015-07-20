IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_DesignDetail2_Image_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_DesignDetail2_Image_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_DesignDetail2_Image_SELECT]
	@StyleID UNIQUEIDENTIFIER
	, @WorkflowItemID UNIQUEIDENTIFIER
	, @StyleSet AS INT
AS
BEGIN
	SELECT ROW_NUMBER() OVER (ORDER BY sdf.Sort, sdf.ImageID) AS RowNumber
		, dbo.fnx_GetStreamingImagePath(sdf.ImageID, sdf.ImageVersion) AS FilePath
		, hi.ImageDescription
		, CASE WHEN sdf.Comments LIKE '%underline%' THEN '<u>' + sdf.Comments + '</u>' ELSE sdf.Comments END AS Comments
	FROM pStyleDetailForm sdf
		LEFT JOIN hImage hi ON sdf.ImageID = hi.ImageID AND sdf.ImageVersion = hi.Version
	WHERE sdf.StyleSet = @StyleSet
		AND sdf.WorkFlowItemId = @WorkflowItemID
		AND sdf.StyleID = @StyleID
	ORDER BY
		sdf.Sort
		, sdf.ImageID ASC
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08564', GetDate())
GO