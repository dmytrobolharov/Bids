-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 20 August 2012                                                                             */
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_YuniFaceDeskTop_Grid_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_YuniFaceDeskTop_Grid_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_YuniFaceDeskTop_Grid_SELECT]
(
	@TeamID uniqueidentifier
)
AS 

SELECT DeskTopID, DeskName, DeskDescription, DeskIcon, 
       DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, 
       DeskSort, DeskActive, DeskTopRepId, DeskButtonName,
       DeskRow, DeskCol
FROM sYuniFaceDeskTop
WHERE DeskActive = 1
AND DeskRow > 0
AND DeskCol > 0
ORDER BY DeskRow, DeskCol
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03789', GetDate())
GO

SET NOCOUNT Off
GO
