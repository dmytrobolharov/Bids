IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_AccessStyleWorkflowFolder_Update]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_AccessStyleWorkflowFolder_Update]
GO
CREATE PROCEDURE [dbo].[spx_AccessStyleWorkflowFolder_Update] (
	@WorkflowID uniqueidentifier,  
	@StyleTypeID int,
	@AccessRoleId int,   
	@AccessView int,   
	@AccessCreate int,   
	@AccessModify int,   
	@AccessRemove int,   
	@AccessDelete int,   
	@AccessPrint int,   
	@GroupID uniqueidentifier, 
	@TeamID uniqueidentifier,  
	@AccessStyleId uniqueidentifier,
	@MUser nvarchar(200),    
	@MDate datetime    
)    
AS    
BEGIN
   
	IF (SELECT COUNT(*) FROM sAccessStyleWorkflowFolder WITH (NOLOCK) WHERE StyleTypeId = @StyleTypeID  AND GroupID = @GroupID AND WorkflowID = @WorkflowID AND TeamId = @TeamID) = 0    
		BEGIN    
			INSERT INTO sAccessStyleWorkflowFolder    
			 (AccessStyleId, StyleTypeID, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessRemove, AccessDelete, AccessPrint,
			  WorkflowID, TeamId, CUser, CDate, MUser, MDate, GroupID)    
			Values (@AccessStyleId, @StyleTypeID, @AccessRoleId, @AccessView, @AccessCreate, @AccessModify, @AccessRemove, @AccessDelete, @AccessPrint,
			  @WorkflowID, @TeamID, @MUser, @MDate, @MUser, @MDate, @GroupID)   
		END    
	ELSE
		BEGIN    
			UPDATE sAccessStyleWorkflowFolder    
			SET AccessStyleId = @AccessStyleId, StyleTypeID = @StyleTypeID, AccessRoleId = @AccessRoleId, AccessView = @AccessView, 
			AccessCreate = @AccessCreate, AccessModify = @AccessModify, AccessRemove = @AccessRemove, AccessDelete = @AccessDelete, AccessPrint = @AccessPrint,
			WorkflowID = @WorkflowID, TeamId = @TeamID, CUser = @MUser, CDate = @MDate, MUser = @MUser, MDate = @MDate, GroupID = @GroupID
			WHERE StyleTypeId = @StyleTypeID  AND GroupID = @GroupID AND WorkflowID = @WorkflowID AND TeamId = @TeamID
		END 
    
END    
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01171', GetDate())
GO