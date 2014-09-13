-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 7 September 2011                                                                           */
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'spx_YuniFaceDeskTop_SELECTED') AND type = N'P' )
	DROP PROCEDURE spx_YuniFaceDeskTop_SELECTED
GO


CREATE PROCEDURE spx_YuniFaceDeskTop_SELECTED
(
	@TeamID uniqueidentifier, 
	@DeskTopID int
)
AS 

SELECT DeskTopID, DeskName, DeskDescription, DeskIcon, 
	DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, 
	DeskSort, DeskActive
FROM  sYuniFaceDeskTop
WHERE DeskTopID = @DeskTopID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01913', GetDate())
GO

SET NOCOUNT Off
GO
