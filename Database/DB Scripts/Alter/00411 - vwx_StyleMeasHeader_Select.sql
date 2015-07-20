
/****** Object:  View [dbo].[vwx_StyleMeasHeader_Select]    Script Date: 08/25/2010 10:48:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwx_StyleMeasHeader_Select]
AS
SELECT     dbo.pAMLMeasHdr.AMLMeasHdrId, dbo.pAMLMeasHdr.StyleId, dbo.pAMLMeasHdr.CompanyName, dbo.pAMLMeasHdr.SizeClass, dbo.pAMLMeasHdr.SizeRange, 
                      dbo.pAMLMeasHdr.ProductType, 
                      CASE IsRelative WHEN '-1' THEN 'Relative' ELSE 'Incremental' END + ' - ' + CASE IsMetric WHEN '-1' THEN 'Metric' ELSE 'Imperial' END AS MeasMethodSystem, 
                      dbo.pAMLMeasLbl.MeasLbl AS SampleSizeName
FROM         dbo.pAMLMeasLbl INNER JOIN
                      dbo.pAMLMeasHdr ON dbo.pAMLMeasLbl.AMLMeasHdrId = dbo.pAMLMeasHdr.AMLMeasHdrId
WHERE     (dbo.pAMLMeasLbl.IsSample = - 1)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '411', GetDate())
GO