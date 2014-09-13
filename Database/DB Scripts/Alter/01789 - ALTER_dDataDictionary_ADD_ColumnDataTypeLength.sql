-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 25 August 2011                                                                             */
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


IF NOT EXISTS (select * from Information_Schema.COLUMNS where TABLE_NAME = N'dDataDictionary' and COLUMN_NAME = N'ColumnDataTypeLength')
BEGIN
    ALTER TABLE dDataDictionary ADD ColumnDataTypeLength int NULL
END
GO  

IF EXISTS (select * from Information_Schema.COLUMNS where TABLE_NAME = N'dDataDictionary' and COLUMN_NAME = N'ColumnDataTypeLength')
BEGIN
    ALTER TABLE dDataDictionary ADD CONSTRAINT DF_dDataDictionary_ColumnDataTypeLength DEFAULT 0 FOR ColumnDataTypeLength
END
GO


UPDATE dDataDictionary SET ColumnDataTypeLength = 0 WHERE ColumnDataTypeLength IS NULL
GO


IF EXISTS (select * from Information_Schema.COLUMNS where TABLE_NAME = N'dColumnDataType' and COLUMN_NAME = N'ColumnDataTypeLength')
BEGIN
	UPDATE dDataDictionary 
	SET ColumnDataTypeLength = (SELECT dColumnDataType.ColumnDataTypeLength
								FROM dColumnDataType
								WHERE dDataDictionary.ColumnDataTypeID = dColumnDataType.ColumnDataTypeID)
	WHERE EXISTS (SELECT dColumnDataType.ColumnDataTypeID
				  FROM dColumnDataType
				  WHERE dDataDictionary.ColumnDataTypeID = dColumnDataType.ColumnDataTypeID)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01789', GetDate())
GO

SET NOCOUNT Off
GO
