-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 8 April 2012                                                                               */
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


IF NOT EXISTS (select * from Information_Schema.COLUMNS where TABLE_NAME = N'dDataDictionary' and COLUMN_NAME = N'CoreColumn')
BEGIN
    ALTER TABLE dDataDictionary ADD CoreColumn int NULL
END
GO  

IF EXISTS (select * from Information_Schema.COLUMNS where TABLE_NAME = N'dDataDictionary' and COLUMN_NAME = N'CoreColumn')
BEGIN
    ALTER TABLE dDataDictionary ADD CONSTRAINT DF_dDataDictionary_CoreColumn DEFAULT 0 FOR CoreColumn
END
GO


UPDATE dDataDictionary SET CoreColumn = 0 WHERE CoreColumn IS NULL
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03323', GetDate())
GO

SET NOCOUNT Off
GO
