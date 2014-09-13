
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 22 July 2011                                                                               */
-- * WorkItem #4107                                                                             */
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

/****** Object:  StoredProcedure [dbo].[spx_DeskTop_SELECT]    Script Date: 07/22/2011 21:03:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DeskTop_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_DeskTop_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_DeskTop_SELECT]    Script Date: 07/22/2011 21:03:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[spx_DeskTop_SELECT](@TeamID uniqueidentifier)
AS 

SELECT  a.DeskTopID, a.DeskName, a.DeskDescription, a.DeskIcon,
      a.DeskLabel1, a.DeskLabel2, a.DeskUrl, a.DeskMenu, a.DeskMain,
      a.DeskSort, a.DeskActive
FROM  sDeskTop a 
WHERE a.DeskName In('Home','Log Off')

UNION

SELECT  a.DeskTopID, a.DeskName, a.DeskDescription, a.DeskIcon,
      a.DeskLabel1, a.DeskLabel2, a.DeskUrl, a.DeskMenu, a.DeskMain,
      a.DeskSort, a.DeskActive
FROM  sDeskTop a INNER JOIN cDeskUserFolderAccess b ON a.DeskFolderID = b.DeskFolderID  
WHERE b.TeamId = @TeamId AND b.DeskAccessID = 1  AND a.DeskActive = 1
ORDER BY a.DeskSort


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01660'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01660', GetDate())

END

GO






