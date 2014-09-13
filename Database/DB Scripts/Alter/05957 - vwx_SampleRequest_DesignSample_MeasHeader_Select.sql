/****** Object:  View [dbo].[vwx_SampleRequest_DesignSample_MeasHeader_Select]    Script Date: 07/02/2013 15:39:47 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequest_DesignSample_MeasHeader_Select]'))
DROP VIEW [dbo].[vwx_SampleRequest_DesignSample_MeasHeader_Select]
GO


/****** Object:  View [dbo].[vwx_SampleRequest_DesignSample_MeasHeader_Select]    Script Date: 07/02/2013 15:39:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_SampleRequest_DesignSample_MeasHeader_Select]
AS
SELECT     dbo.pSampleRequestAMLMeasHdr.SampleRequestAMLMeasHdrId, dbo.pSampleRequestAMLMeasHdr.StyleId, dbo.pSampleRequestAMLMeasHdr.CompanyName, 
                      dbo.pSampleRequestAMLMeasHdr.SizeClass, dbo.pSampleRequestAMLMeasHdr.SizeRange, dbo.pSampleRequestAMLMeasHdr.ProductType, 
                      CASE IsRelative WHEN '1' THEN 'Relative' ELSE 'Incremental' END + ' - ' + CASE IsMetric WHEN '1' THEN 'Metric' ELSE 'Imperial' END AS MeasMethodSystem, 
                      dbo.pSampleRequestAMLMeasLbl.MeasLbl AS SampleSizeName, dbo.pSampleRequestAMLMeasHdr.Workflowid
FROM         dbo.pSampleRequestAMLMeasLbl INNER JOIN
                      dbo.pSampleRequestAMLMeasHdr ON 
                      dbo.pSampleRequestAMLMeasLbl.SampleRequestAMLMeasHdrId = dbo.pSampleRequestAMLMeasHdr.SampleRequestAMLMeasHdrId
WHERE     (dbo.pSampleRequestAMLMeasLbl.IsSample = 1)

GO

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05957', GetDate())
GO
