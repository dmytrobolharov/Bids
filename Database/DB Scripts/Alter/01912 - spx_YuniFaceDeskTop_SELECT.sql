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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'spx_YuniFaceDeskTop_SELECT') AND type = N'P' )
	DROP PROCEDURE spx_YuniFaceDeskTop_SELECT
GO


CREATE PROCEDURE spx_YuniFaceDeskTop_SELECT
(
	@TeamID uniqueidentifier
)
AS 

SELECT a.DeskTopID, a.DeskName, a.DeskDescription, a.DeskIcon,
      a.DeskLabel1, a.DeskLabel2, a.DeskUrl, a.DeskMenu, a.DeskMain,
      a.DeskSort, a.DeskActive
FROM  sYuniFaceDeskTop a 
WHERE a.DeskActive = 1
ORDER BY a.DeskSort
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01912', GetDate())
GO

SET NOCOUNT Off
GO
