IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Workflow_AccessStyleFolder_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Workflow_AccessStyleFolder_UPDATE]
GO  


CREATE PROCEDURE dbo.spx_Workflow_AccessStyleFolder_UPDATE  (  
@AccessRoleId int  ,   
@AccessView int ,   
@AccessCreate int ,   
@AccessModify int,   
@AccessRemove int ,   
@AccessDelete int ,   
@AccessPrint int , 
@MUser nvarchar (200),   
@MDate  datetime ,   
@AccessStyleWorkflowID uniqueidentifier   
)  
AS   
  
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
 WHERE AccessStyleWorkflowID = @AccessStyleWorkflowID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '276', GetDate()) 