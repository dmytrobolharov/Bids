
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 22 July 2011                                                                               */
-- * WorkItem #4107                                                                             */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_User_AccessPermissions_UPDATE]    Script Date: 07/22/2011 21:03:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_AccessPermissions_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_User_AccessPermissions_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_User_AccessPermissions_UPDATE]    Script Date: 07/22/2011 21:03:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_User_AccessPermissions_UPDATE] (
@TeamID uniqueidentifier ,
@FullName as nvarchar (200) ,
@CDate  as DateTime
)
AS
DECLARE @DeskFolderID INT


	/********************************************************************************************************************************************************************/
	-- STYLE FOLDER
	DELETE FROM sAccessStyleFolder where TeamID = @TeamID

	INSERT INTO sAccessStyleFolder (StyleTypeId,  AccessRoleId , AccessView, AccessCreate, AccessModify ,  AccessRemove , AccessDelete , AccessPrint ,TeamId, CUser, CDate, MUser, MDate   )
	SELECT  StyleTypeId , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessRemove ) AS AccessRemove , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId ,
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupStyleFolder 
	WHERE GroupID IN ( 
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = 2 
	) 
	GROUP BY StyleTypeId  


	SET @DeskFolderID  =  2
	IF ( SELECT count(*) FROM sAccessStyleFolder WHERE TeamId = @TeamID ) > 0  
	BEGIN 
		IF ( SELECT Count(*) FROM cDeskUserFolderAccess   WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0 
			UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID  
		ELSE 
			INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )
			VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )
	END
	ELSE

		DELETE FROM  cDeskUserFolderAccess WHERE TeamID =@TeamID and DeskFolderId = @DeskFolderId 




	/********************************************************************************************************************************************************************/
	-- LINEPLAN FOLDER
/*
	DELETE FROM sAccessLinePlanFolder where TeamID = @TeamID   

	INSERT INTO sAccessLinePlanFolder (StyleTypeId,  AccessRoleId , AccessView, AccessCreate, AccessModify ,  AccessRemove , AccessDelete , AccessPrint ,TeamId, CUser, CDate, MUser, MDate   )
	SELECT  StyleTypeId , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessRemove ) AS AccessRemove , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId ,
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupLinePlanFolder   
	WHERE GroupID IN ( 
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = 2 
	) 
	GROUP BY StyleTypeId  


	SET @DeskFolderID  =  2
	IF ( SELECT count(*) FROM sAccessLinePlanFolder WHERE TeamId = @TeamID ) > 0  
	BEGIN 
		IF ( SELECT Count(*) FROM cDeskUserFolderAccess   WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0 
			UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID  
		ELSE 
			INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )
			VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )
	END
	ELSE

		DELETE FROM  cDeskUserFolderAccess WHERE TeamID =@TeamID and DeskFolderId = @DeskFolderId 
*/


	/********************************************************************************************************************************************************************/
	-- LINE FOLDER
	DELETE FROM sAccessLineFolder where TeamID = @TeamID

	INSERT INTO sAccessLineFolder (LineTypeId,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessDelete , AccessPrint ,TeamId , CUser, CDate, MUser, MDate   )
	SELECT  1 as LineTypeId , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId  ,  
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupLineFolder 
	WHERE GroupID IN (
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = 3
	) 
	GROUP BY LineTypeId

	IF ( SELECT count(*) FROM sAccessLineFolder WHERE TeamId = @TeamID ) > 0  
	BEGIN 
		SET @DeskFolderID  =  3
		IF ( SELECT Count(*) FROM cDeskUserFolderAccess   WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0 
			UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID  
		ELSE 
			INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )
			VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )

	END 


	/********************************************************************************************************************************************************************/
	-- QUOTATION FOLDER
	DELETE FROM sAccessQuotationFolder  where TeamID = @TeamID

	INSERT INTO sAccessQuotationFolder (StyleTypeID,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessDelete , AccessPrint ,TeamId , CUser, CDate, MUser, MDate   )
	SELECT  StyleTypeID , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId  ,  
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupQuotationFolder 
	WHERE GroupID IN ( 
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = 4 
	) 
	GROUP BY StyleTypeID

	IF ( SELECT count(*) FROM sAccessQuotationFolder  WHERE TeamId = @TeamID ) > 0  
	BEGIN 
		SET @DeskFolderID  =  4
		IF ( SELECT Count(*) FROM cDeskUserFolderAccess   WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0 
			UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID  
		ELSE 
			INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )
			VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )

	END 


	/********************************************************************************************************************************************************************/
	-- SAMPLE FOLDER
	DELETE FROM sAccessSampleFolder  where TeamID = @TeamID

	INSERT INTO sAccessSampleFolder (SampleTypeId,  AccessRoleId , AccessView, AccessCreate, AccessModify , AccessRemove,   AccessDelete , AccessPrint ,TeamId , CUser, CDate, MUser, MDate   )
	SELECT  SampleTypeId  , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessRemove ) AS AccessRemove , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId  ,  
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupSampleFolder 
	WHERE GroupID IN ( 
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = 5 
	) 
	GROUP BY SampleTypeId

	IF ( SELECT count(*) FROM sAccessSampleFolder WHERE TeamId = @TeamID ) > 0  
	BEGIN 
		SET @DeskFolderID  =  5
		IF ( SELECT Count(*) FROM cDeskUserFolderAccess   WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0 
			UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID  
		ELSE 
			INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )
			VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )

	END 


	/********************************************************************************************************************************************************************/
	-- IMAGE FOLDER
	DELETE FROM sAccessImageFolder  where TeamID = @TeamID

	INSERT INTO sAccessImageFolder (ImageTypeId,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessDelete , AccessPrint ,TeamId , CUser, CDate, MUser, MDate   )
	SELECT  ImageTypeId , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId  ,  
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupImageFolder 
	WHERE GroupID IN ( 
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = 6 
	) 
	GROUP BY ImageTypeId


	IF ( SELECT count(*) FROM sAccessImageFolder  WHERE TeamId = @TeamID ) > 0  
	BEGIN 
		SET @DeskFolderID  =  6
		IF ( SELECT Count(*) FROM cDeskUserFolderAccess   WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0 
			UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID  
		ELSE 
			INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )
			VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )

	END 


	/********************************************************************************************************************************************************************/
	-- COLOR FOLDER
	DELETE FROM sAccessColorFolder WHERE TeamID = @TeamID

	INSERT INTO sAccessColorFolder (ColorTypeId,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessDelete , AccessPrint ,TeamId , CUser, CDate, MUser, MDate   )
	SELECT  ColorTypeId  , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId  ,  
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupColorFolder 
	WHERE GroupID IN ( 
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = 7 	
	) 
	GROUP BY ColorTypeId


	IF ( SELECT count(*) FROM sAccessColorFolder  WHERE TeamId = @TeamID ) > 0  
	BEGIN 
		SET @DeskFolderID  =  7
		IF ( SELECT Count(*) FROM cDeskUserFolderAccess   WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0 
			UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID  
		ELSE 
			INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )
			VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )

	END 

	/********************************************************************************************************************************************************************/
	-- MATERIAL FOLDER
	DELETE FROM sAccessMaterialFolder WHERE TeamID = @TeamID

	INSERT INTO sAccessMaterialFolder (ComponentTypeId,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessDelete , AccessPrint ,TeamId , CUser, CDate, MUser, MDate   )
	SELECT  ComponentTypeId  , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId  ,  
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupMaterialFolder 
	WHERE GroupID IN ( 
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = 8 
	) 
	GROUP BY ComponentTypeId

	IF ( SELECT count(*) FROM sAccessMaterialFolder  WHERE TeamId = @TeamID ) > 0  
	BEGIN 
		SET @DeskFolderID  =  8
		IF ( SELECT Count(*) FROM cDeskUserFolderAccess   WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0 
			UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID  
		ELSE 
			INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )
			VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )

	END 


	/********************************************************************************************************************************************************************/
	-- COMPLIANCE FOLDER
	DELETE FROM sAccessComplianceFolder WHERE TeamID = @TeamID

	INSERT INTO sAccessComplianceFolder (ComplianceTypeId ,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessDelete , AccessPrint ,TeamId , CUser, CDate, MUser, MDate   )
	SELECT  ComplianceTypeId  , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId  ,  
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupComplianceFolder 
	WHERE GroupID IN ( 
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = 9 
	) 
	GROUP BY ComplianceTypeId


	IF ( SELECT count(*) FROM sAccessComplianceFolder  WHERE TeamId = @TeamID ) > 0  
	BEGIN 
		SET @DeskFolderID  =  9
		IF ( SELECT Count(*) FROM cDeskUserFolderAccess   WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0 
			UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID  
		ELSE 
			INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )
			VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )

	END 
	
	/********************************************************************************************************************************************************************/
	-- FlashEdit FOLDER
	DELETE FROM sAccessFlashEditFolder WHERE TeamID = @TeamID

	INSERT INTO sAccessFlashEditFolder (FlashEditFolderItemId ,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessDelete , AccessPrint ,TeamId , CUser, CDate, MUser, MDate   )
	SELECT  FlashEditFolderItemId  , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId  ,  
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupFlashEditFolder 
	WHERE GroupID IN ( 
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = 15 
	) 
	GROUP BY FlashEditFolderItemId


	IF ( SELECT count(*) FROM sAccessFlashEditFolder  WHERE TeamId = @TeamID ) > 0  
	BEGIN 
		SET @DeskFolderID  = 15
		IF ( SELECT Count(*) FROM cDeskUserFolderAccess   WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0 
			UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID  
		ELSE 
			INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )
			VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )

	END 
	/********************************************************************************************************************************************************************/
	
	-- CONTROL PANEL  FOLDER
	DELETE FROM sAccessControlPanel WHERE TeamID = @TeamID

	INSERT INTO sAccessControlPanel (ControlPanelId ,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessDelete , AccessPrint ,TeamId , CUser, CDate, MUser, MDate   )
	SELECT  ControlPanelId  , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId  ,  
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupControlPanel
	WHERE GroupID IN ( 
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = 10 
	) 
	GROUP BY ControlPanelId

	IF ( SELECT count(*) FROM sAccessControlPanel  WHERE TeamId = @TeamID ) > 0  
	BEGIN 
		SET @DeskFolderID  =  10
		IF ( SELECT Count(*) FROM cDeskUserFolderAccess   WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0 
			UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID  
		ELSE 
			INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )
			VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )

	END 






	/********************************************************************************************************************************************************************/
	-- SHARE FOLDER
	DELETE FROM sAccessShareFolder WHERE TeamID = @TeamID

	INSERT INTO sAccessShareFolder ( ShareTypeId,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessDelete , AccessPrint ,TeamId , CUser, CDate, MUser, MDate   )
	SELECT  1 as ShareTypeId  , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId  ,  
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupShareFolder 
	WHERE GroupID IN ( 
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = 11 
	) 
	GROUP BY ShareTypeId

	IF ( SELECT count(*) FROM sAccessShareFolder  WHERE TeamId = @TeamID ) > 0  
	BEGIN 
		SET @DeskFolderID  =  11
		IF ( SELECT Count(*) FROM cDeskUserFolderAccess   WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0 
			UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID  
		ELSE 
			INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )
			VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )

	END 



	/********************************************************************************************************************************************************************/
	-- Batch Queue


	DELETE FROM sAccessBatchQueue WHERE TeamID = @TeamID

	SET @DeskFolderID = 16
	INSERT INTO sAccessBatchQueue (BatchQueueTypeId, AccessRoleId, AccessView, AccessCreate, AccessModify, AccessDelete, AccessPrint, TeamId, CUser, CDate, MUser, MDate)
	SELECT  BatchQueueTypeID, MAX (AccessRoleID) AS AccessRoleId, MAX (AccessView) AS AccessView, MAX (AccessCreate) AS AccessCreate,
	MAX (AccessModify) AS AccessModify, MAX (AccessDelete) AS AccessDelete, MAX (AccessPrint) AS AccessPrint, @TeamID as TeamId,
	@FullName as CUser, @CDate as CDate, @FullName as MUser, @CDate as MDate
	FROM sAccessGroupBatchQueue WITH (NOLOCK)
	WHERE GroupID IN (
		SELECT a.GroupID
		FROM uUserGroup a WITH (NOLOCK), uGroup b WITH (NOLOCK), cDeskGroupFolderAccess c WITH (NOLOCK)


		WHERE a.GroupID = b.GroupID AND b.Active = 1 AND a.TeamID = @TeamID
		AND c.GroupID = b.GroupID AND DeskAccessId = 1 AND c.DeskFolderID = @DeskFolderID
	)
	GROUP BY BatchQueueTypeID

	IF ( SELECT count(*) FROM sAccessBatchQueue WITH (NOLOCK) WHERE TeamId = @TeamID ) > 0
	BEGIN
		IF ( SELECT Count(*) FROM cDeskUserFolderAccess WITH (NOLOCK) WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0
			UPDATE cDeskUserFolderAccess SET DeskAccessId = 1, MUser = @FullName, MDate = @CDate WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID
		ELSE
			INSERT INTO cDeskUserFolderAccess ( DeskUserAccessID, DeskFolderId, DeskAccessID, TeamID, CUser, CDate, MUser, MDate )


			VALUES ( NEWID(), @DeskFolderID, 1, @TeamID, @FullName, @CDate, @FullName, @CDate )


	END
	ELSE
		DELETE FROM cDeskUserFolderAccess WHERE TeamID = @TeamID and DeskFolderId = @DeskFolderId




	/********************************************************************************************************************************************************************/
	-- COSTING 
	DELETE FROM sAccessCosting where TeamID = @TeamID

	INSERT INTO sAccessCosting (StyleTypeId,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessDelete , AccessPrint ,TeamId, CUser, CDate, MUser, MDate   )
	SELECT  StyleTypeId , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId ,
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupCosting 
	WHERE GroupID IN ( 
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = 2 
	) 
	GROUP BY StyleTypeId  


	SET @DeskFolderID  =  12
	IF ( SELECT count(*) FROM sAccessCosting  WHERE TeamId = @TeamID ) > 0  
	BEGIN 
		IF ( SELECT Count(*) FROM cDeskUserFolderAccess   WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0 
			UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID  
		ELSE 
			INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )
			VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )
	END
	ELSE

		DELETE FROM  cDeskUserFolderAccess WHERE TeamID =@TeamID and DeskFolderId = @DeskFolderId 
		
 
/********************************************************************************************************************************************************************/ 
-- BODY FOLDER
  DELETE FROM sAccessBodyFolder where TeamID = @TeamID  
  
  INSERT INTO sAccessBodyFolder (BodyTypeId,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessRemove, AccessDelete , AccessPrint ,TeamId, CUser, CDate, MUser, MDate   )  
  SELECT  BodyTypeId , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate ,   
  MAX ( AccessModify )  AS AccessModify  , MAX ( AccessRemove ) AS AccessRemove , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId ,  
  @FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate  
  FROM sAccessGroupBodyFolder WITH (NOLOCK)  
  WHERE GroupID IN (   
   SELECT  a.GroupID   
   FROM uUserGroup a WITH (NOLOCK), uGroup b WITH (NOLOCK), cDeskGroupFolderAccess c WITH (NOLOCK)  
   WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID   
   AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = 2   
  )   
  GROUP BY BodyTypeId    
  
  
  SET @DeskFolderID  =  14  
  IF ( SELECT count(*) FROM sAccessBodyFolder WITH (NOLOCK) WHERE TeamId = @TeamID ) > 0    
  BEGIN   
   IF ( SELECT Count(*) FROM cDeskUserFolderAccess WITH (NOLOCK) WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0   
    UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID    
   ELSE   
    INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )  
    VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )  
  END  
  ELSE  
  
   DELETE FROM  cDeskUserFolderAccess WHERE TeamID =@TeamID and DeskFolderId = @DeskFolderId
   
   GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01661'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01661', GetDate())

END

GO  

		
	
		
		
		
