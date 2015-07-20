-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 03 May 2012                                                                                */
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

IF EXISTS (select * from sysobjects where id = object_id('spx_Information_Schema_Table_Column_With_DD_SELECT') and sysstat & 0xf = 4)
    drop procedure spx_Information_Schema_Table_Column_With_DD_SELECT
GO


CREATE PROCEDURE spx_Information_Schema_Table_Column_With_DD_SELECT
(
    @TableName VarChar(128)
)
AS 
BEGIN

	SELECT DISTINCT KU.Constraint_Name, c.Table_Name, c.Column_Name, c.Ordinal_Position, c.Column_Default,
	c.Is_Nullable, c.Data_Type, c.Character_Maximum_Length,
	dd.*, cdt.ColumnDataTypeName, ct.ColumnTypeName

	FROM information_schema.COLUMNS c
	LEFT JOIN information_schema.KEY_COLUMN_USAGE AS KU ON KU.TABLE_NAME = c.TABLE_NAME
													   AND KU.TABLE_CATALOG = c.TABLE_CATALOG
													   AND KU.COLUMN_NAME = c.COLUMN_NAME
	LEFT OUTER JOIN dDataDictionary dd ON dd.ColumnName = c.COLUMN_NAME
	LEFT OUTER JOIN dColumnType ct ON dd.ColumnTypeID = ct.ColumnTypeID
	LEFT OUTER JOIN dColumnDataType cdt ON dd.ColumnDataTypeID = cdt.ColumnDataTypeID

	WHERE UPPER(c.TABLE_NAME) = UPPER(@TableName)

	ORDER BY c.TABLE_NAME, c.Ordinal_Position

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03410', GetDate())
GO

SET NOCOUNT Off
GO
