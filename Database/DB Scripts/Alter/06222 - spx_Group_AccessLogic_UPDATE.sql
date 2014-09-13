/****** Object:  StoredProcedure [dbo].[spx_Group_AccessLogic_UPDATE]    Script Date: 08/23/2013 15:55:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_AccessLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_AccessLogic_UPDATE]
GO
/****** Object:  StoredProcedure [dbo].[spx_Group_AccessLogic_UPDATE]    Script Date: 08/23/2013 15:55:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_Group_AccessLogic_UPDATE] (
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
		SELECT NEWID() AS AccessStyleID, StyleTypeID, 2 , 1, 0 , 0, 0 , 1, 0, @GroupID , @MUser,@MDate, @MUser,@MDate 
		FROM pStyleType
	END 
	ELSE IF @DeskFolderId  = 3
	BEGIN 
		-- select * from  sAccessGroupLineFolder
		DELETE FROM  sAccessGroupLineFolder WHERE GroupID = @GroupID 
		Declare @LineListTypeID uniqueidentifier
		SELECT TOP 1 @LineListTypeID = LineListTypeID FROM pLineListType
		
		INSERT INTO sAccessGroupLineFolder (AccessLineID, LineTypeID , AccessRoleID , AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint,  GroupID , CUser, CDate, MUser, MDate ) 
		values ( NEWID() ,@LineListTypeID , 2 ,  1, 0 , 0, 0 , 1, @GroupID , @MUser,@MDate, @MUser,@MDate )
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
		-- select * from  sAccessGroupFlashEditFolder  
		DELETE FROM  sAccessGroupFlashEditFolder WHERE GroupID = @GroupID  
		INSERT INTO sAccessGroupFlashEditFolder (AccessFlashEditId, FlashEditFolderItemId, AccessRoleID , AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint, GroupID , CUser, CDate, MUser, MDate ) 
		SELECT NEWID() AS AccessFlashEditId, FlashEditFolderItemId, 2  ,   1, 0 , 0, 0 , 1, @GroupID , @MUser,@MDate, @MUser,@MDate 
		FROM pFlashEditFolderItem
	END
	ELSE IF @DeskFolderId  = 16
	BEGIN
		-- select * from sAccessGroupBatchQueue 
		DELETE FROM sAccessGroupBatchQueue WHERE GroupID = @GroupID 
		INSERT INTO sAccessGroupBatchQueue (AccessBatchQueueID, BatchQueueTypeId, AccessRoleID, AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint, GroupID, CUser, CDate, MUser, MDate) 
		SELECT NEWID() AS AccessBatchQueueID, BatchQueueTypeID, 2, 1, 0, 0, 0, 1, @GroupID, @MUser, @MDate, @MUser, @MDate 
		FROM bBatchQueueType
	END	
	ELSE IF @DeskFolderId  = 19
	BEGIN 
		DELETE FROM  sAccessGroupSourcingFolder WHERE GroupID = @GroupID 
		Declare @SourcingTypeID uniqueidentifier
		SELECT TOP 1 @SourcingTypeID = SourcingTypeId FROM pSourcingType
		INSERT INTO sAccessGroupSourcingFolder (AccessSourcingID, SourcingTypeId , AccessRoleID , AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint,  GroupID , CUser, CDate, MUser, MDate ) 
		values ( NEWID(), @SourcingTypeID, 2, 1, 0 , 0, 0 , 1, @GroupID , @MUser,@MDate, @MUser,@MDate )
	END 
	exec spx_Group_AccessUserPermissions_UPDATE @GroupID, @MUser, @MDate

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06222', GetDate())
GO
