
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 14 July 2011                                                                               */
-- * WorkItem #3645                                                                             */
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

/****** Object:  StoredProcedure [dbo].[spx_DeskTop_SELECT]    Script Date: 07/14/2011 21:35:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DeskTop_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_DeskTop_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_DeskTop_SELECT]    Script Date: 07/14/2011 21:35:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[spx_DeskTop_SELECT](@TeamID uniqueidentifier)
AS 


SELECT DeskTopID, DeskName, DeskDescription, DeskIcon, 
	DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, 
	DeskSort, DeskActive
FROM  sDeskTop
WHERE DeskActive = 1 ORDER BY DeskSort

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01634'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01634', GetDate())

END

GO




