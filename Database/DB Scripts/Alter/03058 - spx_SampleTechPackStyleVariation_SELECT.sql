IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleTechPackStyleVariation_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleTechPackStyleVariation_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
     
CREATE PROCEDURE [dbo].[spx_SampleTechPackStyleVariation_SELECT]  
 @StyleID [uniqueidentifier]  ,
 @SampleRequestSubmitId UNIQUEIDENTIFIER,
 @Submit NVARCHAR(4)
WITH EXECUTE AS CALLER  
AS  
DECLARE @StyleDevelopmentId uniqueidentifier  
  
BEGIN  
SELECT TOP 1 @StyleDevelopmentId = StyleDevelopmentId FROM dbo.pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleID = @StyleID  
END  
  
BEGIN  
 SELECT A.StyleDevelopmentItemID, A.StyleDevelopmentID, A.StyleDevelopmentID, A.StyleID, A.StyleDevelopmentName, A.Variation, b.TechPackID   
 FROM dbo.pStyleDevelopmentItem A
 INNER JOIN dbo.pTechPack B ON A.StyleID = B.StyleID
 WHERE (A.StyleDevelopmentID = @StyleDevelopmentID AND B.SampleRequestSubmitId = @SampleRequestSubmitId AND B.Submit= @Submit)  
 ORDER BY Variation ASC  
END  
  
   GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03058'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03058', GetDate())     

END	  
GO 
      
  
  