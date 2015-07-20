IF OBJECT_ID(N'[dbo].[vwx_StyleMeasurementHeader_SELECTALL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_StyleMeasurementHeader_SELECTALL]
GO

CREATE VIEW [dbo].[vwx_StyleMeasurementHeader_SELECTALL]
AS
SELECT amh.AMLMeasHdrId, aml.AMLMeasLblId, amh.StyleId,	amh.Workflowid,  amh.WorkFlowItemId,
	   amh.CompanyName, amh.IsRelative, amh.IsNegative, amh.IsMetric, 
	   COALESCE(sc.Custom, amh.SizeClass) AS SizeClass, amh.SizeClassCode, 
       COALESCE(sr.SizeRangeCode, amh.SizeRange) AS SizeRange, amh.ProductType, 
       amh.MeasRowCnt, amh.HaveHistory, amh.StyleSet, aml.SizeCol, aml.MeasLbl, 
       aml.IsVisible, aml.IsSample, aml.MeasDesc, amh.CUser, amh.CDate, amh.MUser, 
       amh.MDate
FROM pAMLMeasHdr amh 
INNER JOIN pAMLMeasLbl aml ON amh.AMLMeasHdrId = aml.AMLMeasHdrId
LEFT JOIN pSizeClass sc ON sc.CustomID = amh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = amh.SizeRangeId


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09492', GetDate())
GO
