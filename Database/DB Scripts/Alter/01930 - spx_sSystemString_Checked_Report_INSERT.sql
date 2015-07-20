-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 31 August 2011                                                                             */
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'spx_sSystemString_Checked_Report_INSERT') AND type = N'P' )
	DROP PROCEDURE spx_sSystemString_Checked_Report_INSERT
GO


CREATE PROCEDURE spx_sSystemString_Checked_Report_INSERT
(
	@DesignString nvarchar(4000),
	@DesignFormXML varchar(500),
	@IsUserString bit
)
AS 

DECLARE @DesignStringID UNIQUEIDENTIFIER

If @IsUserString = 1
BEGIN

	IF (SELECT COUNT(*) FROM sUserStrings WHERE DesignString = @DesignString) = 0
	BEGIN
		INSERT INTO sUserStrings (DesignString) VALUES (@DesignString)
	END

	SELECT @DesignStringID = UserStringID FROM sUserStrings WHERE DesignString = @DesignString

	IF (SELECT COUNT(*) FROM sUserXMLStrings WHERE XMLName = @DesignFormXML AND UserStringID = @DesignStringID) = 0
	BEGIN
		INSERT INTO sUserXMLStrings (XMLName, UserStringID) VALUES (@DesignFormXML, @DesignStringID)
	END

END
ELSE
BEGIN

	IF (SELECT COUNT(*) FROM sSystemStrings WHERE DesignString = @DesignString) = 0
	BEGIN
		INSERT INTO sSystemStrings (DesignString) VALUES (@DesignString)
	END

	SELECT @DesignStringID = SystemStringID FROM sSystemStrings WHERE DesignString = @DesignString

	IF (SELECT COUNT(*) FROM sSystemPageStrings WHERE FormName = @DesignFormXML AND SystemStringID = @DesignStringID) = 0
	BEGIN
		INSERT INTO sSystemPageStrings (FormName, SystemStringID) VALUES (@DesignFormXML, @DesignStringID)
	END

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01930', GetDate())
GO

SET NOCOUNT Off
GO
