-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 30 November 2011                                                                           */
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


-- Add TopDown field
IF NOT EXISTS (select * from Information_Schema.COLUMNS where TABLE_NAME = N'pLinePlan' and COLUMN_NAME = N'TopDown')
BEGIN
    ALTER TABLE pLinePlan ADD TopDown int NULL
END
GO  

IF EXISTS (select * from Information_Schema.COLUMNS where TABLE_NAME = N'pLinePlan' and COLUMN_NAME = N'TopDown')
BEGIN
	IF NOT EXISTS (SELECT * FROM sys.objects WHERE name = N'DF_pLinePlan_TopDown')
	BEGIN
	    ALTER TABLE pLinePlan ADD CONSTRAINT DF_pLinePlan_TopDown DEFAULT 0 FOR TopDown
	END
END
GO

UPDATE pLinePlan SET TopDown = 0 WHERE TopDown IS NULL
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '02288', GetDate())
GO

SET NOCOUNT Off
GO
