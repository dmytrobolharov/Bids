IF OBJECT_ID(N'[dbo].[vwx_StyleMeasHeader_Select]') IS NOT NULL
 DROP VIEW [dbo].[vwx_StyleMeasHeader_Select]
GO

CREATE VIEW [dbo].[vwx_StyleMeasHeader_Select]
AS
SELECT amh.AMLMeasHdrId, amh.StyleId, amh.CompanyName, COALESCE(sc.Custom, amh.SizeClass) AS SizeClass, 
       COALESCE(sr.SizeRangeCode, amh.SizeRange) AS SizeRange, amh.ProductType, 
       CASE IsRelative WHEN '1' THEN 'Relative' ELSE 'Incremental' END + ' - ' + 
	   CASE IsMetric WHEN '1' THEN 'Metric' ELSE 'Imperial' END AS MeasMethodSystem, 
       aml.MeasLbl AS SampleSizeName, amh.Workflowid
FROM pAMLMeasLbl aml 
INNER JOIN pAMLMeasHdr amh ON aml.AMLMeasHdrId = amh.AMLMeasHdrId
LEFT JOIN pSizeClass sc ON sc.CustomID = amh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = amh.SizeRangeId
WHERE (aml.IsSample = 1)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09491', GetDate())
GO
