IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_DesignDetailGrid_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_DesignDetailGrid_SELECT]
GO

CREATE   PROCEDURE [dbo].[rpx_Style_DesignDetailGrid_SELECT] 
	@StyleID nVARCHAR(255)
	, @StyleSet INT
AS

DECLARE @GridRowCount INT
DECLARE @DisplayGrid INT

/*Create a temp table to use in helping to hide the grid if there are no values.*/
CREATE TABLE #tempTable
(
	TableRow INT identity(1, 1)
	, FeatureDetail NVARCHAR(100)
	, Measurement NVARCHAR(100)
	, StitchType NVARCHAR(100)
	, Comments NVARCHAR(4000)
	, Sort NVARCHAR(4)

)

/*See if there are any grid entries.*/
SELECT @GridRowCount = COUNT(*)
FROM	pStyleDetail
WHERE	((StyleID = @StyleID) AND
	(StyleSet = @StyleSet))

/*See if the grid is set to display.*/
SELECT @DisplayGrid = DetailSketchData
FROM pStyleImage
WHERE StyleID = @StyleID

IF (@GridRowCount = 0 OR @DisplayGrid = 0)
	BEGIN
		INSERT INTO #tempTable (FeatureDetail, Measurement,	StitchType,	Comments, Sort)
		VALUES ('HideGrid', '', '', '', '')

		SELECT FeatureDetail, Measurement,	StitchType,	Comments, Sort
		FROM #tempTable
	END
ELSE
	BEGIN
		SELECT FeatureDetail,
			Measurement,
			StitchType,
			Comments
		FROM	pStyleDetail
		WHERE	((StyleID = @StyleID) AND
			(StyleSet = @StyleSet))
		ORDER BY Sort
	END

DROP TABLE #tempTable
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10049', GetUTCDate())
GO