IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_ControlPanel_Measurement_HowToMeasure_BodyInfo_4ImagesPerPage_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_ControlPanel_Measurement_HowToMeasure_BodyInfo_4ImagesPerPage_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_ControlPanel_Measurement_HowToMeasure_BodyInfo_4ImagesPerPage_SELECT]
	@POMTemplateID NVARCHAR(MAX) = NULL
AS
	CREATE TABLE #temp_OnTheFlyTempTable(
		TableRow INT IDENTITY(0, 1)
		, POM NVARCHAR(50)
		, Description NVARCHAR(200)
		, How2MeasText NVARCHAR(4000)
		, ImagePath NVARCHAR(1000)
		, Sort INT)

	IF @POMTemplateID IS NULL OR @POMTemplateID = ''
		INSERT INTO #temp_OnTheFlyTempTable(
			POM
			, Description
			, How2MeasText
			, ImagePath
			, Sort)
		SELECT
			mp.POMCode AS POM
			, mp.POMDesc AS Description
			, mp.How2MeasText
			, dbo.fnx_GetStreamingMeasImagePath(mp.ImageId) AS ImagePath
			, mp.Sort
		FROM
			pGRMeasurementsPOM mp
		ORDER BY
			mp.Sort
			,mp.POMCode
			,mp.POMDesc
	ELSE
		INSERT INTO #temp_OnTheFlyTempTable(
			POM
			, Description
			, How2MeasText
			, ImagePath
			, Sort)
		SELECT
			mp.POMCode AS POM
			, mp.POMDesc AS Description
			, mp.How2MeasText
			, dbo.fnx_GetStreamingMeasImagePath(mp.ImageId) AS ImagePath
			, mp.Sort
		FROM
			pGRMeasurementsPOM mp
			INNER JOIN pGRMeasurementsPOMTemplateItem pti ON mp.POMId = pti.POMID
		WHERE POMTempID = @POMTemplateID
		ORDER BY
			mp.Sort
			,mp.POMCode
			,mp.POMDesc

	SELECT
		TableRow / 2 AS [Row]
		,TableRow % 2 AS [Column]
		,*
	FROM #temp_OnTheFlyTempTable
	ORDER BY
		TableRow

	DROP TABLE #temp_OnTheFlyTempTable
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05074', GetDate())
GO
