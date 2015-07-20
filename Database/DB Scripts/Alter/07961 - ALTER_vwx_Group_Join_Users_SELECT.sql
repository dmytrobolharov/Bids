-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 09 June 2014                                                                               */
-- *                                                                                            */
-- * Copyright (c) 2002-2014 Gerber Technology, Inc.  All rights reserved.                      */
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

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[vwx_Group_Join_Users_SELECT]'))
	DROP VIEW [vwx_Group_Join_Users_SELECT]
GO

CREATE VIEW [vwx_Group_Join_Users_SELECT]
AS
	SELECT u.TeamID, u.FirstName, u.MiddleName, u.LastName, u.FULLNAME, u.UserName, u.CUser, u.CDate, u.MUser, u.MDate, g.GroupID, g.GroupName, g.Active, g.GroupDescription
	FROM Users as u
	INNER JOIN uUserGroup as ug ON u.TeamID = ug.TeamID
	INNER JOIN uGroup as g ON g.GroupID = ug.GroupID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07961', GetDate())
GO

SET NOCOUNT Off
GO
