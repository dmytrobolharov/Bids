DROP PROCEDURE [dbo].[rpx_Style_DesignDetail2_Image_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_DesignDetail2_Image_SELECT]
	@StyleID UNIQUEIDENTIFIER
	, @WorkflowItemID UNIQUEIDENTIFIER
	, @StyleSet AS INT
AS
BEGIN
	SELECT ROW_NUMBER() OVER (ORDER BY sdf.Sort, sdf.CDate) AS RowNumber
		, dbo.fnx_GetStreamingImagePath(sdf.ImageID, sdf.ImageVersion) AS FilePath
		, hi.ImageDescription
		, REPLACE(sdf.Comments, 'span', 'u') AS Comments
	FROM pStyleDetailForm sdf
		LEFT JOIN hImage hi ON sdf.ImageID = hi.ImageID AND sdf.ImageVersion = hi.Version
	WHERE sdf.StyleSet = @StyleSet
		AND sdf.WorkFlowItemId = @WorkflowItemID
		AND sdf.StyleID = @StyleID
	ORDER BY
		sdf.Sort
		, sdf.CDate DESC
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09270', GetDate())
GO

