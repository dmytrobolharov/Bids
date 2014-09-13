-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 26 July 2011                                                                               */
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'spx_Group_AccessControlPanel_SELECT') AND type = N'P' )
	DROP PROCEDURE spx_Group_AccessControlPanel_SELECT
GO


CREATE PROCEDURE spx_Group_AccessControlPanel_SELECT
(
@GroupID uniqueidentifier
)
AS 
BEGIN
	SELECT	a.ControlPanelID, a.ControlPanelName, b.AccessGroupControlPanelId, 
			b.AccessRoleId, b.AccessView, b.AccessCreate, 
			b.AccessModify, b.AccessDelete, b.AccessPrint, 
			b.GroupID , b.CUser, b.CDate, b.MUser, 
			b.MDate, a.ControlPanelOrder
	FROM	dbo.pControlPanel a WITH (NOLOCK) INNER JOIN
			dbo.sAccessGroupControlPanel  b WITH (NOLOCK) ON a.ControlPanelID = b.ControlPanelId
	WHERE	b.GroupID  = @GroupID 
	AND		a.IsDataValidation = 0
	ORDER BY a.ControlPanelOrder
END
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01695', GetDate())
GO

SET NOCOUNT Off
GO
