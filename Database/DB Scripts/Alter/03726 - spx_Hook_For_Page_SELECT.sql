-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 25 July 2012                                                                               */
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

IF EXISTS (select * from sysobjects where id = object_id('spx_Hook_For_Page_SELECT') and sysstat & 0xf = 4)
    drop procedure spx_Hook_For_Page_SELECT
GO


CREATE PROCEDURE spx_Hook_For_Page_SELECT
(
    @PageName nvarchar(300),
    @CRUD nvarchar(1),
    @HookType nvarchar(50)
)
AS 
BEGIN

	SELECT h.*, wsc.Username, wsc.Password

	FROM sHook h
	INNER JOIN dvtCRUD crud ON h.CRUDID = crud.ItemID
	INNER JOIN sHookType ht ON h.HookTypeID = ht.HookTypeID
	LEFT OUTER JOIN uWebServiceClient wsc ON h.WSClientName = wsc.Username

	WHERE h.Active = 1
	AND UPPER(h.PageName) = UPPER(@PageName)
	AND UPPER(crud.ItemKey) = UPPER(@CRUD)
	AND UPPER(ht.HookType) = UPPER(@HookType)

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03726', GetDate())
GO

SET NOCOUNT Off
GO
