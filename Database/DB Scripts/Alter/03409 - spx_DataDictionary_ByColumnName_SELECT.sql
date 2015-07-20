-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 02 May 2012                                                                                */
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


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_DataDictionary_ByColumnName_SELECT')
   DROP PROCEDURE spx_DataDictionary_ByColumnName_SELECT
GO

CREATE PROCEDURE [dbo].[spx_DataDictionary_ByColumnName_SELECT] 
(
    @ColumnName nvarchar(50)
)
AS

BEGIN

    SELECT dd.*, cdt.ColumnDataTypeName, ct.ColumnTypeName
    FROM dDataDictionary dd
    INNER JOIN dColumnType ct ON dd.ColumnTypeID = ct.ColumnTypeID
    INNER JOIN dColumnDataType cdt ON dd.ColumnDataTypeID = cdt.ColumnDataTypeID
    WHERE UPPER(dd.ColumnName) = UPPER(@ColumnName)

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03409', GetDate())
GO

SET NOCOUNT Off
GO
