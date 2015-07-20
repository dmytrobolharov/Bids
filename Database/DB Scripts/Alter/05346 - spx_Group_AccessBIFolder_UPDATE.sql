IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_AccessBIFolder_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_AccessBIFolder_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_Group_AccessBIFolder_UPDATE]  (  
@AccessRoleId int  ,   
@AccessView int ,   
@AccessCreate int ,   
@AccessModify int,   
@AccessRemove int ,   
@AccessDelete int ,   
@AccessPrint int ,   
@GroupID uniqueidentifier ,   
@MUser nvarchar (200),   
@MDate  datetime ,   
@AccessBIId uniqueidentifier   
)  
AS   
  
 UPDATE sAccessBIFolder    
 SET AccessRoleId = @AccessRoleId,   
 AccessView = @AccessView,    
 AccessCreate = @AccessCreate,    
 AccessModify = @AccessModify,   
 AccessRemove = @AccessRemove,   
 AccessDelete = @AccessDelete,    
 AccessPrint = @AccessPrint,   
 GroupID = @GroupID,   
 MUser = @MUser,    
 MDate = @MDate    
 WHERE AccessBIId = @AccessBIId
 
 
 UPDATE sAccessBIItemsFolder    
 SET AccessRoleId = @AccessRoleId,   
 AccessView = @AccessView,    
 AccessCreate = @AccessCreate,    
 AccessModify = @AccessModify,   
 AccessRemove = @AccessRemove,   
 AccessDelete = @AccessDelete,    
 AccessPrint = @AccessPrint,   
 MUser = @MUser,    
 MDate = @MDate    
 WHERE AccessBIId = @AccessBIId AND GroupID = @GroupID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05346', GetDate())
GO
