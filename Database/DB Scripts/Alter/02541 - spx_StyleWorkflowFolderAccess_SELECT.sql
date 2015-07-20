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

/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowFolderAccess_SELECT]    Script Date: 01/04/2012 20:48:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowFolderAccess_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowFolderAccess_SELECT]
GO



/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowFolderAccess_SELECT]    Script Date: 01/04/2012 20:48:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[spx_StyleWorkflowFolderAccess_SELECT](
	@StyleTypeId	INT,
	@TeamId			UNIQUEIDENTIFIER,
	@WorkflowID		UNIQUEIDENTIFIER
)
AS

BEGIN 

	DECLARE @MaxAccessRoleId	INT
	DECLARE @MaxAccessView		INT
	DECLARE @MaxAccessCreate	INT
	DECLARE @MaxAccessModify	INT
	DECLARE @MaxAccessRemove	INT
	DECLARE @MaxAccessDelete	INT
	DECLARE @MaxAccessPrint		INT
	
	SET @MaxAccessRoleId=0
	SET @MaxAccessView=0
	SET @MaxAccessCreate=0
	SET @MaxAccessModify=0
	SET @MaxAccessRemove=0
	SET @MaxAccessDelete=0
	SET @MaxAccessPrint=0
	
	SELECT 
	@MaxAccessRoleId=MAX(AccessRoleId) 
	,@MaxAccessView=MAX(AccessView)
	,@MaxAccessCreate=MAX(AccessCreate)
	,@MaxAccessModify=MAX(AccessModify)
	,@MaxAccessRemove=MAX(AccessRemove)
	,@MaxAccessDelete=MAX(AccessDelete)
	,@MaxAccessPrint=MAX(AccessPrint)
	FROM 	sAccessStyleWorkflowFolder 
	WHERE 	
	StyleTypeId = @StyleTypeId 
	AND TeamId = @TeamId
	AND WorkflowId = @WorkflowID
	
	SELECT 	AccessStyleWorkflowID, AccessStyleId, StyleTypeId, 
	@MaxAccessRoleId AS 'AccessRoleId',
	@MaxAccessView AS 'AccessView',
	@MaxAccessCreate AS 'AccessCreate', 
	@MaxAccessModify AS 'AccessModify', 
	@MaxAccessRemove AS 'AccessRemove',
	@MaxAccessDelete AS 'AccessDelete',
	@MaxAccessPrint AS 'AccessPrint', WorkflowID, TeamId, CUser, CDate, MUser, MDate
	FROM 	sAccessStyleWorkflowFolder 
	WHERE 	
	StyleTypeId = @StyleTypeId 
	AND TeamId = @TeamId
	AND WorkflowId = @WorkflowID
END



GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02541'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02541', GetDate())

END

GO

