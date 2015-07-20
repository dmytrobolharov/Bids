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


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_SpreadsheetFile_UPDATE')
   DROP PROCEDURE spx_SpreadsheetFile_UPDATE
GO


CREATE PROCEDURE spx_SpreadsheetFile_UPDATE
(
	@SpreadsheetFileID UniqueIdentifier,
	@SpreadsheetFileSize NVarChar(20),
	@SpreadsheetFile VarBinary(MAX),
	@MUser NVarChar(200),
	@MDate DateTime
)
AS 

IF EXISTS(SELECT SpreadsheetFileID FROM sSpreadsheetFile WHERE SpreadsheetFileID = @SpreadsheetFileID)
BEGIN

	UPDATE sSpreadsheetFile
	SET SpreadsheetFileSize = @SpreadsheetFileSize,
	SpreadsheetFile = @SpreadsheetFile,
	MUser = @MUser,
	MDate = @MDate
	WHERE SpreadsheetFileID = @SpreadsheetFileID

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03383', GetDate())
GO

SET NOCOUNT Off
GO
