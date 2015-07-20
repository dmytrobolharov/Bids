IF OBJECT_ID(N'[dbo].[rpx_Style_Measurement_AllTabs_HeaderInfo_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[rpx_Style_Measurement_AllTabs_HeaderInfo_SELECT]
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
	WHEN @RPID IS NULL THEN REPLACE(wfi.WorkflowItemName,'Specification','Spec')
	WHEN EXISTS (SELECT * FROM rReportStylePageItem WHERE ReportPageID = @RPID) THEN REPLACE(wfi.WorkflowItemName,'Specification','Spec') + (SELECT ISNULL(' - ' + REPLACE(REPLACE(ReportPageName, 'Measurement ', ''),'- ',''), '') FROM rReportStylePageItem WHERE ReportPageID = @RPID)
	ELSE REPLACE(wfi.WorkflowItemName,'Specification','Spec') + (SELECT ISNULL(' - ' + REPLACE(REPLACE(ReportPageName, 'Measurement ', ''),'- ',''), '') FROM rReportTechPackPageItem WHERE ReportTechPackPageID = @RPID)
	END AS WorkflowItemName
	,amh.CompanyName
	,COALESCE(sc.Custom, amh.SizeClass) AS SizeClass
	,COALESCE(sr.SizeRangeCode, amh.SizeRange) AS SizeRange
	,amh.ProductType
	,aml.MeasLbl AS SampleSize
	,ISNULL(aml.MeasLblDesc,'') AS SampleSizeDesc
	,CASE
		WHEN amh.IsRelative = 0 AND amh.IsMetric = 0	THEN 'Incremental - Imperial'
		WHEN amh.IsRelative = 1 AND amh.IsMetric = 0	THEN 'Relative - Imperial'
		WHEN amh.IsRelative = 0 AND amh.IsMetric = 1	THEN 'Incremental - Metric'
		WHEN amh.IsRelative = 1 AND amh.IsMetric = 1	THEN 'Relative - Metric'
		ELSE ''
	 END AS Method_System
FROM pAMLMeasHdr amh
LEFT JOIN pWorkflowItem wfi ON amh.WorkflowItemId = wfi.WorkflowItemId
LEFT JOIN pAMLMeasLbl aml ON amh.AMLMeasHdrId = aml.AMLMeasHdrId AND aml.IsSample = 1
LEFT JOIN pSizeClass sc ON sc.CustomID = amh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomId = amh.SizeRangeId
WHERE amh.StyleId = @StyleId AND amh.StyleSet = @StyleSet AND amh.WorkflowItemId = @WorkflowItemId

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09512', GetDate())
GO
