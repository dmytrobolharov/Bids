IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('rpx_Style_Measurement_HowToMeasure_BodyInfo_4ImagesPerPage_SELECT') and sysstat & 0xf = 4)
    DROP PROCEDURE rpx_Style_Measurement_HowToMeasure_BodyInfo_4ImagesPerPage_SELECT
GO

CREATE PROCEDURE [dbo].[rpx_Style_Measurement_HowToMeasure_BodyInfo_4ImagesPerPage_SELECT]
(
	@StyleId NVARCHAR(50)
	,@StyleSet NVARCHAR(5)
	,@WorkflowItemId NVARCHAR(50)
)
AS

SELECT
	IDENTITY(INT, 0, 1) AS TableRow
	,pAMLMeasPOM.RefCode AS POM
	,pAMLMeasPOM.[Description]
	,pAMLMeasPOM.How2MeasText
	,dbo.fnx_GetStreamingMeasImagePath(pAMLMeasPOM.ImageId) AS ImagePath
	,pAMLMeasPOM.SortId
INTO #temp_OnTheFlyTempTable
FROM pAMLMeasHdr
	INNER JOIN pAMLMeasPOM ON	pAMLMeasHdr.AMLMeasHdrId = pAMLMeasPOM.AMLMeasHdrId
WHERE pAMLMeasHdr.StyleId = @StyleId
	AND pAMLMeasHdr.StyleSet = @StyleSet
	AND pAMLMeasHdr.WorkflowItemId = @WorkflowItemId
ORDER BY
	pAMLMeasPOM.SortId
	,pAMLMeasPOM.RefCode
	,pAMLMeasPOM.[Description]

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
VALUES ('DB_Version', '5.0.0000', '05075', GetDate())
GO
