IF OBJECT_ID(N'[dbo].[vwx_SampleRequest_DesignSample_MeasHeader_Select]') IS NOT NULL
 DROP VIEW [dbo].[vwx_SampleRequest_DesignSample_MeasHeader_Select]
GO

CREATE VIEW [dbo].[vwx_SampleRequest_DesignSample_MeasHeader_Select]
AS
SELECT hdr.SampleRequestAMLMeasHdrId, hdr.StyleId, hdr.CompanyName, 
	   sc.Custom AS SizeClass, sr.SizeRangeCode AS SizeRange, hdr.ProductType, 
       CASE IsRelative WHEN '1' THEN 'Relative' ELSE 'Incremental' END + ' - ' + CASE IsMetric WHEN '1' THEN 'Metric' ELSE 'Imperial' END AS MeasMethodSystem, 
       lbl.MeasLbl AS SampleSizeName, hdr.Workflowid
FROM pSampleRequestAMLMeasLbl lbl
INNER JOIN pSampleRequestAMLMeasHdr hdr ON lbl.SampleRequestAMLMeasHdrId = hdr.SampleRequestAMLMeasHdrId
LEFT JOIN pSizeClass sc ON sc.CustomID = hdr.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = hdr.SizeRangeId
WHERE (lbl.IsSample = 1)


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10018', GetUTCDate())
GO
