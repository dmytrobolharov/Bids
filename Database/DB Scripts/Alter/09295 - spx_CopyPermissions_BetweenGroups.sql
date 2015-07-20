IF OBJECT_ID(N'[dbo].[spx_CopyPermissions_BetweenGroups]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_CopyPermissions_BetweenGroups]
GO

/************************************************************************************************
* Name  : spx_CopyPermissions_BetweenGroups
* Author: 
* Creation date: 
* Description :	
*
*           
* Change History:                  
* 
* Comment#		Date				Author						Comment
*    01			01/31/2015			Andrey Dmitrienko			fixed issue "column name or number of supplied values does not match table definition"
*
*************************************************************************************************/

CREATE PROCEDURE [dbo].[spx_CopyPermissions_BetweenGroups] 
 @GroupIdFrom	UNIQUEIDENTIFIER,
 @GroupIdTo		UNIQUEIDENTIFIER,
 @CUser			NVARCHAR(400) = NULL,
 @CDate			DATETIME = NULL

AS
  DECLARE @NewPermissionFolderId UNIQUEIDENTIFIER
  DECLARE @SourcePermissionFolderId UNIQUEIDENTIFIER
  DECLARE @PermissionFolderTypeId INT
  DECLARE @PermissionFolderNotLocked INT
  DECLARE @NewPermissionProductTypeId UNIQUEIDENTIFIER
  DECLARE @SourcePermissionProductTypeId UNIQUEIDENTIFIER
  DECLARE @PermissionProductTypeMapId INT
  DECLARE @PermissionProductTypeNotLocked INT
  DECLARE @PermissionProductTypeName NVARCHAR(512)
  DECLARE @Active INT
BEGIN
  -- SET NOCOUNT ON added to prevent extra result sets from
  -- interfering with SELECT statements.
  SET NOCOUNT ON;

  -- clear existing group permissions
  DELETE FROM sPermissionWorkflow WHERE GroupId = @GroupIdTo
  DELETE FROM sPermissionProductType WHERE GroupId = @GroupIdTo
  DELETE FROM sPermissionFolder WHERE GroupId = @GroupIdTo

  -- copy permissions from source group
  DECLARE SourceFoldersList CURSOR LOCAL FAST_FORWARD READ_ONLY FOR
   SELECT PermissionFolderId, PermissionFolderTypeId, PermissionFolderNotLocked
   FROM sPermissionFolder
   WHERE GroupId = @GroupIdFrom

  OPEN SourceFoldersList
  FETCH NEXT FROM SourceFoldersList 
  INTO @SourcePermissionFolderId, @PermissionFolderTypeId, @PermissionFolderNotLocked
  WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @NewPermissionFolderId = NEWID()
	INSERT INTO sPermissionFolder(
	   PermissionFolderId, PermissionFolderTypeId, GroupId, PermissionFolderNotLocked, CUser, CDate, MUser, MDate)
	VALUES(@NewPermissionFolderId, @PermissionFolderTypeId, @GroupIdTo, @PermissionFolderNotLocked,
	       @CUser, @CDate, @CUser, @CDate)

	-- copy product type permissions
	DECLARE SourceProductTypesList CURSOR LOCAL FAST_FORWARD READ_ONLY FOR
     SELECT PermissionProductTypeId, PermissionProductTypeMapId, PermissionProductTypeNotLocked,
            PermissionProductTypeName, Active
	 FROM sPermissionProductType
	 WHERE PermissionFolderId = @SourcePermissionFolderId
    
	OPEN SourceProductTypesList
	FETCH NEXT FROM SourceProductTypesList
	INTO @SourcePermissionProductTypeId, @PermissionProductTypeMapId, 
		 @PermissionProductTypeNotLocked, @PermissionProductTypeName, @Active
	WHILE @@FETCH_STATUS = 0
	BEGIN
	  SET @NewPermissionProductTypeId = NEWID()
	  INSERT INTO sPermissionProductType(
	     PermissionProductTypeId, PermissionFolderId, GroupId, PermissionProductTypeMapId, 
		 PermissionProductTypeNotLocked, PermissionProductTypeName, Active, CUser, CDate, MUser, MDate)
	  VALUES(@NewPermissionProductTypeId, @NewPermissionFolderId, @GroupIdTo, @PermissionProductTypeMapId, 
		     @PermissionProductTypeNotLocked, @PermissionProductTypeName, @Active, 
			 @CUser, @CDate, @CUser, @CDate)
	  -- copy product type workflow permissions
	  INSERT INTO sPermissionWorkflow(
	      PermissionWorkflowId, PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, 
		  GroupId, WorkflowId, PermissionRoleId, PermissionView, PermissionCreate, PermissionRemove, 
		  PermissionModify, PermissionDelete, PermissionPrint, CUser, CDate, MUser, MDate, PermissionWorkflowName, 
		  ParentWorkflowID, Active)
	  SELECT NEWID(), @NewPermissionFolderId, @NewPermissionProductTypeId, PermissionProductTypeMapId, 
			 @GroupIdTo, WorkflowId, PermissionRoleId, PermissionView, PermissionCreate, PermissionRemove, 
			 PermissionModify, PermissionDelete, PermissionPrint, @CUser, @CDate, @CUser, @CDate, 
			 PermissionWorkflowName, ParentWorkflowID, Active
	  FROM sPermissionWorkflow
	  WHERE PermissionProductTypeId = @SourcePermissionProductTypeId

	  FETCH NEXT FROM SourceProductTypesList
	  INTO @SourcePermissionProductTypeId, @PermissionProductTypeMapId, 
		   @PermissionProductTypeNotLocked, @PermissionProductTypeName, @Active
    END

	CLOSE SourceProductTypesList
	DEALLOCATE SourceProductTypesList

	FETCH NEXT FROM SourceFoldersList 
    INTO @SourcePermissionFolderId, @PermissionFolderTypeId, @PermissionFolderNotLocked
  END

  CLOSE SourceFoldersList
  DEALLOCATE SourceFoldersList

  -- add folders that are not in the original group
  INSERT INTO sPermissionFolder(
	 PermissionFolderId, PermissionFolderTypeId, GroupId, PermissionFolderNotLocked, 
	 CUser, CDate, MUser, MDate)
  SELECT @NewPermissionFolderId, t.PermissionFolderTypeId,  @GroupIdTo, 0, 
		 @CUser, @CDate, @CUser, @CDate
  FROM sPermissionFolderType t
  WHERE NOT EXISTS(SELECT * FROM sPermissionFolder f
				   WHERE f.GroupId = @GroupIdTo AND 
						 f.PermissionFolderTypeId = t.PermissionFolderTypeId)

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09295', GetDate())
GO


