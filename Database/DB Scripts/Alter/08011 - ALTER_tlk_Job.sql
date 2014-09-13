-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 12 June 2014                                                                               */
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

IF NOT EXISTS
(
	SELECT * 
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_NAME = 'tlk_Job'
	AND COLUMN_NAME = 'PreviousJobHash'
)
BEGIN
	ALTER TABLE [dbo].[tlk_Job] ADD [PreviousJobHash] nvarchar(256) NULL
END
GO


UPDATE [dbo].[tlk_Job] SET [PreviousJobHash] = 'PreviousJobHash' + CAST(([ID] - 1) AS nvarchar(256)) WHERE [PreviousJobHash] IS NULL
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '08011', GetDate())
GO

SET NOCOUNT Off
GO
