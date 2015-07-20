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

/****** Object:  StoredProcedure [dbo].[spx_Workflow_AccessStyleFolder_UPDATE]    Script Date: 01/04/2012 20:49:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Workflow_AccessStyleFolder_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Workflow_AccessStyleFolder_UPDATE]
GO



/****** Object:  StoredProcedure [dbo].[spx_Workflow_AccessStyleFolder_UPDATE]    Script Date: 01/04/2012 20:49:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_Workflow_AccessStyleFolder_UPDATE]  (  
@AccessRoleId	INT,   
@AccessView		INT,   
@AccessCreate	INT ,   
@AccessModify	INT,   
@AccessRemove	INT ,   
@AccessDelete	INT ,   
@AccessPrint	INT , 
@MUser			NVARCHAR (200),   
@MDate			DATETIME ,   
@AccessStyleWorkflowID UNIQUEIDENTIFIER   
)  
AS


DECLARE @AccessStyleId UNIQUEIDENTIFIER
SET @AccessStyleId=(SELECT AccessStyleId FROM sAccessStyleWorkflow WHERE AccessStyleWorkflowID = @AccessStyleWorkflowID)

DECLARE @GroupID UNIQUEIDENTIFIER
SET @GroupID=(SELECT GroupID FROM sAccessStyleWorkflow WHERE AccessStyleWorkflowID = @AccessStyleWorkflowID)


DECLARE @StyleTypeID INT
SET @StyleTypeID = (SELECT StyleTypeId FROM sAccessGroupStyleFolder WHERE AccessStyleId = @AccessStyleId)

EXEC spx_Group_DesktopAccessStyleWorkflowFolderCheck_INSERT @AccessStyleId, @AccessRoleId, @StyleTypeID, 
@GroupID, NULL, @MUser, @MDate
  
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
 WHERE AccessStyleWorkflowID = @AccessStyleWorkflowID
 
 --EXEC spx_Workflow_AccessFolderUserPermissions_UPDATE @StyleTypeID, @GroupID, @MUser, @MDate

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02543'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02543', GetDate())

END

GO