-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 06 August 2012                                                                             */
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

IF EXISTS (select * from sysobjects where id = object_id('spx_Hook_WSFiltersXML_UPDATE') and sysstat & 0xf = 4)
    drop procedure spx_Hook_WSFiltersXML_UPDATE
GO


CREATE PROCEDURE spx_Hook_WSFiltersXML_UPDATE
(
    @HookID uniqueidentifier,
    @WSFiltersXML xml
)
AS 
BEGIN

	UPDATE sHook
	SET WSFiltersXML = @WSFiltersXML
	WHERE HookID = @HookID

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03759', GetDate())
GO

SET NOCOUNT Off
GO
