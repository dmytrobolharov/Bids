IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackTemp_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackTemp_DELETE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
     
CREATE PROCEDURE [dbo].[spx_TechPackTemp_DELETE]  
(@ReportTechPackID uniqueidentifier,  
 @OnTheFly integer)  
AS   
  
IF @OnTheFly = 0  
BEGIN  
 DELETE FROM rReportStyleTemp WHERE (DataXmlId = @ReportTechPackID)  
 DELETE FROM rReportTable WHERE (DataXmlId = @ReportTechPackID)  
END  
  
ELSE IF @OnTheFly = 1  
BEGIN  
 DELETE FROM rReportStylePageItemTemp WHERE (ReportTechPackID = @ReportTechPackID)  
 DELETE FROM rReportSamplePageItemTemp WHERE (ReportTechPackID = @ReportTechPackID)  
 DELETE FROM rReportTable WHERE (DataXmlId = @ReportTechPackID)  
END  

  GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03059'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03059', GetDate())     

END	  
GO 
      