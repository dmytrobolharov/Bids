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


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_DataDictionary_ByColumnName_SELECT')
BEGIN
   DROP PROCEDURE [dbo].[spx_DataDictionary_ByColumnName_SELECT] 
END
GO

CREATE PROCEDURE [dbo].[spx_DataDictionary_ByColumnName_SELECT] 
(
    @ColumnName nvarchar(max)
)
AS
BEGIN
	SELECT *
	FROM sSchemaFileTableColumn
	WHERE (FileID = CAST('00000000-0000-0000-0000-000000000000' AS uniqueidentifier)
	OR FileID = CAST('00000000-0000-0000-0000-000000000001' AS uniqueidentifier))
	AND UPPER(Name) = UPPER(@ColumnName)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07699', GetDate())
GO

SET NOCOUNT Off
GO
