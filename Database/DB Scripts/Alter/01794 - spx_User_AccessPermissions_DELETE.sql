
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

/****** Object:  StoredProcedure [dbo].[spx_User_AccessPermissions_DELETE]    Script Date: 08/30/2011 16:23:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_AccessPermissions_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_User_AccessPermissions_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_User_AccessPermissions_DELETE]    Script Date: 08/30/2011 16:23:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_User_AccessPermissions_DELETE] (
@GroupID uniqueidentifier,
@TeamID uniqueidentifier
)
AS
BEGIN

	DELETE FROM uUserGroup WHERE GroupID = @GroupID  AND  TeamID = @TeamID

	UPDATE cDeskUserFolderAccess SET DeskAccessId='0' WHERE TeamID = @TeamID
	
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01794'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01794', GetDate())

END

GO 