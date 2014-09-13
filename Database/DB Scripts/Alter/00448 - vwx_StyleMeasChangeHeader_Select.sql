/****** Object:  View [dbo].[vwx_StyleMeasChangeHeader_Select]    Script Date: 09/22/2010 14:37:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwx_StyleMeasChangeHeader_Select]
AS
SELECT     dbo.pAMLMeasHdr.AMLMeasHdrId as MeasHdrId, dbo.pAMLMeasHdr.StyleId as MeasStyleId, dbo.pAMLMeasHdr.CompanyName as MeasCompany, dbo.pAMLMeasHdr.SizeClass as MeasSizeClass, dbo.pAMLMeasHdr.SizeRange as MeasSizeRange, 
                      dbo.pAMLMeasHdr.ProductType as MeasProductType, 
                      CASE IsRelative WHEN '-1' THEN 'Relative' ELSE 'Incremental' END + ' - ' + CASE IsMetric WHEN '-1' THEN 'Metric' ELSE 'Imperial' END AS MeasMethodAndSystem, 
                      dbo.pAMLMeasLbl.MeasLbl AS MeasSampleSize, dbo.pAMLMeasHdr.Workflowid as MeasWorkflowid
FROM         dbo.pAMLMeasLbl INNER JOIN
                      dbo.pAMLMeasHdr ON dbo.pAMLMeasLbl.AMLMeasHdrId = dbo.pAMLMeasHdr.AMLMeasHdrId
WHERE     (dbo.pAMLMeasLbl.IsSample = - 1)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.0.0000', '448', GetDate())
GO