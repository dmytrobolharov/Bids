IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_DesktopAccessStyleWorkflowFolderCheck_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_DesktopAccessStyleWorkflowFolderCheck_INSERT]
GO 
  
CREATE PROCEDURE [dbo].[spx_Group_DesktopAccessStyleWorkflowFolderCheck_INSERT] (    
@AccessStyleId uniqueidentifier,   
@AccessRoleId int,  
@StyleTypeID int,  
@GroupID uniqueidentifier, 
@TeamID uniqueidentifier, 
@CreatedBy nvarchar(200),    
@CreatedDate datetime    
)    
AS    
    
DECLARE @I as int    
DECLARE @Row_Count int    
DECLARE @StyleTypeIDVal int    
  
DECLARE @I_WF as int    
DECLARE @Row_Count_WF int    
DECLARE @WorkflowIDVal uniqueidentifier   
   
DECLARE @DeskAccessId int    
DECLARE @DeskTableName varchar(100)    
DECLARE @DeskTableKey varchar(50)    
    
    
 BEGIN    
 CREATE TABLE #TempGroupAccess (    
  Id int IDENTITY (1, 1) NOT NULL ,     
  StyleTypeID int NOT NULL,    
  GroupID uniqueidentifier     
 )     
 END    
    
 BEGIN    
     
 INSERT INTO #TempGroupAccess( StyleTypeID) SELECT StyleTypeID FROM pStyleType    
     
     
 SET @Row_Count = (SELECT COUNT(*) FROM #TempGroupAccess)    
     
 SET @I = 1    
    
 WHILE @I <= @Row_Count     
  BEGIN    
    
   SELECT @StyleTypeIDVal = StyleTypeID FROM #TempGroupAccess WHERE ID = @I    
   IF (SELECT COUNT(*) FROM sAccessGroupStyleFolder WITH (NOLOCK) WHERE StyleTypeId = @StyleTypeIDVal  AND GroupID = @GroupID ) = 0    
   BEGIN    
    INSERT INTO sAccessGroupStyleFolder    
     ( StyleTypeId, GroupID, CUser, CDate, MUser, MDate)    
    SELECT StyleTypeId, @GroupID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate     
    FROM  #TempGroupAccess WHERE Id = @I    
   END    
        
   SET @I = @I + 1    
  END    
    
  SELECT * FROM #tempGroupAccess    
   
 CREATE TABLE #TempWorkflowAccess (    
  Id int IDENTITY (1, 1) NOT NULL ,     
  WorkflowID uniqueidentifier    
 )     
 END    
    
 BEGIN    
     
 INSERT INTO #TempWorkflowAccess(WorkflowID) SELECT WorkflowID FROM pWorkflow     
     
     
 SET @Row_Count_WF = (SELECT COUNT(*) FROM #TempWorkflowAccess)    
     
 SET @I_WF = 1    
    
 WHILE @I_WF <= @Row_Count_WF     
  BEGIN    
    
   SELECT @WorkflowIDVal = WorkflowID FROM #TempWorkflowAccess WHERE ID = @I_WF    
   IF (SELECT COUNT(*) FROM sAccessStyleWorkflow WITH (NOLOCK) WHERE StyleTypeId = @StyleTypeID  AND GroupID = @GroupID AND WorkflowID = @WorkflowIDVal) = 0    
   BEGIN    
    INSERT INTO sAccessStyleWorkflow    
     ( AccessStyleId, AccessRoleId, StyleTypeID, GroupID, WorkflowID, CUser, CDate, MUser, MDate)    
    SELECT @AccessStyleId, @AccessRoleId, @StyleTypeID, @GroupID, WorkflowID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate     
    FROM  #TempWorkflowAccess WHERE Id = @I_WF    
   END    
        
   SET @I_WF = @I_WF + 1    
  END    
    
  SELECT * FROM #TempWorkflowAccess    


------------New Changes------------------
DECLARE @I_WF_2 as int    
DECLARE @Row_Count_WF_2 int    
DECLARE @WorkflowFolderIDVal uniqueidentifier
 
CREATE TABLE #TempWorkflowFolderAccess (    
  Id int IDENTITY (1, 1) NOT NULL ,     
  WorkflowID uniqueidentifier    
 )     
 END    
    
 BEGIN    
     
 INSERT INTO #TempWorkflowFolderAccess(WorkflowID) SELECT WorkflowID FROM pWorkflow     
     
     
 SET @Row_Count_WF_2 = (SELECT COUNT(*) FROM #TempWorkflowFolderAccess)    
     
 SET @I_WF_2 = 1    
    
 WHILE @I_WF_2 <= @Row_Count_WF_2     
  BEGIN    
    
   SELECT @WorkflowFolderIDVal = WorkflowID FROM #TempWorkflowFolderAccess WHERE ID = @I_WF_2    
   IF (SELECT COUNT(*) FROM sAccessStyleWorkflowFolder WITH (NOLOCK) WHERE StyleTypeId = @StyleTypeID  AND GroupID = @GroupID AND WorkflowID = @WorkflowFolderIDVal) = 0    
   BEGIN    
    INSERT INTO sAccessStyleWorkflowFolder    
     ( AccessStyleId, AccessRoleId, StyleTypeID, GroupID, WorkflowID, CUser, CDate, MUser, MDate, TeamID)    
    SELECT @AccessStyleId, @AccessRoleId, @StyleTypeID, @GroupID, WorkflowID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, @TeamID     
    FROM  #TempWorkflowFolderAccess WHERE Id = @I_WF_2    
   END    
        
   SET @I_WF_2 = @I_WF_2 + 1    
  END    
    
  SELECT * FROM #TempWorkflowFolderAccess  


    
 END    

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '324', GetDate())
    