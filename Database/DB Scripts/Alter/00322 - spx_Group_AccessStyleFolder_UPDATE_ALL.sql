IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_AccessStyleFolder_UPDATE_ALL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_AccessStyleFolder_UPDATE_ALL]
GO 


CREATE PROCEDURE [dbo].[spx_Group_AccessStyleFolder_UPDATE_ALL]  (  
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
@AccessStyleId uniqueidentifier   
)  
AS   

DECLARE @StyleTypeId INT
SET   @StyleTypeId = (SELECT StyleTypeId FROM sAccessGroupStyleFolder WHERE AccessStyleId = @AccessStyleId)

 UPDATE sAccessGroupStyleFolder    
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
 WHERE AccessStyleId = @AccessStyleId

UPDATE sAccessStyleWorkflow    
 SET AccessRoleId = @AccessRoleId,   
 AccessView = @AccessView,    
 AccessCreate = @AccessCreate,    
 AccessModify = @AccessModify,   
 AccessRemove = @AccessRemove,   
 AccessDelete = @AccessDelete,    
 AccessPrint = @AccessPrint,   
 MUser = @MUser,    
 MDate = @MDate    
 WHERE StyleTypeId = @StyleTypeId AND GroupID = @GroupID


exec spx_Workflow_AccessFolderUserPermissions_UPDATE @StyleTypeId, @GroupID , @MUser , @MDate 


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '322', GetDate())