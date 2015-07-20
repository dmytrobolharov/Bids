-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 26 July 2012                                                                               */
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

IF EXISTS (select * from sysobjects where id = object_id('hpx_sSystemServerSettings_Fix_Server_Name') and sysstat & 0xf = 4)
    drop procedure hpx_sSystemServerSettings_Fix_Server_Name
GO


CREATE PROCEDURE hpx_sSystemServerSettings_Fix_Server_Name
(
	@TempTableName varchar(128)
)
AS 
BEGIN

    DECLARE @Task varchar(8000)
    SET @Task = 'UPDATE ' + @TempTableName + ' SET SystemServerName = SystemServerDescription WHERE SystemServerName IS NULL'
    EXECUTE (@Task)

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03727', GetDate())
GO

SET NOCOUNT Off
GO
