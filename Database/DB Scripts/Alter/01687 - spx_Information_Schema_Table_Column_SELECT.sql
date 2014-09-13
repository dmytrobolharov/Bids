-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 5 April 2011                                                                               */
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

IF EXISTS (select * from sysobjects where id = object_id('spx_Information_Schema_Table_Column_SELECT') and sysstat & 0xf = 4)
    drop procedure spx_Information_Schema_Table_Column_SELECT
GO


CREATE PROCEDURE spx_Information_Schema_Table_Column_SELECT
(
    @TableName VarChar(128)
)
AS 
BEGIN

    SELECT KU.Constraint_Name, c.Table_Name, c.Column_Name, c.Ordinal_Position, c.Column_Default,
    c.Is_Nullable, c.Data_Type, c.Character_Maximum_Length

    FROM information_schema.COLUMNS C
    LEFT JOIN information_schema.KEY_COLUMN_USAGE AS KU ON KU.TABLE_NAME = C.TABLE_NAME
                                                       AND KU.TABLE_CATALOG = C.TABLE_CATALOG
                                                       AND KU.COLUMN_NAME = C.COLUMN_NAME

    WHERE UPPER(C.TABLE_NAME) = UPPER(@TableName)

    ORDER BY C.TABLE_NAME, C.Ordinal_Position

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01687', GetDate())
GO

SET NOCOUNT Off
GO
