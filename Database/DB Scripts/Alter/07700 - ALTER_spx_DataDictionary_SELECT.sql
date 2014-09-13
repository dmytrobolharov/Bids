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


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_DataDictionary_SELECT')
BEGIN
   DROP PROCEDURE [dbo].[spx_DataDictionary_SELECT] 
END
GO

CREATE PROCEDURE [dbo].[spx_DataDictionary_SELECT] 
(
    @ColumnID uniqueidentifier = NULL,
    @ExcludeCoreColumns int = NULL,
    @ExcludeCustomColumns int = NULL
)
AS
BEGIN
    IF @ColumnID IS NULL
    BEGIN
		IF @ExcludeCoreColumns IS NULL
		BEGIN
			SET @ExcludeCoreColumns = 0
		END

		IF @ExcludeCustomColumns IS NULL
		BEGIN
			SET @ExcludeCustomColumns = 0
		END

		DECLARE @CoreColumnsGuid uniqueidentifier
		DECLARE @CustomColumnsGuid uniqueidentifier

		IF @ExcludeCoreColumns = 0
		BEGIN
			SET @CoreColumnsGuid = CAST('00000000-0000-0000-0000-000000000000' AS uniqueidentifier)
		END
		ELSE
		BEGIN
			SET @CoreColumnsGuid = CAST('00000000-0000-0000-0000-000000000002' AS uniqueidentifier)
		END

		IF @ExcludeCustomColumns = 0
		BEGIN
			SET @CustomColumnsGuid = CAST('00000000-0000-0000-0000-000000000001' AS uniqueidentifier)
		END
		ELSE
		BEGIN
			SET @CustomColumnsGuid = CAST('00000000-0000-0000-0000-000000000002' AS uniqueidentifier)
		END

		SELECT *
		FROM sSchemaFileTableColumn
		WHERE FileID = @CoreColumnsGuid OR FileID = @CustomColumnsGuid
		ORDER BY alias
    END

    ELSE
    BEGIN
		SELECT *
		FROM sSchemaFileTableColumn
        WHERE ColumnID = @ColumnID
    END
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07700', GetDate())
GO

SET NOCOUNT Off
GO
