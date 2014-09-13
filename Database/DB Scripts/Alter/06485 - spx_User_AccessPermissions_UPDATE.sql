IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_AccessPermissions_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_User_AccessPermissions_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_User_AccessPermissions_UPDATE] (
	@TeamID UNIQUEIDENTIFIER
	, @FullName AS NVARCHAR(200)
	, @CDate AS DATETIME
	)

AS
	DECLARE @DeskFolderID INT
	DECLARE @InsertedRows INT

	/********************************************************************************************************************************************************************/
	-- STYLE FOLDER
	DELETE FROM sAccessStyleFolder where TeamID = @TeamID
	
	SET @DeskFolderID = 2

	INSERT INTO sAccessStyleFolder (StyleTypeId, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessRemove, AccessDelete, AccessPrint, TeamId, CUser, CDate, MUser, MDate)
	SELECT StyleTypeId, MAX(AccessRoleID), MAX(AccessView), MAX(AccessCreate), MAX(AccessModify), MAX(AccessRemove), MAX(AccessDelete), MAX(AccessPrint), @TeamID, @FullName, @CDate, @FullName, @CDate
	FROM sAccessGroupStyleFolder af
		INNER JOIN uUserGroup ug ON af.GroupID = ug.GroupID 
		INNER JOIN uGroup g ON ug.GroupID = g.GroupID AND g.Active = 1
		INNER JOIN cDeskGroupFolderAccess dg ON ug.GroupID = dg.GroupID AND dg.DeskAccessId = 1
	WHERE ug.TeamID = @TeamID AND dg.DeskFolderID = @DeskFolderID
	GROUP BY StyleTypeId
	
	SET @InsertedRows = @@ROWCOUNT
	
	DELETE FROM cDeskUserFolderAccess WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID		
	IF @InsertedRows > 0 
		INSERT INTO cDeskUserFolderAccess (DeskUserAccessID, DeskFolderId, DeskAccessID, TeamID, CUser, CDate, MUser, MDate)
		VALUES (NEWID(), @DeskFolderID, 1, @TeamID, @FullName, @CDate, @FullName, @CDate)

	/********************************************************************************************************************************************************************/
	-- LINEPLAN FOLDER
	DELETE FROM sAccessLinePlanFolder where TeamID = @TeamID 

	SET @DeskFolderID = 13
	
	INSERT INTO sAccessLinePlanFolder (LinePlanTemplateId, CustomID, AccessRoleId, AccessPlanView, AccessPlanNew, AccessPlanDelete, AccessHierView, AccessHierNew, AccessHierDelete, TeamId, CUser, CDate, MUser, MDate) 
	SELECT LinePlanTemplateId, CustomID, MAX(AccessRoleID), MAX(AccessPlanView), MAX(AccessPlanNew), MAX(AccessPlanDelete), MAX(AccessHierView), MAX(AccessHierNew), MAX(AccessHierDelete), @TeamID, @FullName, @CDate, @FullName, @CDate
	FROM sAccessGroupLinePlanFolder af
		INNER JOIN uUserGroup ug ON af.GroupID = ug.GroupID 
		INNER JOIN uGroup g ON ug.GroupID = g.GroupID AND g.Active = 1
		INNER JOIN cDeskGroupFolderAccess dg ON ug.GroupID = dg.GroupID AND dg.DeskAccessId = 1
	WHERE ug.TeamID = @TeamID AND dg.DeskFolderID = @DeskFolderID
	GROUP BY LinePlanTemplateId, CustomID 

	SET @InsertedRows = @@ROWCOUNT

	DELETE FROM cDeskUserFolderAccess WHERE TeamID = @TeamID and DeskFolderId = @DeskFolderId
	IF @InsertedRows > 0
		INSERT INTO cDeskUserFolderAccess (DeskUserAccessID, DeskFolderId, DeskAccessID, TeamID, CUser, CDate, MUser, MDate) 
		VALUES (NEWID(), @DeskFolderID, 1, @TeamID, @FullName, @CDate, @FullName, @CDate) 

	/********************************************************************************************************************************************************************/
	-- LINE FOLDER
	DELETE FROM sAccessLineFolder where TeamID = @TeamID
	
	SET @DeskFolderID = 3

	INSERT INTO sAccessLineFolder (LineTypeId, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint,TeamId, CUser, CDate, MUser, MDate)
	SELECT LineTypeId, MAX(AccessRoleID), MAX(AccessView), MAX(AccessCreate), MAX(AccessModify), MAX(AccessDelete), MAX(AccessPrint), @TeamID, @FullName, @CDate, @FullName, @CDate
	FROM sAccessGroupLineFolder af
		INNER JOIN uUserGroup ug ON af.GroupID = ug.GroupID 
		INNER JOIN uGroup g ON ug.GroupID = g.GroupID AND g.Active = 1
		INNER JOIN cDeskGroupFolderAccess dg ON ug.GroupID = dg.GroupID AND dg.DeskAccessId = 1
	WHERE ug.TeamID = @TeamID AND dg.DeskFolderID = @DeskFolderID
	GROUP BY LineTypeId

	SET @InsertedRows = @@ROWCOUNT

	DELETE FROM cDeskUserFolderAccess WHERE TeamID = @TeamID and DeskFolderId = @DeskFolderId
	IF @InsertedRows > 0
		INSERT INTO cDeskUserFolderAccess (DeskUserAccessID, DeskFolderId, DeskAccessID, TeamID, CUser, CDate, MUser, MDate) 
		VALUES (NEWID(), @DeskFolderID, 1, @TeamID, @FullName, @CDate, @FullName, @CDate)

	/********************************************************************************************************************************************************************/
	-- SOURCING FOLDER
	DELETE FROM sAccessSourcingFolder where TeamID = @TeamID
	
	SET @DeskFolderID = 19

	INSERT INTO sAccessSourcingFolder (SourcingTypeId, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint,TeamId, CUser, CDate, MUser, MDate)
	SELECT SourcingTypeId, MAX(AccessRoleID), MAX(AccessView), MAX(AccessCreate), MAX(AccessModify), MAX(AccessDelete), MAX(AccessPrint), @TeamID, @FullName, @CDate, @FullName, @CDate
	FROM sAccessGroupSourcingFolder af
		INNER JOIN uUserGroup ug ON af.GroupID = ug.GroupID 
		INNER JOIN uGroup g ON ug.GroupID = g.GroupID AND g.Active = 1
		INNER JOIN cDeskGroupFolderAccess dg ON ug.GroupID = dg.GroupID AND dg.DeskAccessId = 1
	WHERE ug.TeamID = @TeamID AND dg.DeskFolderID = @DeskFolderID
	GROUP BY SourcingTypeId

	SET @InsertedRows = @@ROWCOUNT

	DELETE FROM cDeskUserFolderAccess WHERE TeamID = @TeamID and DeskFolderId = @DeskFolderId
	IF @InsertedRows > 0
		INSERT INTO cDeskUserFolderAccess (DeskUserAccessID, DeskFolderId, DeskAccessID, TeamID, CUser, CDate, MUser, MDate) 
		VALUES (NEWID(), @DeskFolderID, 1, @TeamID, @FullName, @CDate, @FullName, @CDate)

	/********************************************************************************************************************************************************************/
	-- QUOTATION FOLDER
	DELETE FROM sAccessQuotationFolder where TeamID = @TeamID
	
	SET @DeskFolderID = 4

	INSERT INTO sAccessQuotationFolder (StyleTypeID, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint,TeamId, CUser, CDate, MUser, MDate)
	SELECT StyleTypeID, MAX(AccessRoleID), MAX(AccessView), MAX(AccessCreate), MAX(AccessModify), MAX(AccessDelete), MAX(AccessPrint), @TeamID, @FullName, @CDate, @FullName, @CDate
	FROM sAccessGroupQuotationFolder af
		INNER JOIN uUserGroup ug ON af.GroupID = ug.GroupID 
		INNER JOIN uGroup g ON ug.GroupID = g.GroupID AND g.Active = 1
		INNER JOIN cDeskGroupFolderAccess dg ON ug.GroupID = dg.GroupID AND dg.DeskAccessId = 1
	WHERE ug.TeamID = @TeamID AND dg.DeskFolderID = @DeskFolderID
	GROUP BY StyleTypeID

	SET @InsertedRows = @@ROWCOUNT

	DELETE FROM cDeskUserFolderAccess WHERE TeamID = @TeamID and DeskFolderId = @DeskFolderId
	IF @InsertedRows > 0
		INSERT INTO cDeskUserFolderAccess (DeskUserAccessID, DeskFolderId, DeskAccessID, TeamID, CUser, CDate, MUser, MDate) 
		VALUES (NEWID(), @DeskFolderID, 1, @TeamID, @FullName, @CDate, @FullName, @CDate)

	/********************************************************************************************************************************************************************/
	-- SAMPLE FOLDER
	DELETE FROM sAccessSampleFolder where TeamID = @TeamID
	
	SET @DeskFolderID = 5

	INSERT INTO sAccessSampleFolder (SampleTypeId, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessRemove, AccessDelete, AccessPrint,TeamId, CUser, CDate, MUser, MDate)
	SELECT SampleTypeId, MAX(AccessRoleID), MAX(AccessView), MAX(AccessCreate), MAX(AccessModify), MAX(AccessRemove), MAX(AccessDelete), MAX(AccessPrint), @TeamID, @FullName, @CDate, @FullName, @CDate
	FROM sAccessGroupSampleFolder af
		INNER JOIN uUserGroup ug ON af.GroupID = ug.GroupID 
		INNER JOIN uGroup g ON ug.GroupID = g.GroupID AND g.Active = 1
		INNER JOIN cDeskGroupFolderAccess dg ON ug.GroupID = dg.GroupID AND dg.DeskAccessId = 1
	WHERE ug.TeamID = @TeamID AND dg.DeskFolderID = @DeskFolderID
	GROUP BY SampleTypeId

	SET @InsertedRows = @@ROWCOUNT

	DELETE FROM cDeskUserFolderAccess WHERE TeamID = @TeamID and DeskFolderId = @DeskFolderId
	IF @InsertedRows > 0
		INSERT INTO cDeskUserFolderAccess (DeskUserAccessID, DeskFolderId, DeskAccessID, TeamID, CUser, CDate, MUser, MDate) 
		VALUES (NEWID(), @DeskFolderID, 1, @TeamID, @FullName, @CDate, @FullName, @CDate)

	/********************************************************************************************************************************************************************/
	-- IMAGE FOLDER
	DELETE FROM sAccessImageFolder where TeamID = @TeamID
	
	SET @DeskFolderID = 6

	INSERT INTO sAccessImageFolder (ImageTypeId, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint,TeamId, CUser, CDate, MUser, MDate)
	SELECT ImageTypeId, MAX(AccessRoleID), MAX(AccessView), MAX(AccessCreate), MAX(AccessModify), MAX(AccessDelete), MAX(AccessPrint), @TeamID, @FullName, @CDate, @FullName, @CDate
	FROM sAccessGroupImageFolder af
		INNER JOIN uUserGroup ug ON af.GroupID = ug.GroupID 
		INNER JOIN uGroup g ON ug.GroupID = g.GroupID AND g.Active = 1
		INNER JOIN cDeskGroupFolderAccess dg ON ug.GroupID = dg.GroupID AND dg.DeskAccessId = 1
	WHERE ug.TeamID = @TeamID AND dg.DeskFolderID = @DeskFolderID
	GROUP BY ImageTypeId

	SET @InsertedRows = @@ROWCOUNT

	DELETE FROM cDeskUserFolderAccess WHERE TeamID = @TeamID and DeskFolderId = @DeskFolderId
	IF @InsertedRows > 0
		INSERT INTO cDeskUserFolderAccess (DeskUserAccessID, DeskFolderId, DeskAccessID, TeamID, CUser, CDate, MUser, MDate) 
		VALUES (NEWID(), @DeskFolderID, 1, @TeamID, @FullName, @CDate, @FullName, @CDate)

	/********************************************************************************************************************************************************************/
	-- COLOR FOLDER
	DELETE FROM sAccessColorFolder WHERE TeamID = @TeamID
	
	SET @DeskFolderID = 7

	INSERT INTO sAccessColorFolder (ColorTypeId, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint,TeamId, CUser, CDate, MUser, MDate)
	SELECT ColorTypeId, MAX(AccessRoleID), MAX(AccessView), MAX(AccessCreate), MAX(AccessModify), MAX(AccessDelete), MAX(AccessPrint), @TeamID, @FullName, @CDate, @FullName, @CDate
	FROM sAccessGroupColorFolder af
		INNER JOIN uUserGroup ug ON af.GroupID = ug.GroupID 
		INNER JOIN uGroup g ON ug.GroupID = g.GroupID AND g.Active = 1
		INNER JOIN cDeskGroupFolderAccess dg ON ug.GroupID = dg.GroupID AND dg.DeskAccessId = 1
	WHERE ug.TeamID = @TeamID AND dg.DeskFolderID = @DeskFolderID
	GROUP BY ColorTypeId

	SET @InsertedRows = @@ROWCOUNT

	DELETE FROM cDeskUserFolderAccess WHERE TeamID = @TeamID and DeskFolderId = @DeskFolderId
	IF @InsertedRows > 0
		INSERT INTO cDeskUserFolderAccess (DeskUserAccessID, DeskFolderId, DeskAccessID, TeamID, CUser, CDate, MUser, MDate) 
		VALUES (NEWID(), @DeskFolderID, 1, @TeamID, @FullName, @CDate, @FullName, @CDate)

	/********************************************************************************************************************************************************************/
	-- MATERIAL FOLDER
	DELETE FROM sAccessMaterialFolder WHERE TeamID = @TeamID
	
	SET @DeskFolderID = 8

	INSERT INTO sAccessMaterialFolder (ComponentTypeId, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint,TeamId, CUser, CDate, MUser, MDate)
	SELECT ComponentTypeId, MAX(AccessRoleID), MAX(AccessView), MAX(AccessCreate), MAX(AccessModify), MAX(AccessDelete), MAX(AccessPrint), @TeamID, @FullName, @CDate, @FullName, @CDate
	FROM sAccessGroupMaterialFolder af
		INNER JOIN uUserGroup ug ON af.GroupID = ug.GroupID 
		INNER JOIN uGroup g ON ug.GroupID = g.GroupID AND g.Active = 1
		INNER JOIN cDeskGroupFolderAccess dg ON ug.GroupID = dg.GroupID AND dg.DeskAccessId = 1
	WHERE ug.TeamID = @TeamID AND dg.DeskFolderID = @DeskFolderID
	GROUP BY ComponentTypeId

	SET @InsertedRows = @@ROWCOUNT

	DELETE FROM cDeskUserFolderAccess WHERE TeamID = @TeamID and DeskFolderId = @DeskFolderId
	IF @InsertedRows > 0
		INSERT INTO cDeskUserFolderAccess (DeskUserAccessID, DeskFolderId, DeskAccessID, TeamID, CUser, CDate, MUser, MDate) 
		VALUES (NEWID(), @DeskFolderID, 1, @TeamID, @FullName, @CDate, @FullName, @CDate)

	/********************************************************************************************************************************************************************/
	-- COMPLIANCE FOLDER
	DELETE FROM sAccessComplianceFolder WHERE TeamID = @TeamID
	
	SET @DeskFolderID = 9

	INSERT INTO sAccessComplianceFolder (ComplianceTypeId, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint,TeamId, CUser, CDate, MUser, MDate)
	SELECT ComplianceTypeId, MAX(AccessRoleID), MAX(AccessView), MAX(AccessCreate), MAX(AccessModify), MAX(AccessDelete), MAX(AccessPrint), @TeamID, @FullName, @CDate, @FullName, @CDate
	FROM sAccessGroupComplianceFolder af
		INNER JOIN uUserGroup ug ON af.GroupID = ug.GroupID 
		INNER JOIN uGroup g ON ug.GroupID = g.GroupID AND g.Active = 1
		INNER JOIN cDeskGroupFolderAccess dg ON ug.GroupID = dg.GroupID AND dg.DeskAccessId = 1
	WHERE ug.TeamID = @TeamID AND dg.DeskFolderID = @DeskFolderID
	GROUP BY ComplianceTypeId

	SET @InsertedRows = @@ROWCOUNT

	DELETE FROM cDeskUserFolderAccess WHERE TeamID = @TeamID and DeskFolderId = @DeskFolderId
	IF @InsertedRows > 0
		INSERT INTO cDeskUserFolderAccess (DeskUserAccessID, DeskFolderId, DeskAccessID, TeamID, CUser, CDate, MUser, MDate) 
		VALUES (NEWID(), @DeskFolderID, 1, @TeamID, @FullName, @CDate, @FullName, @CDate)
	
	/********************************************************************************************************************************************************************/
	-- FLASHEDIT FOLDER
	DELETE FROM sAccessFlashEditFolder WHERE TeamID = @TeamID
	
	SET @DeskFolderID = 15

	INSERT INTO sAccessFlashEditFolder (FlashEditFolderItemId, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint,TeamId, CUser, CDate, MUser, MDate)
	SELECT FlashEditFolderItemId, MAX(AccessRoleID), MAX(AccessView), MAX(AccessCreate), MAX(AccessModify), MAX(AccessDelete), MAX(AccessPrint), @TeamID, @FullName, @CDate, @FullName, @CDate
	FROM sAccessGroupFlashEditFolder af
		INNER JOIN uUserGroup ug ON af.GroupID = ug.GroupID 
		INNER JOIN uGroup g ON ug.GroupID = g.GroupID AND g.Active = 1
		INNER JOIN cDeskGroupFolderAccess dg ON ug.GroupID = dg.GroupID AND dg.DeskAccessId = 1
	WHERE ug.TeamID = @TeamID AND dg.DeskFolderID = @DeskFolderID
	GROUP BY FlashEditFolderItemId

	SET @InsertedRows = @@ROWCOUNT

	DELETE FROM cDeskUserFolderAccess WHERE TeamID = @TeamID and DeskFolderId = @DeskFolderId
	IF @InsertedRows > 0
		INSERT INTO cDeskUserFolderAccess (DeskUserAccessID, DeskFolderId, DeskAccessID, TeamID, CUser, CDate, MUser, MDate) 
		VALUES (NEWID(), @DeskFolderID, 1, @TeamID, @FullName, @CDate, @FullName, @CDate)
		
	/********************************************************************************************************************************************************************/
	-- CONTROL PANEL FOLDER
	DELETE FROM sAccessControlPanel WHERE TeamID = @TeamID
	
	SET @DeskFolderID = 10

	INSERT INTO sAccessControlPanel (ControlPanelId, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint,TeamId, CUser, CDate, MUser, MDate)
	SELECT ControlPanelId, MAX(AccessRoleID), MAX(AccessView), MAX(AccessCreate), MAX(AccessModify), MAX(AccessDelete), MAX(AccessPrint), @TeamID, @FullName, @CDate, @FullName, @CDate
	FROM sAccessGroupControlPanel af
		INNER JOIN uUserGroup ug ON af.GroupID = ug.GroupID 
		INNER JOIN uGroup g ON ug.GroupID = g.GroupID AND g.Active = 1
		INNER JOIN cDeskGroupFolderAccess dg ON ug.GroupID = dg.GroupID AND dg.DeskAccessId = 1
	WHERE ug.TeamID = @TeamID AND dg.DeskFolderID = @DeskFolderID
	GROUP BY ControlPanelId

	SET @InsertedRows = @@ROWCOUNT

	DELETE FROM cDeskUserFolderAccess WHERE TeamID = @TeamID and DeskFolderId = @DeskFolderId
	IF @InsertedRows > 0
		INSERT INTO cDeskUserFolderAccess (DeskUserAccessID, DeskFolderId, DeskAccessID, TeamID, CUser, CDate, MUser, MDate) 
		VALUES (NEWID(), @DeskFolderID, 1, @TeamID, @FullName, @CDate, @FullName, @CDate)

	/********************************************************************************************************************************************************************/
	-- SHARE FOLDER
	DELETE FROM sAccessShareFolder WHERE TeamID = @TeamID
	
	SET @DeskFolderID = 11

	INSERT INTO sAccessShareFolder (ShareTypeId, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint,TeamId, CUser, CDate, MUser, MDate)
	SELECT 1 as ShareTypeId, MAX(AccessRoleID), MAX(AccessView), MAX(AccessCreate), MAX(AccessModify), MAX(AccessDelete), MAX(AccessPrint), @TeamID, @FullName, @CDate, @FullName, @CDate
	FROM sAccessGroupShareFolder af
		INNER JOIN uUserGroup ug ON af.GroupID = ug.GroupID 
		INNER JOIN uGroup g ON ug.GroupID = g.GroupID AND g.Active = 1
		INNER JOIN cDeskGroupFolderAccess dg ON ug.GroupID = dg.GroupID AND dg.DeskAccessId = 1
	WHERE ug.TeamID = @TeamID AND dg.DeskFolderID = @DeskFolderID
	GROUP BY ShareTypeId

	SET @InsertedRows = @@ROWCOUNT

	DELETE FROM cDeskUserFolderAccess WHERE TeamID = @TeamID and DeskFolderId = @DeskFolderId
	IF @InsertedRows > 0
		INSERT INTO cDeskUserFolderAccess (DeskUserAccessID, DeskFolderId, DeskAccessID, TeamID, CUser, CDate, MUser, MDate) 
		VALUES (NEWID(), @DeskFolderID, 1, @TeamID, @FullName, @CDate, @FullName, @CDate)

	/********************************************************************************************************************************************************************/
	-- BATCH QUEUE

	DELETE FROM sAccessBatchQueue WHERE TeamID = @TeamID

	SET @DeskFolderID = 16
	INSERT INTO sAccessBatchQueue (BatchQueueTypeId, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint, TeamId, CUser, CDate, MUser, MDate)
	SELECT BatchQueueTypeID, MAX(AccessRoleID), MAX(AccessView), MAX(AccessCreate), MAX(AccessModify), MAX(AccessDelete), MAX(AccessPrint), @TeamID, @FullName, @CDate, @FullName, @CDate
	FROM sAccessGroupBatchQueue af
		INNER JOIN uUserGroup ug ON af.GroupID = ug.GroupID 
		INNER JOIN uGroup g ON ug.GroupID = g.GroupID AND g.Active = 1
		INNER JOIN cDeskGroupFolderAccess dg ON ug.GroupID = dg.GroupID AND dg.DeskAccessId = 1
	WHERE ug.TeamID = @TeamID AND dg.DeskFolderID = @DeskFolderID
	GROUP BY BatchQueueTypeID

	SET @InsertedRows = @@ROWCOUNT

	DELETE FROM cDeskUserFolderAccess WHERE TeamID = @TeamID and DeskFolderId = @DeskFolderId
	IF @InsertedRows > 0
		INSERT INTO cDeskUserFolderAccess (DeskUserAccessID, DeskFolderId, DeskAccessID, TeamID, CUser, CDate, MUser, MDate) 
		VALUES (NEWID(), @DeskFolderID, 1, @TeamID, @FullName, @CDate, @FullName, @CDate)
		
	/********************************************************************************************************************************************************************/
	-- COSTING 
	DELETE FROM sAccessCosting where TeamID = @TeamID
	
	SET @DeskFolderID = 12

	INSERT INTO sAccessCosting (StyleTypeId, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint,TeamId, CUser, CDate, MUser, MDate)
	SELECT StyleTypeId, MAX(AccessRoleID), MAX(AccessView), MAX(AccessCreate), MAX(AccessModify), MAX(AccessDelete), MAX(AccessPrint), @TeamID,	@FullName, @CDate, @FullName, @CDate
	FROM sAccessGroupCosting af
		INNER JOIN uUserGroup ug ON af.GroupID = ug.GroupID 
		INNER JOIN uGroup g ON ug.GroupID = g.GroupID AND g.Active = 1
		INNER JOIN cDeskGroupFolderAccess dg ON ug.GroupID = dg.GroupID AND dg.DeskAccessId = 1
	WHERE ug.TeamID = @TeamID AND dg.DeskFolderID = @DeskFolderID
	GROUP BY StyleTypeId

	SET @InsertedRows = @@ROWCOUNT

	DELETE FROM cDeskUserFolderAccess WHERE TeamID = @TeamID and DeskFolderId = @DeskFolderId
	IF @InsertedRows > 0
		INSERT INTO cDeskUserFolderAccess (DeskUserAccessID, DeskFolderId, DeskAccessID, TeamID, CUser, CDate, MUser, MDate) 
		VALUES (NEWID(), @DeskFolderID, 1, @TeamID, @FullName, @CDate, @FullName, @CDate)
 
	/********************************************************************************************************************************************************************/ 
	-- BODY FOLDER
	DELETE FROM sAccessBodyFolder where TeamID = @TeamID 

	SET @DeskFolderID = 14 

	INSERT INTO sAccessBodyFolder (BodyTypeId, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessRemove, AccessDelete, AccessPrint,TeamId, CUser, CDate, MUser, MDate) 
	SELECT BodyTypeId, MAX(AccessRoleID), MAX(AccessView), MAX(AccessCreate), MAX(AccessModify), MAX(AccessRemove), MAX(AccessDelete), MAX(AccessPrint), @TeamID, @FullName, @CDate, @FullName, @CDate 
	FROM sAccessGroupBodyFolder af
		INNER JOIN uUserGroup ug ON af.GroupID = ug.GroupID 
		INNER JOIN uGroup g ON ug.GroupID = g.GroupID AND g.Active = 1
		INNER JOIN cDeskGroupFolderAccess dg ON ug.GroupID = dg.GroupID AND dg.DeskAccessId = 1
	WHERE ug.TeamID = @TeamID AND dg.DeskFolderID = @DeskFolderID
	GROUP BY BodyTypeId

	SET @InsertedRows = @@ROWCOUNT

	DELETE FROM cDeskUserFolderAccess WHERE TeamID = @TeamID and DeskFolderId = @DeskFolderId
	IF @InsertedRows > 0
		INSERT INTO cDeskUserFolderAccess (DeskUserAccessID, DeskFolderId, DeskAccessID, TeamID, CUser, CDate, MUser, MDate) 
		VALUES (NEWID(), @DeskFolderID, 1, @TeamID, @FullName, @CDate, @FullName, @CDate)
		
	/********************************************************************************************************************************************************************/ 
	--BI FOLDER
	DELETE FROM sAccessBIItemsFolder where TeamId = @TeamID
	
	SET @DeskFolderID = 17

	INSERT INTO sAccessBIItemsFolder (AccessBIId, BITypeId, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessRemove, AccessDelete, AccessPrint, ItemID, TeamId, CUser, CDate, MUser, MDate, GroupID, [Description]) 
	SELECT AccessBIId, BITypeId, MAX(AccessRoleID), MAX(AccessView), MAX(AccessCreate), MAX(AccessModify), MAX(AccessRemove), MAX(AccessDelete), MAX(AccessPrint), ItemID, @TeamID, @FullName, @CDate, @FullName, @CDate, af.GroupID, [Description]
	FROM sAccessBIItems af
	INNER JOIN uUserGroup ug ON af.GroupID = ug.GroupID 
	INNER JOIN uGroup g ON ug.GroupID = g.GroupID AND g.Active = 1
	INNER JOIN cDeskGroupFolderAccess dg ON ug.GroupID = dg.GroupID AND dg.DeskAccessId = 1
	WHERE ug.TeamID = @TeamID AND dg.DeskFolderID = @DeskFolderID
	GROUP BY AccessBIId, BITypeId, af.GroupID, [Description], af.ItemID

	SET @InsertedRows = @@ROWCOUNT

	DELETE FROM cDeskUserFolderAccess WHERE TeamID = @TeamID and DeskFolderId = @DeskFolderId
	IF @InsertedRows > 0
		INSERT INTO cDeskUserFolderAccess (DeskUserAccessID, DeskFolderId, DeskAccessID, TeamID, CUser, CDate, MUser, MDate) 
		VALUES (NEWID(), @DeskFolderID, 1, @TeamID, @FullName, @CDate, @FullName, @CDate)

	/********************************************************************************************************************************************************************/ 
	--BATCH QUEUE FOLDER
	DELETE FROM sAccessBatchQFolder where TeamId = @TeamID
	
	SET @DeskFolderID = 18

	INSERT INTO sAccessBatchQFolder (BatchQTypeId, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessRemove, AccessDelete, AccessPrint, TeamId, CUser, CDate, MUser, MDate)  
	SELECT  BatchQueueTypeID, MAX(AccessRoleID), MAX(AccessView), MAX(AccessCreate), MAX(AccessModify), MAX(AccessRemove), MAX(AccessDelete), MAX(AccessPrint), @TeamID, @FullName, @CDate, @FullName, @CDate
	FROM sAccessGroupBatchQueueFolder af
	INNER JOIN uUserGroup ug ON af.GroupID = ug.GroupID 
	INNER JOIN uGroup g ON ug.GroupID = g.GroupID AND g.Active = 1
	INNER JOIN cDeskGroupFolderAccess dg ON ug.GroupID = dg.GroupID AND dg.DeskAccessId = 1
	WHERE ug.TeamID = @TeamID AND dg.DeskFolderID = @DeskFolderID
	GROUP BY BatchQueueTypeID  

	SET @InsertedRows = @@ROWCOUNT

	DELETE FROM sAccessBatchQFolderItems where TeamId = @TeamID
	INSERT INTO sAccessBatchQFolderItems (BatchQTypeId, BatchQueueID, AccessBatchQId, GroupID, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessRemove, AccessDelete, AccessPrint, TeamId, CUser, CDate, MUser, MDate)  
	SELECT af.BatchQTypeID, af.BatchQueueID, af.AccessBatchQId, af.GroupID, MAX(AccessRoleID), MAX(AccessView), MAX(AccessCreate), MAX(AccessModify), MAX(AccessRemove), MAX(AccessDelete), MAX(AccessPrint), @TeamID, @FullName, @CDate, @FullName, @CDate
	FROM sAccessBatchQItems af
	INNER JOIN uUserGroup ug ON af.GroupID = ug.GroupID 
	INNER JOIN uGroup g ON ug.GroupID = g.GroupID AND g.Active = 1
	INNER JOIN cDeskGroupFolderAccess dg ON ug.GroupID = dg.GroupID AND dg.DeskAccessId = 1
	WHERE ug.TeamID = @TeamID AND dg.DeskFolderID = @DeskFolderID
	GROUP BY af.BatchQTypeID, af.BatchQueueID, af.GroupID, af.AccessBatchQId

	DELETE FROM cDeskUserFolderAccess WHERE TeamID = @TeamID and DeskFolderId = @DeskFolderId
	IF @InsertedRows > 0 OR @@ROWCOUNT > 0
		INSERT INTO cDeskUserFolderAccess (DeskUserAccessID, DeskFolderId, DeskAccessID, TeamID, CUser, CDate, MUser, MDate) 
		VALUES (NEWID(), @DeskFolderID, 1, @TeamID, @FullName, @CDate, @FullName, @CDate)

	/********************************************************************************************************************************************************************/ 
	--PLANNING FOLDER
	DELETE FROM sAccessPlanningFolder where TeamId = @TeamID
	
	SET @DeskFolderID = 22

	INSERT INTO sAccessPlanningFolder (PlanningTypeId, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint, TeamId, CUser, CDate, MUser, MDate)  
	SELECT  PlanningTypeId, MAX(AccessRoleID), MAX(AccessView), MAX(AccessCreate), MAX(AccessModify), MAX(AccessDelete), MAX(AccessPrint), @TeamID, @FullName, @CDate, @FullName, @CDate
	FROM sAccessGroupPlanningFolder af
	INNER JOIN uUserGroup ug ON af.GroupID = ug.GroupID 
	INNER JOIN uGroup g ON ug.GroupID = g.GroupID AND g.Active = 1
	INNER JOIN cDeskGroupFolderAccess dg ON ug.GroupID = dg.GroupID AND dg.DeskAccessId = 1
	WHERE ug.TeamID = @TeamID AND dg.DeskFolderID = @DeskFolderID
	GROUP BY PlanningTypeId  

	SET @InsertedRows = @@ROWCOUNT

	DELETE FROM cDeskUserFolderAccess WHERE TeamID = @TeamID and DeskFolderId = @DeskFolderId
	IF @InsertedRows > 0
		INSERT INTO cDeskUserFolderAccess (DeskUserAccessID, DeskFolderId, DeskAccessID, TeamID, CUser, CDate, MUser, MDate) 
		VALUES (NEWID(), @DeskFolderID, 1, @TeamID, @FullName, @CDate, @FullName, @CDate)		

	/********************************************************************************************************************************************************************/  
	-- PARTNER FOLDER  
	DELETE FROM sAccessPartnerFolder where TeamID = @TeamID  

	SET @DeskFolderID = 21

	INSERT INTO sAccessPartnerFolder (PartnerTypeId, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint, TeamId, CUser, CDate, MUser, MDate)
	SELECT PartnerTypeId, MAX(AccessRoleID), MAX(AccessView), MAX(AccessCreate), MAX(AccessModify), MAX(AccessDelete), MAX(AccessPrint), @TeamID, @FullName, @CDate, @FullName, @CDate
	FROM sAccessGroupPartnerFolder af
	INNER JOIN uUserGroup ug ON af.GroupID = ug.GroupID 
	INNER JOIN uGroup g ON ug.GroupID = g.GroupID AND g.Active = 1
	INNER JOIN cDeskGroupFolderAccess dg ON ug.GroupID = dg.GroupID AND dg.DeskAccessId = 1
	WHERE ug.TeamID = @TeamID AND dg.DeskFolderID = @DeskFolderID
	GROUP BY PartnerTypeId

	SET @InsertedRows = @@ROWCOUNT

	DELETE FROM cDeskUserFolderAccess WHERE TeamID = @TeamID and DeskFolderId = @DeskFolderId
	IF @InsertedRows > 0
		INSERT INTO cDeskUserFolderAccess (DeskUserAccessID, DeskFolderId, DeskAccessID, TeamID, CUser, CDate, MUser, MDate) 
		VALUES (NEWID(), @DeskFolderID, 1, @TeamID, @FullName, @CDate, @FullName, @CDate)
		
	/********************************************************************************************************************************************************************/  
	-- CALENDAR FOLDER
	DELETE FROM sAccessCalendarFolder where TeamID = @TeamID  

	SET @DeskFolderID = 23

	INSERT INTO sAccessCalendarFolder (CalendarTypeId, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint, TeamId, CUser, CDate, MUser, MDate)
	SELECT CalendarTypeId, MAX(AccessRoleID), MAX(AccessView), MAX(AccessCreate), MAX(AccessModify), MAX(AccessDelete), MAX(AccessPrint), @TeamID, @FullName, @CDate, @FullName, @CDate
	FROM sAccessGroupCalendarFolder af
	INNER JOIN uUserGroup ug ON af.GroupID = ug.GroupID 
	INNER JOIN uGroup g ON ug.GroupID = g.GroupID AND g.Active = 1
	INNER JOIN cDeskGroupFolderAccess dg ON ug.GroupID = dg.GroupID AND dg.DeskAccessId = 1
	WHERE ug.TeamID = @TeamID AND dg.DeskFolderID = @DeskFolderID
	GROUP BY CalendarTypeId

	SET @InsertedRows = @@ROWCOUNT

	DELETE FROM cDeskUserFolderAccess WHERE TeamID = @TeamID and DeskFolderId = @DeskFolderId
	IF @InsertedRows > 0
		INSERT INTO cDeskUserFolderAccess (DeskUserAccessID, DeskFolderId, DeskAccessID, TeamID, CUser, CDate, MUser, MDate) 
		VALUES (NEWID(), @DeskFolderID, 1, @TeamID, @FullName, @CDate, @FullName, @CDate)		
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06485', GetDate())
GO
