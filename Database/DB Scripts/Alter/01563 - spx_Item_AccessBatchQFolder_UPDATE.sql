IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Item_AccessBatchQFolder_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_Item_AccessBatchQFolder_UPDATE]
GO
  
 
CREATE PROCEDURE dbo.spx_Item_AccessBatchQFolder_UPDATE (    
@AccessRoleId int  ,     
@AccessView int ,     
@AccessCreate int ,     
@AccessModify int,     
@AccessRemove int ,     
@AccessDelete int ,     
@AccessPrint int ,   
@MUser nvarchar (200),     
@MDate  datetime ,     
@AccessBatchQItemID uniqueidentifier     
)    
AS     
    
 UPDATE sAccessBatchQItems      
 SET AccessRoleId = @AccessRoleId,     
 AccessView = @AccessView,      
 AccessCreate = @AccessCreate,      
 AccessModify = @AccessModify,     
 AccessRemove = @AccessRemove,     
 AccessDelete = @AccessDelete,      
 AccessPrint = @AccessPrint,     
 MUser = @MUser,      
 MDate = @MDate      
 WHERE AccessBatchQItemID = @AccessBatchQItemID  
  
  
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01563'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01563', GetDate())
END	

GO

