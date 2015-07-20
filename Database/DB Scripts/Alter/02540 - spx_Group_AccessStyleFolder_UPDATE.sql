-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 04 Jan 2012                                                                                */
-- * WorkItem #5642																				*/
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_Group_AccessStyleFolder_UPDATE]    Script Date: 01/04/2012 20:48:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_AccessStyleFolder_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_AccessStyleFolder_UPDATE]
GO


/****** Object:  StoredProcedure [dbo].[spx_Group_AccessStyleFolder_UPDATE]    Script Date: 01/04/2012 20:48:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_Group_AccessStyleFolder_UPDATE]  (
@AccessRoleId int  , 
@AccessView int , 
@AccessCreate int , 
@AccessModify int, 
@AccessRemove int , 
@AccessDelete int , 
@AccessPrint int , 
@GroupID uniqueidentifier , 
@MUser nvarchar (200), 
@MDate  datetime , 
@AccessStyleId uniqueidentifier 
)
AS 



	DECLARE @StyleTypeID INT
	SET @StyleTypeID = (SELECT StyleTypeId FROM sAccessGroupStyleFolder WHERE AccessStyleId = @AccessStyleId)

	EXEC spx_Group_DesktopAccessStyleWorkflowFolderCheck_INSERT @AccessStyleId, @AccessRoleId, @StyleTypeID, @GroupID, NULL, @MUser, @MDate


	UPDATE sAccessGroupStyleFolder  
	SET AccessRoleId = @AccessRoleId, 
	AccessView = @AccessView,  
	AccessCreate = @AccessCreate,  
	AccessModify = @AccessModify, 
	AccessRemove = @AccessRemove, 
	AccessDelete = @AccessDelete,  
	AccessPrint = @AccessPrint, 
	GroupID = @GroupID, 
	MUser = @MUser,  
	MDate = @MDate  
	WHERE AccessStyleId = @AccessStyleId
	
	
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
	WHERE StyleTypeId = @StyleTypeId AND GroupID = @GroupID


	EXEC spx_Workflow_AccessFolderUserPermissions_UPDATE @StyleTypeID, @GroupID, @MUser, @MDate

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02540'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02540', GetDate())

END

GO

