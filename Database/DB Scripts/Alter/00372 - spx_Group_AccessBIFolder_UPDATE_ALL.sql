IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_AccessBIFolder_UPDATE_ALL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_AccessBIFolder_UPDATE_ALL]
GO

CREATE PROCEDURE [dbo].[spx_Group_AccessBIFolder_UPDATE_ALL]  (    
@AccessRoleId int  ,     
@AccessView int ,     
@AccessCreate int ,     
@AccessModify int,     
@AccessRemove int ,     
@AccessDelete int ,     
@AccessPrint int ,     
@GroupID uniqueidentifier ,   
@TeamID uniqueidentifier ,    
@MUser nvarchar (200),     
@MDate  datetime ,     
@AccessBIId uniqueidentifier     
)    
AS     
  
DECLARE @BITypeID INT  
SET   @BITypeID = (SELECT BITypeId FROM sAccessBIFolder WHERE AccessBIId = @AccessBIId)  
  

EXEC spx_Group_DesktopAccessBIFolderCheck_INSERT @AccessBIId ,  @AccessRoleId, @BITypeID ,  @GroupID , @TeamID , @MUser ,   @MDate   
  
  
 UPDATE sAccessBIFolder      
 SET AccessRoleId = @AccessRoleId,     
 AccessView = @AccessView,      
 AccessCreate = @AccessCreate,      
 AccessModify = @AccessModify,     
 AccessRemove = @AccessRemove,     
 AccessDelete = @AccessDelete,      
 AccessPrint = @AccessPrint,     
 GroupID = @GroupID,
 TeamID = @TeamID,     
 MUser = @MUser,      
 MDate = @MDate      
 WHERE AccessBIId = @AccessBIId  
  

UPDATE sAccessBIItems      
 SET AccessRoleId = @AccessRoleId,     
 AccessView = @AccessView,      
 AccessCreate = @AccessCreate,      
 AccessModify = @AccessModify,     
 AccessRemove = @AccessRemove,     
 AccessDelete = @AccessDelete,      
 AccessPrint = @AccessPrint,     
 MUser = @MUser,      
 MDate = @MDate      
 WHERE BITypeId = @BITypeId AND GroupID = @GroupID  
    
 
exec spx_BIItem_AccessFolderUserPermissions_UPDATE @BITypeID, @GroupID , @MUser , @MDate   

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '372', GetDate())

GO
  

   
   
   
  
  