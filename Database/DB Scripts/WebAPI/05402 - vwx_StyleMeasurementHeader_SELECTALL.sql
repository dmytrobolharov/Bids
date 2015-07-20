/****** Object:  View [dbo].[vwx_StyleMeasurementHeader_SELECTALL]    Script Date: 08/25/2010 10:48:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwx_StyleMeasurementHeader_SELECTALL]
AS
SELECT     
	dbo.pAMLMeasHdr.AMLMeasHdrId, 
	dbo.pAMLMeasLbl.AMLMeasLblId, 
	dbo.pAMLMeasHdr.StyleId,
	dbo.pAMLMeasHdr.Workflowid,  
	dbo.pAMLMeasHdr.WorkFlowItemId,
	dbo.pAMLMeasHdr.CompanyName, 
	dbo.pAMLMeasHdr.IsRelative, 
	dbo.pAMLMeasHdr.IsNegative, 
	dbo.pAMLMeasHdr.IsMetric, 
	dbo.pAMLMeasHdr.SizeClass, 
	dbo.pAMLMeasHdr.SizeClassCode, 
    dbo.pAMLMeasHdr.SizeRange, 
    dbo.pAMLMeasHdr.ProductType, 
    dbo.pAMLMeasHdr.MeasRowCnt, 
    dbo.pAMLMeasHdr.HaveHistory, 
    dbo.pAMLMeasHdr.StyleSet, 
    dbo.pAMLMeasLbl.SizeCol, 
    dbo.pAMLMeasLbl.MeasLbl, 
    dbo.pAMLMeasLbl.IsVisible, 
    dbo.pAMLMeasLbl.IsSample, 
    dbo.pAMLMeasLbl.MeasDesc, 
    dbo.pAMLMeasHdr.CUser, 
    dbo.pAMLMeasHdr.CDate, 
    dbo.pAMLMeasHdr.MUser, 
    dbo.pAMLMeasHdr.MDate
FROM         
	dbo.pAMLMeasHdr INNER JOIN dbo.pAMLMeasLbl 
	ON dbo.pAMLMeasHdr.AMLMeasHdrId = dbo.pAMLMeasLbl.AMLMeasHdrId

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '05402', GetDate())
GO