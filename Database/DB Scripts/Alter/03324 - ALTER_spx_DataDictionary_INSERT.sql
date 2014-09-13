-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 9 April 2012                                                                               */
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


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_DataDictionary_INSERT')
   DROP PROCEDURE spx_DataDictionary_INSERT
GO

CREATE PROCEDURE [dbo].[spx_DataDictionary_INSERT] 
(
    @ColumnID uniqueidentifier,
    @ColumnName nvarchar(50),
    @ColumnAlias nvarchar(200) = NULL,
    @ColumnDataTypeID uniqueidentifier,
    @ColumnTypeID uniqueidentifier,
    @ColumnDataTypeLength int,
    @CoreColumn int,
    @CUser nvarchar(50) = NULL,
	@CDate datetime = NULL
)
AS

BEGIN

    SET @ColumnAlias = ISNULL(@ColumnAlias, @ColumnName)

    INSERT INTO dDataDictionary (ColumnID,
                                 ColumnName,
                                 ColumnAlias,
                                 ColumnDataTypeID,
                                 ColumnTypeID,
                                 ColumnCellWidth,
                                 ColumnSearch,
                                 ColumnGridWidth,
                                 ColumnGridSearch,
                                 ColumnSelect,
                                 ColumnAutoPostBack,
                                 ColumnAddNullField,
                                 ColumnDataTypeLength,
                                 CoreColumn,
                                 CUser,
                                 CDate,
                                 MUser,
                                 MDate) 
    VALUES (@ColumnID,
            @ColumnName,
            @ColumnAlias,
            @ColumnDataTypeID,
            @ColumnTypeID,
            '150px',
            0,
            75,
            0,
            0,
            0,
            0,
            @ColumnDataTypeLength,
            @CoreColumn,
            @CUser, 
            @CDate, 
            @CUser, 
            @CDate)

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03324', GetDate())
GO

SET NOCOUNT Off
GO
