IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SystemServerStorageMaterialRequest_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_SystemServerStorageMaterialRequest_SELECT]
GO 

  
CREATE PROCEDURE [dbo].[spx_SystemServerStorageMaterialRequest_SELECT](@MaterialRequestDocumentId uniqueidentifier)  
AS   
  
IF (SELECT COUNT(*) FROM pMaterialRequestDocument WHERE MaterialRequestDocumentId = @MaterialRequestDocumentId) = 0  
 BEGIN  
  SELECT TOP 1   
   sSystemServerStorageSetting.MaterialPath    
   FROM sSystemServerStorageSetting   
  WHERE CurrentServerStorage = 1  
 END  
ELSE  
 BEGIN  
  SELECT   
   sSystemServerStorageSetting.MaterialPath    
  FROM pMaterialRequestDocument WITH (NOLOCK) INNER JOIN  
     sSystemServerStorageSetting WITH (NOLOCK) ON pMaterialRequestDocument.SystemServerStorageID = sSystemServerStorageSetting.SystemServerStorageID  
  WHERE (pMaterialRequestDocument.MaterialRequestDocumentId = @MaterialRequestDocumentId)    
 END 
 
  
 GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01760', GETDATE())
GO
     
  
  
  
  