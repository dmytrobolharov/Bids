-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 24 July 2012                                                                               */
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

IF EXISTS (select * from sysobjects where id = object_id('spx_Information_Schema_SP_Parameter_SELECT') and sysstat & 0xf = 4)
    drop procedure spx_Information_Schema_SP_Parameter_SELECT
GO


CREATE PROCEDURE spx_Information_Schema_SP_Parameter_SELECT
(
    @SPName VarChar(128)
)
AS 
BEGIN

	SELECT * FROM INFORMATION_SCHEMA.PARAMETERS
	WHERE UPPER(SPECIFIC_NAME) = UPPER(@SPName)
	ORDER BY ORDINAL_POSITION

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03725', GetDate())
GO

SET NOCOUNT Off
GO
