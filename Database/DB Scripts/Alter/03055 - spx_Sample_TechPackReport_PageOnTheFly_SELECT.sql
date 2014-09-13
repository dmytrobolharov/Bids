IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sample_TechPackReport_PageOnTheFly_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sample_TechPackReport_PageOnTheFly_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
    
   
CREATE PROCEDURE [dbo].[spx_Sample_TechPackReport_PageOnTheFly_SELECT]    
 @TechPackFolderId [uniqueidentifier]    
WITH EXECUTE AS CALLER    
AS   
  
DECLARE @STYLETYPEID INT  
DECLARE @STYLEID UNIQUEIDENTIFIER  
  
SELECT TOP 1 @STYLEID = A.StyleID    
FROM rReportSamplePageItemTemp A  
INNER JOIN dbo.pStyleHeader B ON A.StyleID = B.StyleID  
WHERE ReportTechpackID = @TechPackFolderId  
  
SET @STYLETYPEID = (SELECT STYLETYPE FROM dbo.pStyleHeader WHERE STYLEID = @STYLEID)  
  
IF @STYLETYPEID =  26  
BEGIN  
 SELECT ReportSamplePageItemTempID, ReportSamplePageItemID, ReportPageID, ReportTechpackID, ReportMapID, ReportPageTypeID, WorkflowItemID, WorkflowID,     
    ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive,     
    ReportPageFormat, ReportSrmOn, SeasonYearID, StyleDevelopmentID, StyleHeaderID, StyleID, StyleSet, Sort, TechPackName, TechPackFinal, Variation, StyleColorwaySeasonYearID ,
    SampleRequestSubmitId ,  SampleRequestWorkflowId ,  TradePartnerVendorId ,  SampleRequestTradeId ,   TeamID ,   SampleWorkflowId ,  SizeIndex ,  Submit     
 FROM rReportSamplePageItemTemp    
 WHERE ReportTechpackID = @TechPackFolderId    
 ORDER BY CAST(Sort AS INT), StyleSet   
END  
ELSE  
BEGIN  
 SELECT ReportSamplePageItemTempID, ReportSamplePageItemID, ReportPageID, ReportTechpackID, ReportMapID, ReportPageTypeID, WorkflowItemID, A.WorkflowID,     
    ReportTemplateName, ReportPageName, ReportPageDescription, ReportServerType, ReportFormName, ReportPageURL, ReportPKIField, ReportPageActive,     
    ReportPageFormat, ReportSrmOn, SeasonYearID, StyleDevelopmentID, StyleHeaderID, A.StyleID, A.StyleSet, Sort, TechPackName, TechPackFinal, Variation, StyleColorwaySeasonYearID, C.WorkflowSort, 
    A.SampleRequestSubmitId ,  A.SampleRequestWorkflowId ,  A.TradePartnerVendorId ,  A.SampleRequestTradeId ,   A.TeamID ,   A.SampleWorkflowId ,  A.SizeIndex ,  A.Submit        
 FROM rReportSamplePageItemTemp A   
 INNER JOIN dbo.pStyleHeader B ON A.StyleID = B.StyleID  
 LEFT OUTER JOIN dbo.pWorkflowTemplateItem C ON B.StyleWorkflowID = C.WorkflowTemplateID  AND A.WorkflowID = C.WorkflowID  
 WHERE ReportTechpackID = @TechPackFolderId  
 ORDER BY   C.WorkflowSort, A.WorkflowID, CAST(Sort AS INT), A.StyleSet    
END  
  
 GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03055'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03055', GetDate())     

END	  
GO 
  
  