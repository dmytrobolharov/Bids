
ALTER PROCEDURE [dbo].[spx_Group_AccessLogic_UPDATE] (
@DeskGroupAccessId uniqueidentifier,
@MUser nvarchar(200),
@MDate datetime
)
AS
BEGIN 

	DECLARE @DeskFolderId int
	DECLARE @GroupID  uniqueidentifier

	SELECT @DeskFolderId = DeskFolderId, @GroupID = GroupID FROM cDeskGroupFolderAccess 
	WHERE  DeskGroupAccessId = @DeskGroupAccessId


	--  DEFAULT PERMISSIONS
	IF  @DeskFolderId  = 2  
	BEGIN
		-- select * from sAccessGroupStyleFolder
		DELETE FROM  sAccessGroupStyleFolder  WHERE GroupID = @GroupID 
		INSERT INTO sAccessGroupStyleFolder (AccessStyleID, StyleTypeID , AccessRoleID , AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint, AccessRemove, GroupID , CUser, CDate, MUser, MDate ) 
		SELECT NEWID() AS AccessStyleID, StyleTypeID, 2  ,   1, 0 , 0, 0 , 1, 0, @GroupID , @MUser,@MDate, @MUser,@MDate 
		FROM pStyleType
	END 
	ELSE IF @DeskFolderId  = 3
	BEGIN 
		-- select * from  sAccessGroupLineFolder
		DELETE FROM  sAccessGroupLineFolder WHERE GroupID = @GroupID 
		INSERT INTO sAccessGroupLineFolder (AccessLineID, LineTypeID , AccessRoleID , AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint,  GroupID , CUser, CDate, MUser, MDate ) 
		values ( NEWID() , 1 , 2  ,  1, 0 , 0, 0 , 1, @GroupID , @MUser,@MDate, @MUser,@MDate )
	END 
	ELSE IF @DeskFolderId  = 4
	BEGIN 
		-- select * from  sAccessGroupQuotationFolder 
		DELETE FROM  sAccessGroupQuotationFolder WHERE GroupID = @GroupID 
		INSERT INTO sAccessGroupQuotationFolder(AccessQuotationID , StyleTypeID , AccessRoleID , AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint, GroupID , CUser, CDate, MUser, MDate ) 
		SELECT NEWID() AS AccessQuotationID, StyleTypeID, 2  ,   1, 0 , 0, 0 , 1, @GroupID , @MUser,@MDate, @MUser,@MDate 
		FROM pStyleType
	END 
	ELSE IF @DeskFolderId  = 5
	BEGIN 
		-- select * from  sAccessGroupSampleFolder 
		DELETE FROM  sAccessGroupSampleFolder WHERE GroupID = @GroupID 
		INSERT INTO sAccessGroupSampleFolder (AccessSampleID, SampleTypeID, AccessRoleID , AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint, AccessRemove, GroupID , CUser, CDate, MUser, MDate ) 
		SELECT NEWID() AS AccessSampleID , SampleWorkflowID , 2 , 1, 0 , 0, 0 , 1, 0, @GroupID , @MUser,@MDate, @MUser,@MDate 
		FROM pSampleWorkflow
	END 
	ELSE IF @DeskFolderId  = 6
	BEGIN
		-- select * from  sAccessGroupImageFolder  
		DELETE FROM  sAccessGroupImageFolder WHERE GroupID = @GroupID 
		INSERT INTO sAccessGroupImageFolder (AccessImageId, ImageTypeId, AccessRoleID , AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint, GroupID , CUser, CDate, MUser, MDate ) 
		SELECT NEWID() AS AccessImageId, ImageTypeID, 2  ,   1, 0 , 0, 0 , 1, @GroupID , @MUser,@MDate, @MUser,@MDate 
		FROM pImageType
	END 
	ELSE IF @DeskFolderId  = 7
	BEGIN 
		-- select * from  sAccessGroupColorFolder  
		DELETE FROM  sAccessGroupColorFolder WHERE GroupID = @GroupID 
		INSERT INTO sAccessGroupColorFolder(AccessColorID, ColorTypeID , AccessRoleID , AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint,  GroupID , CUser, CDate, MUser, MDate ) 
		values ( NEWID() , 1 , 2  ,  1, 0 , 0, 0 , 1, @GroupID , @MUser,@MDate, @MUser,@MDate )
	END
	ELSE IF @DeskFolderId  = 8
	BEGIN
		-- select * from  sAccessGroupMaterialFolder
		DELETE FROM  sAccessGroupMaterialFolder WHERE GroupID = @GroupID  
		INSERT INTO sAccessGroupMaterialFolder(AccessMaterialId, ComponentTypeId, AccessRoleID , AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint, GroupID , CUser, CDate, MUser, MDate ) 
		SELECT NEWID() AS AccessMaterialId, ComponentTypeID, 2  ,   1, 0 , 0, 0 , 1, @GroupID , @MUser,@MDate, @MUser,@MDate 
		FROM pComponentType
	END
	ELSE IF @DeskFolderId  = 9
	BEGIN
		-- select * from  sAccessGroupComplianceFolder  
		DELETE FROM  sAccessGroupComplianceFolder WHERE GroupID = @GroupID  
		INSERT INTO sAccessGroupComplianceFolder (AccessComplianceFolderID, ComplianceTypeId, AccessRoleID , AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint, GroupID , CUser, CDate, MUser, MDate ) 
		SELECT NEWID() AS AccessComplianceFolderID, ComplianceTypeID, 2  ,   1, 0 , 0, 0 , 1, @GroupID , @MUser,@MDate, @MUser,@MDate 
		FROM pComplianceType
	END
	ELSE IF @DeskFolderId  = 10
	BEGIN
		-- select * from  sAccessGroupControlPanel  
		DELETE FROM  sAccessGroupControlPanel WHERE GroupID = @GroupID  
		INSERT INTO sAccessGroupControlPanel(AccessGroupControlPanelId, ControlPanelId, AccessRoleID , AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint, GroupID , CUser, CDate, MUser, MDate ) 
		SELECT NEWID() AS AccessGroupControlPanelId, ControlPanelId , 2  ,   1, 0 , 0, 0 , 1, @GroupID , @MUser,@MDate, @MUser,@MDate 
		FROM pControlPanel
	END
	ELSE IF @DeskFolderId  = 11
	BEGIN 
		-- select * from  sAccessGroupShareFolder  
		DELETE FROM  sAccessGroupShareFolder WHERE GroupID = @GroupID  
		INSERT INTO sAccessGroupShareFolder (AccessShareID, ShareTypeID , AccessRoleID , AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint,  GroupID , CUser, CDate, MUser, MDate ) 
		values ( NEWID() , 1 , 2  ,  1, 0 , 0, 0 , 1, @GroupID , @MUser,@MDate, @MUser,@MDate )
	END
	ELSE IF @DeskFolderId  = 12
	BEGIN 
		-- select * from  sAccessGroupCosting 
		DELETE FROM  sAccessGroupCosting WHERE GroupID = @GroupID 
		INSERT INTO sAccessGroupCosting (AccessCostingID, StyleTypeID , AccessRoleID , AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint, GroupID , CUser, CDate, MUser, MDate ) 
		SELECT NEWID() AS AccessStyleID, StyleTypeID, 2  ,   1, 0 , 0, 0 , 1, @GroupID , @MUser,@MDate, @MUser,@MDate 
		FROM pStyleType
	END
	ELSE IF @DeskFolderId  = 15
	BEGIN
		-- select * from  sAccessGroupQuickBatchReplaceFolder  
		DELETE FROM  sAccessGroupQuickBatchReplaceFolder WHERE GroupID = @GroupID  
		INSERT INTO sAccessGroupQuickBatchReplaceFolder (AccessQuickBRID, QuickBRTypeId, AccessRoleID , AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint, GroupID , CUser, CDate, MUser, MDate ) 
		SELECT NEWID() AS AccessQuickBRFolderID, QuickBRTypeID, 2  ,   1, 0 , 0, 0 , 1, @GroupID , @MUser,@MDate, @MUser,@MDate 
		FROM pQuickBatchReplaceType
	END

	exec spx_Group_AccessUserPermissions_UPDATE @GroupID, @MUser, @MDate

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '3.0.0000', '124', GetDate())
GO

