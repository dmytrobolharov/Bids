-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 18 April 2012                                                                              */
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


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_SpreadsheetFile_INSERT')
   DROP PROCEDURE spx_SpreadsheetFile_INSERT
GO


CREATE PROCEDURE spx_SpreadsheetFile_INSERT
(
	@SpreadsheetFileID UniqueIdentifier,
	@SpreadsheetFileName NVarChar(256),
	@SpreadsheetFileSize NVarChar(20),
	@SpreadsheetFile VarBinary(MAX),
	@CUser NVarChar(200),
	@CDate DateTime
)
AS 

IF NOT EXISTS(SELECT SpreadsheetFileID FROM sSpreadsheetFile WHERE SpreadsheetFileID = @SpreadsheetFileID)
BEGIN

	INSERT INTO sSpreadsheetFile(SpreadsheetFileID, SpreadsheetFileName, SpreadsheetFileSize, SpreadsheetFile, CUser, CDate, MUser, MDate)
	VALUES(@SpreadsheetFileID, @SpreadsheetFileName, @SpreadsheetFileSize, @SpreadsheetFile, @CUser, @CDate, @CUser, @CDate)

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03382', GetDate())
GO

SET NOCOUNT Off
GO
