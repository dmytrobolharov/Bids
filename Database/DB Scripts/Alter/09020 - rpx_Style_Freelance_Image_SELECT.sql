DROP PROCEDURE [dbo].[rpx_Style_Freelance_Image_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_Freelance_Image_SELECT]
(
	@StyleID UNIQUEIDENTIFIER
	, @WorkFlowItemId UNIQUEIDENTIFIER
	, @StyleSet AS INT
)
AS
BEGIN
	SELECT
		ROW_NUMBER() OVER (ORDER BY sdf.Sort, sdf.CDate DESC) AS RowNumber
		, dbo.fnx_GetStreamingImagePath(sdf.ImageID, sdf.ImageVersion) AS FilePath
		, REPLACE(sdf.Comments, 'span', 'u') AS Comments
	FROM pStyleDetailForm sdf
		INNER JOIN hImage i ON sdf.ImageID = i.ImageID AND sdf.ImageVersion = i.Version
	WHERE
		StyleID = @StyleID
		AND StyleSet = @StyleSet
		AND WorkFlowItemId = @WorkFlowItemId
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '09020', GetDate())
GO
