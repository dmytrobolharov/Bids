IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_AccessBatchQueueFolder_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_Group_AccessBatchQueueFolder_UPDATE]
GO

CREATE PROCEDURE dbo.spx_Group_AccessBatchQueueFolder_UPDATE  (  
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
@AccessBatchQId uniqueidentifier   
)  
AS   
  
 UPDATE sAccessGroupBatchQueueFolder    
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
 WHERE AccessBatchQueueId = @AccessBatchQId
 
 
 GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01559'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01559', GetDate())
END	

GO

