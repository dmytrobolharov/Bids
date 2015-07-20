IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sample_TechPackReport_PageItemTemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sample_TechPackReport_PageItemTemp_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

  
CREATE PROCEDURE [dbo].[spx_Sample_TechPackReport_PageItemTemp_INSERT]  
 @ReportTechpackID [uniqueidentifier],  
 @ReportPageID [uniqueidentifier],  
 @WorkflowItemID [uniqueidentifier],  
 @WorkflowID [uniqueidentifier],  
 @SeasonYearID [uniqueidentifier],  
 @StyleDevelopmentID [uniqueidentifier],  
 @StyleHeaderID [uniqueidentifier],  
 @StyleID [uniqueidentifier],  
 @StyleSet [int],  
 @TechPackName [nvarchar](200),  
 @TechPackFinal [int],  
 @Sort [int],  
 @StyleColorwaySeasonYearID [uniqueidentifier],  
 @IsTechPackOnTheFly [int] = NULL , 
 @SampleRequestSubmitId [uniqueidentifier], 
 @SampleRequestWorkflowId [uniqueidentifier], 
 @TradePartnerVendorId [uniqueidentifier], 
 @SampleRequestTradeId [uniqueidentifier],  
 @TeamID [uniqueidentifier],  
 @SampleWorkflowId [nvarchar](40), 
 @SizeIndex [nvarchar](40), 
 @Submit [nvarchar](5) 
WITH EXECUTE AS CALLER  
AS  
 
DECLARE @CountID INT
SELECT @CountID = COUNT(*) FROM rReportSampleRequestSubmititem WHERE ReportSampleRequestSubmitPageID =  @ReportPageID

IF @CountID <> 0 
BEGIN
  INSERT INTO rReportSamplePageItemTemp  (ReportSamplePageItemTempID , ReportSamplePageItemID , ReportPageID , ReportTechPackID , ReportMapID , ReportPageTypeID ,   
   ReportTemplateName, ReportPageName , ReportPageDescription,   
   ReportServerType , ReportFormName ,ReportPageURL , ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, SeasonYearID, StyleHeaderID ,   
   StyleID, StyleDevelopmentID, StyleSet, Sort , TechPackName, TechPackFinal, StyleColorwaySeasonYearID, WorkflowItemID, WorkflowID,
   SampleRequestSubmitId ,  SampleRequestWorkflowId ,  TradePartnerVendorId ,  SampleRequestTradeId ,   TeamID ,   SampleWorkflowId ,  SizeIndex ,  Submit  
   )   
  SELECT  NEWID() AS ReportSamplePageItemTempID , NEWID() AS ReportSamplePageItemID, @ReportPageID ,  @ReportTechpackID ,  @WorkflowItemID ,  ReportPageTypeID ,   
   ReportTemplateName, ReportPageName , ReportPageDescription,  
   ReportServerType , ReportFormName ,ReportPageURL , ReportPKIField, ReportPageActive, ReportPageFormat, 0, @SeasonYearID, @StyleHeaderID,   
   @StyleID, @StyleDevelopmentID, @StyleSet, @Sort, @TechPackName, @TechPackFinal, @StyleColorwaySeasonYearID,  
   @WorkflowItemID, @WorkflowID  ,
   @SampleRequestSubmitId ,  @SampleRequestWorkflowId ,  @TradePartnerVendorId ,  @SampleRequestTradeId ,   @TeamID ,   @SampleWorkflowId ,  @SizeIndex ,  @Submit 
  FROM rReportSampleRequestSubmititem WHERE ReportSampleRequestSubmitPageID =  @ReportPageID 
END
ELSE
 BEGIN  
  INSERT INTO rReportSamplePageItemTemp  (ReportSamplePageItemTempID , ReportSamplePageItemID , ReportPageID , ReportTechPackID , ReportMapID , ReportPageTypeID ,   
   ReportTemplateName, ReportPageName , ReportPageDescription,   
   ReportServerType , ReportFormName ,ReportPageURL , ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, SeasonYearID, StyleHeaderID ,   
   StyleID, StyleDevelopmentID, StyleSet, Sort , TechPackName, TechPackFinal, StyleColorwaySeasonYearID, WorkflowItemID, WorkflowID,
   SampleRequestSubmitId ,  SampleRequestWorkflowId ,  TradePartnerVendorId ,  SampleRequestTradeId ,   TeamID ,   SampleWorkflowId ,  SizeIndex ,  Submit  
   )   
  SELECT NEWID() AS ReportSamplePageItemTempID , NEWID() AS ReportStylePageItemID, ReportPageID ,  @ReportTechpackID ,  ReportMapID ,  ReportPageTypeID ,   
   ReportTemplateName, ReportPageName , ReportPageDescription,  
   ReportServerType , ReportFormName ,ReportPageURL , ReportPKIField, ReportPageActive, ReportPageFormat, ReportSrmOn, @SeasonYearID, @StyleHeaderID,   
   @StyleID, @StyleDevelopmentID, @StyleSet, @Sort, @TechPackName, @TechPackFinal, @StyleColorwaySeasonYearID,  
   @WorkflowItemID, @WorkflowID  ,
   @SampleRequestSubmitId ,  @SampleRequestWorkflowId ,  @TradePartnerVendorId ,  @SampleRequestTradeId ,   @TeamID ,   @SampleWorkflowId ,  @SizeIndex ,  @Submit 
  FROM rReportStylePageItem WHERE ReportPageID= @ReportPageID  
 END  
 
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03054'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03054', GetDate())     

END	  
GO
 

 
  
  
  
  
  
  
  
  
  
  
  