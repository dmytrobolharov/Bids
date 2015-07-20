IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestDocument_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_MaterialRequestDocument_SELECT]
GO 

CREATE PROCEDURE [dbo].[spx_MaterialRequestDocument_SELECT]  
(   
 @MaterialID uniqueidentifier,  
 @MaterialTradePartnerID uniqueidentifier,  
 @MaterialTradePartnerColorID uniqueidentifier,  
 @MaterialRequestSubmitWorkflowID uniqueidentifier,  
 @MaterialRequest int  
)  
AS   
  
IF @MaterialRequest = 1  
 BEGIN  
  SELECT MaterialRequestDocumentID, MaterialID, MaterialTradePartnerID, MaterialTradePartnerColorID, MaterialRequestSubmitWorkflowID, MaterialDocumentName,   
   MaterialDocumentDescription, MaterialDocumentExt, MaterialDocumentSize,   
   MaterialDocumentShared, CUser, CDate, MUser, MDate, MChange,   
   SystemServerStorageID  
  FROM pMaterialRequestDocument   
  WHERE MaterialID = @MaterialID  AND MaterialTradePartnerID = @MaterialTradePartnerID AND MaterialTradePartnerColorID = @MaterialTradePartnerColorID AND MaterialRequestSubmitWorkflowID = @MaterialRequestSubmitWorkflowID AND MaterialDocumentShared = @MaterialRequest  
 END  
ELSE  
 BEGIN  
  SELECT MaterialRequestDocumentID, MaterialID, MaterialTradePartnerID, MaterialTradePartnerColorID, MaterialRequestSubmitWorkflowID, MaterialDocumentName,   
   MaterialDocumentDescription, MaterialDocumentExt, MaterialDocumentSize,   
   MaterialDocumentShared, CUser, CDate, MUser, MDate, MChange,   
   SystemServerStorageID  
  FROM pMaterialRequestDocument   
  WHERE MaterialID = @MaterialID   AND MaterialTradePartnerID = @MaterialTradePartnerID AND MaterialTradePartnerColorID = @MaterialTradePartnerColorID AND MaterialRequestSubmitWorkflowID = @MaterialRequestSubmitWorkflowID
 END  
 
 GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01759', GETDATE())
GO
  