-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 23 August 2012                                                                             */
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SystemButtons_IMPORT_MISSING]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_SystemButtons_IMPORT_MISSING]
GO


CREATE PROCEDURE [dbo].[spx_SystemButtons_IMPORT_MISSING]
AS 
BEGIN

	EXEC spx_SystemButtons_IMPORT_MISSING_TABLE 'D'
	EXEC spx_SystemButtons_IMPORT_MISSING_TABLE 'T'
	EXEC spx_SystemButtons_IMPORT_MISSING_TABLE 'A'

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03800', GetDate())
GO

SET NOCOUNT Off
GO
