IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_Measurement_HowToMeasure_BodyInfo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_Measurement_HowToMeasure_BodyInfo_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_Measurement_HowToMeasure_BodyInfo_SELECT]
(
	@StyleId NVARCHAR(50)
	,@StyleSet NVARCHAR(5)
	,@WorkflowItemId NVARCHAR(50)
)
AS


/*Select.*/
SELECT
	pAMLMeasPOM.RefCode AS POM
	,pAMLMeasPOM.[Description]
	,pAMLMeasPOM.How2MeasText
	,dbo.fnx_GetStreamingMeasImagePath(pAMLMeasPOM.ImageId, '500') AS ImagePath
	,pAMLMeasPOM.SortId
FROM pAMLMeasHdr
	INNER JOIN pAMLMeasPOM ON	pAMLMeasHdr.AMLMeasHdrId = pAMLMeasPOM.AMLMeasHdrId
	LEFT OUTER JOIN pGRMeasurementsPOM ON	pAMLMeasPOM.POMGuidId = pGRMeasurementsPOM.POMId
											AND pAMLMeasPOM.IsLinked = 1
WHERE pAMLMeasHdr.StyleId = @StyleId
	AND pAMLMeasHdr.StyleSet = @StyleSet
	AND pAMLMeasHdr.WorkflowItemId = @WorkflowItemId
ORDER BY
	pAMLMeasPOM.SortId
	,pAMLMeasPOM.RefCode
	,pAMLMeasPOM.[Description]
	


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10177', GetUTCDate())
GO