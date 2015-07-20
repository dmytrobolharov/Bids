IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sample_TechPackReport_PageStyleGroupBy_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sample_TechPackReport_PageStyleGroupBy_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
    
    
CREATE PROCEDURE [dbo].[spx_Sample_TechPackReport_PageStyleGroupBy_SELECT]  
 @TechPackFolderId [uniqueidentifier]  
WITH EXECUTE AS CALLER  
AS  
SELECT StyleID, SeasonYearID, TechPackFinal, TechPackName, SampleRequestSubmitId, Submit, SampleRequestTradeID, SampleRequestWorkflowId, TradePartnerVendorId,
SampleWorkflowId, SizeIndex FROM rReportSamplePageItemTemp  
 WHERE ReportTechpackID = @TechPackFolderId   
 GROUP BY StyleID, SeasonYearID, TechPackFinal, TechPackName   ,SampleRequestSubmitId, Submit, SampleRequestTradeID, SampleRequestWorkflowId, TradePartnerVendorId,
SampleWorkflowId, SizeIndex
 
 GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03056'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03056', GetDate())     

END	  
GO 
  