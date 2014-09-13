/****** Object:  Trigger [tgx_pPlanningType_PermissionMapping_INSERT]    Script Date: 06/26/2014 12:13:13 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_pPlanningType_PermissionMapping_INSERT]'))
DROP TRIGGER [dbo].[tgx_pPlanningType_PermissionMapping_INSERT]
GO

/****** Object:  Trigger [dbo].[tgx_pPlanningType_PermissionMapping_INSERT]    Script Date: 06/26/2014 12:13:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[tgx_pPlanningType_PermissionMapping_INSERT]
   ON  [dbo].[pPlanningType]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    BEGIN TRY
		DECLARE @PlanningFolderTypeID INT = 22
		
		DECLARE @PlanningTypeID UNIQUEIDENTIFIER
		DECLARE @PlanningTypeName NVARCHAR(200)
		DECLARE @CUser NVARCHAR(200)
		DECLARE @CDate DATETIME
		DECLARE @Active INT
		DECLARE @ProductTypeMapID INT
		
		DECLARE InsertedRows CURSOR SCROLL FOR
		SELECT PlanningTypeID, PlanningType, ISNULL(CUser, 'System'), ISNULL(CDate, CURRENT_TIMESTAMP), Active
		FROM inserted
		
		-- Select Planning workflows in a table
		DECLARE @PlanningWorkflowList TABLE
        (
          PlanningItemID UNIQUEIDENTIFIER,
          PlanningItemName NVARCHAR(200),
          PlanningItemDescription NVARCHAR(200),
          PlanningItemSort INT,
          Child INT
        )
        INSERT INTO @PlanningWorkflowList
        EXEC spx_PlanningFolderItem_SELECT
		
		OPEN InsertedRows
		FETCH NEXT FROM InsertedRows INTO @PlanningTypeID, @PlanningTypeName, @CUser, @CDate, @Active
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Inserting product type mapping for Line List Folder
			IF NOT EXISTS(SELECT * FROM sPermissionProductTypeMap 
							WHERE PermissionFolderTypeId = @PlanningFolderTypeID AND GuidProductTypeId = @PlanningTypeID)
			BEGIN
				INSERT INTO sPermissionProductTypeMap(PermissionFolderTypeId, GuidProductTypeId)
				VALUES(@PlanningFolderTypeID, @PlanningTypeID)
			END
			
			SELECT @ProductTypeMapID = PermissionProductTypeMapId FROM sPermissionProductTypeMap 
			WHERE PermissionFolderTypeId = @PlanningFolderTypeID AND GuidProductTypeId = @PlanningTypeID
			
			-- Inserting product types for current folder and all groups 
			INSERT INTO sPermissionProductType (PermissionFolderId, PermissionProductTypeMapId, PermissionProductTypeNotLocked, GroupId,
												CUser, CDate, MUser, MDate, Active, PermissionProductTypeName)
			SELECT PermissionFolderID, @ProductTypeMapID, 1, GroupId,
												@CUser, @CDate, @CUser, @CDate, @Active, @PlanningTypeName
			FROM sPermissionFolder pf
			WHERE PermissionFolderTypeId = @PlanningFolderTypeID 
			AND NOT EXISTS(SELECT * FROM sPermissionProductType WHERE PermissionFolderId = pf.PermissionFolderId 
							AND PermissionProductTypeMapId = @ProductTypeMapID)
							
			-- Inserting workflow with permissions for product types    
			INSERT INTO sPermissionWorkflow (PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId, WorkflowId,
											PermissionRoleId, PermissionView, PermissionCreate, PermissionRemove, PermissionModify, PermissionDelete,
											PermissionPrint, CUser, CDate, MUser, MDate, PermissionWorkflowName)
			SELECT PermissionFolderId, PermissionProductTypeId, pt.PermissionProductTypeMapId, GroupId, tpl.PlanningItemID,
					0, 0, 0, 0, 0, 0, 0, @CUser, @CDate, @CUser, @CDate, tpl.PlanningItemName
			FROM sPermissionProductType pt
			CROSS JOIN @PlanningWorkflowList tpl 
			WHERE pt.PermissionProductTypeMapId = @ProductTypeMapID
			AND NOT EXISTS(SELECT * FROM sPermissionWorkflow WHERE PermissionProductTypeId = pt.PermissionProductTypeId 
							AND WorkflowId = tpl.PlanningItemID)
		
			FETCH NEXT FROM InsertedRows INTO @PlanningTypeID, @PlanningTypeName, @CUser, @CDate, @Active		
		END
		
		CLOSE InsertedRows
		DEALLOCATE InsertedRows
		
    END TRY
    BEGIN CATCH
		PRINT 'An error has occured in trigger ' + ERROR_PROCEDURE() + '. '
		PRINT ERROR_MESSAGE()
	END CATCH

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08091', GetDate())
GO