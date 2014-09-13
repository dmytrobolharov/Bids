IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_Measurement_AllTabs_HeaderInfo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_Measurement_AllTabs_HeaderInfo_SELECT]
GO

CREATE PROCEDURE rpx_Style_Measurement_AllTabs_HeaderInfo_SELECT
(
	@StyleId NVARCHAR(50)
	,@StyleSet NVARCHAR(5)
	,@WorkflowItemId NVARCHAR(50)
)
AS


/*Select*/
SELECT
	pWorkflowItem.WorkflowItemName
	,pAMLMeasHdr.CompanyName
	,pAMLMeasHdr.SizeClass
	,pAMLMeasHdr.SizeRange
	,pAMLMeasHdr.ProductType
	,pAMLMeasLbl.MeasLbl AS SampleSize
	,CASE
		WHEN pAMLMeasHdr.IsRelative = 0 AND pAMLMeasHdr.IsMetric = 0	THEN 'Incremental - Imperial'
		WHEN pAMLMeasHdr.IsRelative = 1 AND pAMLMeasHdr.IsMetric = 0	THEN 'Relative - Imperial'
		WHEN pAMLMeasHdr.IsRelative = 0 AND pAMLMeasHdr.IsMetric = 1	THEN 'Incremental - Metric'
		WHEN pAMLMeasHdr.IsRelative = 1 AND pAMLMeasHdr.IsMetric = 1	THEN 'Relative - Metric'
		ELSE ''
	 END AS Method_System
FROM pAMLMeasHdr
	INNER JOIN pWorkflowItem ON	pAMLMeasHdr.WorkflowItemId = pWorkflowItem.WorkflowItemId
	INNER JOIN pAMLMeasLbl ON	pAMLMeasHdr.AMLMeasHdrId = pAMLMeasLbl.AMLMeasHdrId
								AND pAMLMeasLbl.IsSample = 1
WHERE pAMLMeasHdr.StyleId = @StyleId
	AND pAMLMeasHdr.StyleSet = @StyleSet
	AND pAMLMeasHdr.WorkflowItemId = @WorkflowItemId
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01177', GetDate())
GO