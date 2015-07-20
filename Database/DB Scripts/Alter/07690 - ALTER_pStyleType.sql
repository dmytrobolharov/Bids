-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 19 May 2014                                                                                */
-- *                                                                                            */
-- * Copyright (c) 2002-2014 Gerber Technology, Inc.  All rights reserved.                      */
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


-----------
-- CUser --
-----------
IF NOT EXISTS(SELECT * FROM sys.columns WHERE name = 'CUser' and object_id = object_id('pStyleType'))
BEGIN
	 ALTER TABLE pStyleType ADD CUser nvarchar(200) NULL
END
GO

UPDATE pStyleType SET CUser = 'Administrator'
WHERE CUser IS NULL
GO


-----------
-- CDate --
-----------
IF NOT EXISTS(SELECT * FROM sys.columns WHERE name = 'CDate' and object_id = object_id('pStyleType'))
BEGIN
	 ALTER TABLE pStyleType ADD CDate datetime NULL
END
GO

UPDATE pStyleType SET CDate = GETUTCDATE()
WHERE CDate IS NULL
GO


-----------
-- MUser --
-----------
IF NOT EXISTS(SELECT * FROM sys.columns WHERE name = 'MUser' and object_id = object_id('pStyleType'))
BEGIN
	 ALTER TABLE pStyleType ADD MUser nvarchar(200) NULL
END
GO

UPDATE pStyleType SET MUser = 'Administrator'
WHERE MUser IS NULL
GO


-----------
-- MDate --
-----------
IF NOT EXISTS(SELECT * FROM sys.columns WHERE name = 'MDate' and object_id = object_id('pStyleType'))
BEGIN
	 ALTER TABLE pStyleType ADD MDate datetime NULL
END
GO

UPDATE pStyleType SET MDate = GETUTCDATE()
WHERE MDate IS NULL
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07690', GetDate())
GO

SET NOCOUNT Off
GO
