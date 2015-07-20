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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DataDictionary_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_DataDictionary_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_DataDictionary_INSERT] 
(
    @ColumnID uniqueidentifier,
    @ColumnName nvarchar(50),
    @ColumnAlias nvarchar(200) = NULL,
    @ColumnDataTypeID uniqueidentifier,
    @ColumnTypeID uniqueidentifier,
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
                                 CUser,
                                 CDate,
                                 MUser,
                                 MDate) 
    VALUES (@ColumnID,
            @ColumnName,
            @ColumnAlias,
            @ColumnDataTypeID,
            @ColumnTypeID,
            @CUser, 
            @CDate, 
            @CUser, 
            @CDate)

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01678', GetDate())
GO

SET NOCOUNT Off
GO
