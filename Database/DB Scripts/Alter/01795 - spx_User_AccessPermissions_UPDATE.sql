
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 30 Aug 2011                                                                               */
-- * WorkItem #4316                                                                             */
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

/****** Object:  StoredProcedure [dbo].[spx_User_AccessPermissions_UPDATE]    Script Date: 08/30/2011 16:23:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_AccessPermissions_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_User_AccessPermissions_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_User_AccessPermissions_UPDATE]    Script Date: 08/30/2011 16:23:04 ******/
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
	
	SET @DeskFolderID  =  2

	INSERT INTO sAccessStyleFolder (StyleTypeId,  AccessRoleId , AccessView, AccessCreate, AccessModify ,  AccessRemove , AccessDelete , AccessPrint ,TeamId, CUser, CDate, MUser, MDate   )
	SELECT  StyleTypeId , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessRemove ) AS AccessRemove , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId ,
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupStyleFolder 
	WHERE GroupID IN ( 
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = @DeskFolderID 
	) 
	GROUP BY StyleTypeId  


	
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
	DELETE FROM sAccessLinePlanFolder where TeamID = @TeamID  
  
	  INSERT INTO sAccessLinePlanFolder 
	  (
	  LinePlanTemplateId, 
	  CustomID, 
	  AccessRoleId , 
	  AccessPlanView, 
	  AccessPlanNew, 
	  AccessPlanDelete ,  
	  AccessHierView, 
	  AccessHierNew , 
	  AccessHierDelete ,
	  TeamId, 
	  CUser, 
	  CDate, 
	  MUser, 
	  MDate   
	  )  
	  SELECT  LinePlanTemplateId, 
	  CustomID, 
	  MAX(AccessRoleID ) AS  AccessRoleId  , 
	  MAX(AccessPlanView) AS  AccessPlanView,  
	  MAX(AccessPlanNew) AS AccessPlanNew ,   
	  MAX(AccessPlanDelete) AS AccessPlanDelete, 
	  MAX(AccessHierView) AS AccessHierView , 
	  MAX(AccessHierNew) AS AccessHierNew, 
	  MAX (AccessHierDelete) AS AccessHierDelete, 
	  @TeamID AS TeamId ,  
	  @FullName AS CUser, 
	  @CDate AS CDate , 
	  @FullName as MUser , 
	  @CDate as MDate  
	  FROM sAccessGroupLinePlanFolder WITH (NOLOCK)  
	  WHERE GroupID IN 
	  (
			SELECT  a.GroupID   
			FROM uUserGroup a WITH (NOLOCK), uGroup b WITH (NOLOCK), cDeskGroupFolderAccess c WITH (NOLOCK)  
			WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID   
			AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = 13   
	  )   
	  GROUP BY LinePlanTemplateId, CustomID   
	  
	  
	  SET @DeskFolderID  =  13  
	  IF ( SELECT count(*) FROM sAccessLinePlanFolder WITH (NOLOCK) WHERE TeamId = @TeamID ) > 0    
	   BEGIN   
			IF ( SELECT Count(*) FROM cDeskUserFolderAccess WITH (NOLOCK) WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0 
			BEGIN
				UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID    
			END
			ELSE
			BEGIN 
				INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )  
				VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )  
			END
	   END  
	  ELSE
	  BEGIN  
	   DELETE FROM  cDeskUserFolderAccess WHERE TeamID =@TeamID and DeskFolderId = @DeskFolderId   
	  END

	/********************************************************************************************************************************************************************/
	-- LINE FOLDER
	DELETE FROM sAccessLineFolder where TeamID = @TeamID
	
	SET @DeskFolderID  =  3

	INSERT INTO sAccessLineFolder (LineTypeId,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessDelete , AccessPrint ,TeamId , CUser, CDate, MUser, MDate   )
	SELECT  1 as LineTypeId , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId  ,  
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupLineFolder 
	WHERE GroupID IN (
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = @DeskFolderID
	) 
	GROUP BY LineTypeId

	IF ( SELECT count(*) FROM sAccessLineFolder WHERE TeamId = @TeamID ) > 0  
	BEGIN 
		
		IF ( SELECT Count(*) FROM cDeskUserFolderAccess   WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0 
			UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID  
		ELSE 
			INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )
			VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )

	END 


	/********************************************************************************************************************************************************************/
	-- QUOTATION FOLDER
	DELETE FROM sAccessQuotationFolder  where TeamID = @TeamID
	
	SET @DeskFolderID  =  4

	INSERT INTO sAccessQuotationFolder (StyleTypeID,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessDelete , AccessPrint ,TeamId , CUser, CDate, MUser, MDate   )
	SELECT  StyleTypeID , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId  ,  
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupQuotationFolder 
	WHERE GroupID IN ( 
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = @DeskFolderID 
	) 
	GROUP BY StyleTypeID

	IF ( SELECT count(*) FROM sAccessQuotationFolder  WHERE TeamId = @TeamID ) > 0  
	BEGIN 
		
		IF ( SELECT Count(*) FROM cDeskUserFolderAccess   WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0 
			UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID  
		ELSE 
			INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )
			VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )

	END 


	/********************************************************************************************************************************************************************/
	-- SAMPLE FOLDER
	DELETE FROM sAccessSampleFolder  where TeamID = @TeamID
	
	SET @DeskFolderID  =  5

	INSERT INTO sAccessSampleFolder (SampleTypeId,  AccessRoleId , AccessView, AccessCreate, AccessModify , AccessRemove,   AccessDelete , AccessPrint ,TeamId , CUser, CDate, MUser, MDate   )
	SELECT  SampleTypeId  , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessRemove ) AS AccessRemove , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId  ,  
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupSampleFolder 
	WHERE GroupID IN ( 
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = @DeskFolderID 
	) 
	GROUP BY SampleTypeId

	IF ( SELECT count(*) FROM sAccessSampleFolder WHERE TeamId = @TeamID ) > 0  
	BEGIN 
		
		IF ( SELECT Count(*) FROM cDeskUserFolderAccess   WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0 
			UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID  
		ELSE 
			INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )
			VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )

	END 


	/********************************************************************************************************************************************************************/
	-- IMAGE FOLDER
	DELETE FROM sAccessImageFolder  where TeamID = @TeamID
	
	SET @DeskFolderID  =  6

	INSERT INTO sAccessImageFolder (ImageTypeId,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessDelete , AccessPrint ,TeamId , CUser, CDate, MUser, MDate   )
	SELECT  ImageTypeId , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId  ,  
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupImageFolder 
	WHERE GroupID IN ( 
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = @DeskFolderID 
	) 
	GROUP BY ImageTypeId


	IF ( SELECT count(*) FROM sAccessImageFolder  WHERE TeamId = @TeamID ) > 0  
	BEGIN 
		
		IF ( SELECT Count(*) FROM cDeskUserFolderAccess   WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0 
			UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID  
		ELSE 
			INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )
			VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )

	END 


	/********************************************************************************************************************************************************************/
	-- COLOR FOLDER
	DELETE FROM sAccessColorFolder WHERE TeamID = @TeamID
	
	SET @DeskFolderID  =  7

	INSERT INTO sAccessColorFolder (ColorTypeId,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessDelete , AccessPrint ,TeamId , CUser, CDate, MUser, MDate   )
	SELECT  ColorTypeId  , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId  ,  
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupColorFolder 
	WHERE GroupID IN ( 
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID =@DeskFolderID	
	) 
	GROUP BY ColorTypeId


	IF ( SELECT count(*) FROM sAccessColorFolder  WHERE TeamId = @TeamID ) > 0  
	BEGIN 
		
		IF ( SELECT Count(*) FROM cDeskUserFolderAccess   WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0 
			UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID  
		ELSE 
			INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )
			VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )

	END 

	/********************************************************************************************************************************************************************/
	-- MATERIAL FOLDER
	DELETE FROM sAccessMaterialFolder WHERE TeamID = @TeamID
	
	SET @DeskFolderID  =  8

	INSERT INTO sAccessMaterialFolder (ComponentTypeId,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessDelete , AccessPrint ,TeamId , CUser, CDate, MUser, MDate   )
	SELECT  ComponentTypeId  , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId  ,  
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupMaterialFolder 
	WHERE GroupID IN ( 
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = @DeskFolderID 
	) 
	GROUP BY ComponentTypeId

	IF ( SELECT count(*) FROM sAccessMaterialFolder  WHERE TeamId = @TeamID ) > 0  
	BEGIN 
		
		IF ( SELECT Count(*) FROM cDeskUserFolderAccess   WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0 
			UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID  
		ELSE 
			INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )
			VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )

	END 


	/********************************************************************************************************************************************************************/
	-- COMPLIANCE FOLDER
	DELETE FROM sAccessComplianceFolder WHERE TeamID = @TeamID
	
	SET @DeskFolderID  =  9

	INSERT INTO sAccessComplianceFolder (ComplianceTypeId ,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessDelete , AccessPrint ,TeamId , CUser, CDate, MUser, MDate   )
	SELECT  ComplianceTypeId  , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId  ,  
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupComplianceFolder 
	WHERE GroupID IN ( 
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = @DeskFolderID
	) 
	GROUP BY ComplianceTypeId


	IF ( SELECT count(*) FROM sAccessComplianceFolder  WHERE TeamId = @TeamID ) > 0  
	BEGIN 
		
		IF ( SELECT Count(*) FROM cDeskUserFolderAccess   WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0 
			UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID  
		ELSE 
			INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )
			VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )

	END 
	
	/********************************************************************************************************************************************************************/
	-- FlashEdit FOLDER
	DELETE FROM sAccessFlashEditFolder WHERE TeamID = @TeamID
	
	SET @DeskFolderID  = 15

	INSERT INTO sAccessFlashEditFolder (FlashEditFolderItemId ,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessDelete , AccessPrint ,TeamId , CUser, CDate, MUser, MDate   )
	SELECT  FlashEditFolderItemId  , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId  ,  
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupFlashEditFolder 
	WHERE GroupID IN ( 
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = @DeskFolderID 
	) 
	GROUP BY FlashEditFolderItemId


	IF ( SELECT count(*) FROM sAccessFlashEditFolder  WHERE TeamId = @TeamID ) > 0  
	BEGIN 
		
		IF ( SELECT Count(*) FROM cDeskUserFolderAccess   WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0 
			UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID  
		ELSE 
			INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )
			VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )

	END 
	/********************************************************************************************************************************************************************/
	
	-- CONTROL PANEL  FOLDER
	DELETE FROM sAccessControlPanel WHERE TeamID = @TeamID
	
	SET @DeskFolderID  =  10

	INSERT INTO sAccessControlPanel (ControlPanelId ,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessDelete , AccessPrint ,TeamId , CUser, CDate, MUser, MDate   )
	SELECT  ControlPanelId  , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId  ,  
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupControlPanel
	WHERE GroupID IN ( 
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = @DeskFolderID 
	) 
	GROUP BY ControlPanelId

	IF ( SELECT count(*) FROM sAccessControlPanel  WHERE TeamId = @TeamID ) > 0  
	BEGIN 
		
		IF ( SELECT Count(*) FROM cDeskUserFolderAccess   WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0 
			UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID  
		ELSE 
			INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )
			VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )

	END 
	/********************************************************************************************************************************************************************/
	-- SHARE FOLDER
	DELETE FROM sAccessShareFolder WHERE TeamID = @TeamID
	
	SET @DeskFolderID  =  11

	INSERT INTO sAccessShareFolder ( ShareTypeId,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessDelete , AccessPrint ,TeamId , CUser, CDate, MUser, MDate   )
	SELECT  1 as ShareTypeId  , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId  ,  
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupShareFolder 
	WHERE GroupID IN ( 
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = @DeskFolderID 
	) 
	GROUP BY ShareTypeId

	IF ( SELECT count(*) FROM sAccessShareFolder  WHERE TeamId = @TeamID ) > 0  
	BEGIN 
		
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
	
	SET @DeskFolderID  =  12

	INSERT INTO sAccessCosting (StyleTypeId,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessDelete , AccessPrint ,TeamId, CUser, CDate, MUser, MDate   )
	SELECT  StyleTypeId , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate , 
	MAX ( AccessModify )  AS AccessModify  , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId ,
	@FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate
	FROM sAccessGroupCosting 
	WHERE GroupID IN ( 
		SELECT  a.GroupID 
		FROM uUserGroup a, uGroup b , cDeskGroupFolderAccess c
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID 
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = @DeskFolderID 
	) 
	GROUP BY StyleTypeId  


	
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
  
  SET @DeskFolderID  =  14 
  
  INSERT INTO sAccessBodyFolder (BodyTypeId,  AccessRoleId , AccessView, AccessCreate, AccessModify ,   AccessRemove, AccessDelete , AccessPrint ,TeamId, CUser, CDate, MUser, MDate   )  
  SELECT  BodyTypeId , MAX ( AccessRoleID ) AS  AccessRoleId  , MAX ( AccessView ) AS  AccessView ,  MAX ( AccessCreate )  AS AccessCreate ,   
  MAX ( AccessModify )  AS AccessModify  , MAX ( AccessRemove ) AS AccessRemove , MAX ( AccessDelete ) AS AccessDelete , MAX ( AccessPrint )  AS AccessPrint  , @TeamID as TeamId ,  
  @FullName as CUser, @CDate as CDate , @FullName as MUser , @CDate as MDate  
  FROM sAccessGroupBodyFolder WITH (NOLOCK)  
  WHERE GroupID IN (   
   SELECT  a.GroupID   
   FROM uUserGroup a WITH (NOLOCK), uGroup b WITH (NOLOCK), cDeskGroupFolderAccess c WITH (NOLOCK)  
   WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID   
   AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = @DeskFolderID   
  )   
  GROUP BY BodyTypeId    
    
    
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
/********************************************************************************************************************************************************************/ 
--BI Folder
		DELETE FROM sAccessBIItemsFolder where TeamId = @TeamID
		
		SET @DeskFolderID  =  17

		INSERT INTO sAccessBIItemsFolder 
		(
		AccessBIId, 
		BITypeId,  
		AccessRoleId , 
		AccessView, 
		AccessCreate, 
		AccessModify ,   
		AccessRemove, 
		AccessDelete , 
		AccessPrint , 
		ItemID,  
		TeamId, 
		CUser, 
		CDate, 
		MUser, 
		MDate, 
		GroupID, 
		[Description]   
		)  
		SELECT  
		AccessBIId, 
		BITypeId , 
		MAX ( AccessRoleID ) AS  AccessRoleId  , 
		MAX ( AccessView ) AS  AccessView ,  
		MAX ( AccessCreate )  AS AccessCreate ,   
		MAX ( AccessModify )  AS AccessModify  , 
		MAX ( AccessRemove ) AS AccessRemove , 
		MAX ( AccessDelete ) AS AccessDelete , 
		MAX ( AccessPrint )  AS AccessPrint  , 
		ItemID, @TeamID as TeamId ,  
		@FullName as CUser, 
		@CDate as CDate , 
		@FullName as MUser , 
		@CDate as MDate , 
		GroupID, [Description]  
		FROM sAccessBIItems WITH (NOLOCK)  
		WHERE GroupID IN (   
		SELECT  a.GroupID   
		FROM uUserGroup a WITH (NOLOCK), uGroup b WITH (NOLOCK), cDeskGroupFolderAccess c WITH (NOLOCK)  
		WHERE a.GroupID = b.GroupID  AND b.Active =1 AND a.TeamID = @TeamID   
		AND c.GroupID = b.GroupID  AND DeskAccessId = 1  AND c.DeskFolderID = @DeskFolderID  
		)   
		GROUP BY  ItemID, AccessBIId, BITypeId, GroupID, [Description]    


		  
		IF ( SELECT count(*) FROM sAccessBIItemsFolder WITH (NOLOCK) WHERE TeamId = @TeamID ) > 0    
		BEGIN   
			IF ( SELECT Count(*) FROM cDeskUserFolderAccess WITH (NOLOCK) WHERE TeamID = @TeamID AND DeskFolderID = @DeskFolderID ) > 0
			BEGIN
				UPDATE cDeskUserFolderAccess  SET DeskAccessId= 1,  MUser = @FullName, MDate = @CDate WHERE  TeamID = @TeamID  AND DeskFolderID = @DeskFolderID    
			END
			ELSE
			BEGIN   
				INSERT INTO cDeskUserFolderAccess   ( DeskUserAccessID , DeskFolderId, DeskAccessID , TeamID , CUser, CDate, MUser, MDate )  
				VALUES ( NEWID() , @DeskFolderID,  1,  @TeamID ,  @FullName, @CDate, @FullName, @CDate )  
			END
		END  
		ELSE
		BEGIN
			DELETE FROM  cDeskUserFolderAccess WHERE TeamID =@TeamID and DeskFolderId = @DeskFolderId  
		END
		
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01795'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01795', GetDate())

END

GO 
		
