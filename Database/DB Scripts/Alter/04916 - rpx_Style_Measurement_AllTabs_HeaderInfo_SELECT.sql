IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_Measurement_AllTabs_HeaderInfo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_Measurement_AllTabs_HeaderInfo_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[rpx_Style_Measurement_AllTabs_HeaderInfo_SELECT]
(
	@StyleId NVARCHAR(50)
	,@StyleSet NVARCHAR(5)
	,@WorkflowItemId NVARCHAR(50)
	,@RPID NVARCHAR(50) = NULL
)
AS


/*Select*/
SELECT
	CASE 
	WHEN @RPID IS NULL THEN REPLACE(pWorkflowItem.WorkflowItemName,'Specification','Spec')
	WHEN EXISTS (SELECT * FROM rReportStylePageItem WHERE ReportPageID = @RPID) THEN REPLACE(pWorkflowItem.WorkflowItemName,'Specification','Spec') + (SELECT ISNULL(' - ' + REPLACE(REPLACE(ReportPageName, 'Measurement ', ''),'- ',''), '') FROM rReportStylePageItem WHERE ReportPageID = @RPID)
	ELSE REPLACE(pWorkflowItem.WorkflowItemName,'Specification','Spec') + (SELECT ISNULL(' - ' + REPLACE(REPLACE(ReportPageName, 'Measurement ', ''),'- ',''), '') FROM rReportTechPackPageItem WHERE ReportTechPackPageID = @RPID)
	END AS WorkflowItemName
	,pAMLMeasHdr.CompanyName
	,pAMLMeasHdr.SizeClass
	,pAMLMeasHdr.SizeRange
	,pAMLMeasHdr.ProductType
	,pAMLMeasLbl.MeasLbl AS SampleSize
	,ISNULL(pAMLMeasLbl.MeasLblDesc,'') AS SampleSizeDesc
	,CASE
		WHEN pAMLMeasHdr.IsRelative = 0 AND pAMLMeasHdr.IsMetric = 0	THEN 'Incremental - Imperial'
		WHEN pAMLMeasHdr.IsRelative = 1 AND pAMLMeasHdr.IsMetric = 0	THEN 'Relative - Imperial'
		WHEN pAMLMeasHdr.IsRelative = 0 AND pAMLMeasHdr.IsMetric = 1	THEN 'Incremental - Metric'
		WHEN pAMLMeasHdr.IsRelative = 1 AND pAMLMeasHdr.IsMetric = 1	THEN 'Relative - Metric'
		ELSE ''
	 END AS Method_System
FROM
	pAMLMeasHdr
	LEFT OUTER JOIN pWorkflowItem ON	pAMLMeasHdr.WorkflowItemId = pWorkflowItem.WorkflowItemId
	LEFT OUTER JOIN pAMLMeasLbl ON	pAMLMeasHdr.AMLMeasHdrId = pAMLMeasLbl.AMLMeasHdrId AND pAMLMeasLbl.IsSample = 1
WHERE
	pAMLMeasHdr.StyleId = @StyleId
	AND pAMLMeasHdr.StyleSet = @StyleSet
	AND pAMLMeasHdr.WorkflowItemId = @WorkflowItemId
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04916', GetDate())
GO
