-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 3 June 2011                                                                                */
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

-- Insert default record into pColorFolder
IF NOT EXISTS (SELECT * FROM pColorFolder WHERE ColorFolderID = '00000000-0000-0000-0000-000000000001')
	BEGIN
		INSERT INTO pColorFolder (ColorFolderID, ColorFolderDescription, CUser, CDate, MUser, MDate, MChange, Active, StyleColorway, SystemServerStorageID, ColorTypeID)
		VALUES ('00000000-0000-0000-0000-000000000001', 'plmOn Default', 'System', GETUTCDATE(), 'System', GETUTCDATE(), 1, 1, 0, '00000000-0000-0000-0000-000000000001', 0)
	END
	GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0001', '01494', GetDate())
GO
