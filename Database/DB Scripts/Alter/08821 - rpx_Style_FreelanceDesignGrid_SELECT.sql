IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_FreelanceDesignGrid_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_FreelanceDesignGrid_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_FreelanceDesignGrid_SELECT]
	@StyleID UNIQUEIDENTIFIER
	, @StyleSet INT
AS
BEGIN
	SELECT FeatureDetail
		, Measurement
		, StitchType
		, Comments
	FROM pStyleDetail
	WHERE
		StyleID = @StyleID
		AND StyleSet = @StyleSet
	ORDER BY Sort
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08821', GetDate())
GO
