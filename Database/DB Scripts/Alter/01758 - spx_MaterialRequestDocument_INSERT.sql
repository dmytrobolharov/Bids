IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestDocument_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_MaterialRequestDocument_INSERT]
GO 

CREATE PROCEDURE [dbo].[spx_MaterialRequestDocument_INSERT] 
(   
  @MaterialDocumentID uniqueidentifier,  
  @MaterialID uniqueidentifier,  
  @MaterialTradePartnerID uniqueidentifier,  
  @MaterialTradePartnerColorID uniqueidentifier,  
  @MaterialRequestSubmitWorkflowID uniqueidentifier,  
  @MaterialDocumentName nvarchar(500),  
  @MaterialDocumentExt varchar(5),  
  @MaterialDocumentDescription nvarchar(4000),  
  @MaterialDocumentShared int,  
  @MaterialDocumentSize varchar(20),  
  @CreatedBy nvarchar(200),  
  @CreatedDate datetime )   
  AS    
  
  DECLARE @SystemServerStorageID uniqueidentifier  
 
 SET @SystemServerStorageID = ISNULL((SELECT TOP 1 SystemServerStorageID FROM sSystemServerStorageSetting WHERE CurrentServerStorage = 1),'00000000-0000-0000-0000-000000000000')    
 
 INSERT INTO pMaterialRequestDocument(  
  MaterialRequestDocumentID,  
  MaterialID,  
  MaterialTradePartnerID,
  MaterialTradePartnerColorID,
  MaterialRequestSubmitWorkflowID,
  MaterialDocumentName,  
  MaterialDocumentExt,  
  MaterialDocumentDescription,  
  MaterialDocumentShared,  
  MaterialDocumentSize,  
  CUser,   
  CDate,   
  MUser,   
  MDate,  
  SystemServerStorageID  
  )  
 VALUES (  
  @MaterialDocumentID,  
  @MaterialID, 
  @MaterialTradePartnerID,
  @MaterialTradePartnerColorID,
  @MaterialRequestSubmitWorkflowID, 
  @MaterialDocumentName,  
  @MaterialDocumentExt,  
  @MaterialDocumentDescription,  
  @MaterialDocumentShared,  
  @MaterialDocumentSize,  
  @CreatedBy,  
  @CreatedDate,  
  @CreatedBy,  
  @CreatedDate,  
  @SystemServerStorageID  
  )  
  
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01758', GETDATE())
GO