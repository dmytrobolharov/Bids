-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 19 July 2012                                                                               */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
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

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE UPPER(SPECIFIC_NAME) = UPPER(N'spx_YuniFaceDeskTop_SELECTED'))
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
       DeskSort, DeskActive, DeskTopRepId, DeskButtonName
FROM sYuniFaceDeskTop
WHERE DeskTopID = @DeskTopID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03259', GetDate())
GO

SET NOCOUNT Off
GO
