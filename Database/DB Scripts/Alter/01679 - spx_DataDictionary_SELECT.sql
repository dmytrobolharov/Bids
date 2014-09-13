-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 10 March 2011                                                                              */
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DataDictionary_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_DataDictionary_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_DataDictionary_SELECT] 
(
    @ColumnID uniqueidentifier = NULL
)
AS
BEGIN

    IF @ColumnID IS NULL
    BEGIN

        SELECT dd.*, cdt.ColumnDataTypeName, ct.ColumnTypeName
        FROM dDataDictionary dd
        INNER JOIN dColumnType ct ON dd.ColumnTypeID = ct.ColumnTypeID
        INNER JOIN dColumnDataType cdt ON dd.ColumnDataTypeID = cdt.ColumnDataTypeID
        ORDER BY dd.ColumnAlias

    END

    ELSE
    BEGIN

        SELECT dd.*, cdt.ColumnDataTypeName, ct.ColumnTypeName
        FROM dDataDictionary dd
        INNER JOIN dColumnType ct ON dd.ColumnTypeID = ct.ColumnTypeID
        INNER JOIN dColumnDataType cdt ON dd.ColumnDataTypeID = cdt.ColumnDataTypeID
        WHERE dd.ColumnID = @ColumnID

    END

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01679', GetDate())
GO

SET NOCOUNT Off
GO
