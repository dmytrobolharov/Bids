-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 19 July 2011                                                                               */
-- *                                                                                            */
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
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'spx_Group_AccessStyleFolder_UPDATE_ALL') AND type in (N'P', N'PC'))
DROP PROCEDURE spx_Group_AccessStyleFolder_UPDATE_ALL
GO


CREATE PROCEDURE spx_Group_AccessStyleFolder_UPDATE_ALL (
	@AccessRoleId int,
	@AccessView int,
	@AccessCreate int,
	@AccessModify int,
	@AccessRemove int,
	@AccessDelete int,
	@AccessPrint int,
	@GroupID uniqueidentifier,
	@TeamID uniqueidentifier,
	@MUser nvarchar (200),
	@MDate datetime,
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


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01653', GetDate())
GO
