IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_FreelanceDesign_Image_2_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_FreelanceDesign_Image_2_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_FreelanceDesign_Image_2_SELECT]
(
	@StyleID UNIQUEIDENTIFIER
	, @WorkFlowItemId UNIQUEIDENTIFIER
	, @StyleSet AS INT
)
AS
BEGIN
	SELECT
		(ROW_NUMBER() OVER (ORDER BY sdf.Sort, sdf.CDate DESC)-1) / 2 AS RowNumber
		, (ROW_NUMBER() OVER (ORDER BY sdf.Sort, sdf.CDate DESC)-1) % 2 AS ColumnNumber
		, dbo.fnx_GetStreamingImagePath(sdf.ImageID, sdf.ImageVersion, 2000) AS FilePath
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
VALUES ('DB_Version', '6.1.0000', '10155', GetUTCDate())
GO