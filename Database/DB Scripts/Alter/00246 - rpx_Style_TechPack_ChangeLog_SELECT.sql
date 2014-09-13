-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 19 July 2010                                                                               */
-- *                                                                                            */
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
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


IF EXISTS (select * from sysobjects where id = object_id('rpx_Style_TechPack_ChangeLog_SELECT') and sysstat & 0xf = 4)
    drop procedure rpx_Style_TechPack_ChangeLog_SELECT
GO


CREATE PROCEDURE rpx_Style_TechPack_ChangeLog_SELECT
(
	@StyleID UNIQUEIDENTIFIER
	,@StyleSet INT
)

AS


/************************/
/*Declare variables.	*/
/************************/
DECLARE @TechPackID UNIQUEIDENTIFIER


/************************************************/
/*Get the @TechPackID of the latest Tech Pack.	*/
/************************************************/
SELECT TOP 1 @TechPackID = TechPackID
FROM pTechPack
WHERE StyleID = @StyleID
	AND StyleSet = @StyleSet
ORDER BY CDate DESC


/****************************/
/*Final SELECT statement.	*/
/****************************/
SELECT
	pTechPack.TechPackNo
	,pTechPack.TechPackName
	,pTechPack.CUser AS TechPackCUser
	,pTechPack.CDate AS TechPackCDate
	,pStyleChange.StyleChangeNo AS TechPackChangeLogNo
	,pStyleChange.StyleChangeDate AS TechPackChangeDate
	,pStyleChange.StyleChangeBy AS TechPackChangeUser
	,pStyleChange.StyleChangeDescription AS TechPackChangeDescription
FROM pStyleChange
	INNER JOIN pTechPack ON	pStyleChange.TechPackID = pTechPack.TechPackID
WHERE pStyleChange.TechPackID = @TechPackID
ORDER BY StyleChangeDate DESC
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '246', GetDate())
GO
