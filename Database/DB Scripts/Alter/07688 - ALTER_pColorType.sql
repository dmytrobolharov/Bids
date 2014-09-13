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


-----------------------------
-- ColorFolderHeaderSchema --
-----------------------------
IF NOT EXISTS(SELECT * FROM sys.columns WHERE name = 'ColorFolderHeaderSchema' and object_id = object_id('pColorType'))
BEGIN 
	 ALTER TABLE pColorType ADD ColorFolderHeaderSchema nvarchar(200) NULL
END 
GO  

UPDATE pColorType SET ColorFolderHeaderSchema = 'Color_Folder_Header.xml'
WHERE ColorFolderHeaderSchema IS NULL
GO


----------------------------
-- ColorFolderPrintSchema --
----------------------------
IF NOT EXISTS(SELECT * FROM sys.columns WHERE name = 'ColorFolderPrintSchema' and object_id = object_id('pColorType'))
BEGIN 
	 ALTER TABLE pColorType ADD ColorFolderPrintSchema nvarchar(200) NULL
END 
GO  

UPDATE pColorType SET ColorFolderPrintSchema = 'Color_Folder_Print.xml'
WHERE ColorFolderPrintSchema IS NULL
GO


-----------
-- CUser --
-----------
IF NOT EXISTS(SELECT * FROM sys.columns WHERE name = 'CUser' and object_id = object_id('pColorType'))
BEGIN
	 ALTER TABLE pColorType ADD CUser nvarchar(200) NULL
END
GO

UPDATE pColorType SET CUser = 'Administrator'
WHERE CUser IS NULL
GO


-----------
-- CDate --
-----------
IF NOT EXISTS(SELECT * FROM sys.columns WHERE name = 'CDate' and object_id = object_id('pColorType'))
BEGIN
	 ALTER TABLE pColorType ADD CDate datetime NULL
END
GO

UPDATE pColorType SET CDate = GETUTCDATE()
WHERE CDate IS NULL
GO


-----------
-- MUser --
-----------
IF NOT EXISTS(SELECT * FROM sys.columns WHERE name = 'MUser' and object_id = object_id('pColorType'))
BEGIN
	 ALTER TABLE pColorType ADD MUser nvarchar(200) NULL
END
GO

UPDATE pColorType SET MUser = 'Administrator'
WHERE MUser IS NULL
GO


-----------
-- MDate --
-----------
IF NOT EXISTS(SELECT * FROM sys.columns WHERE name = 'MDate' and object_id = object_id('pColorType'))
BEGIN
	 ALTER TABLE pColorType ADD MDate datetime NULL
END
GO

UPDATE pColorType SET MDate = GETUTCDATE()
WHERE MDate IS NULL
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07688', GetDate())
GO

SET NOCOUNT Off
GO
