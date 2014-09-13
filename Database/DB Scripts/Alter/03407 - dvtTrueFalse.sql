-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 25 April 2012                                                                              */
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

-- Make sure the record does not already exist.
DECLARE @DVTableName nvarchar(50)
DECLARE @ControlPanelName nvarchar(50)

SET @DVTableName = 'TrueFalse'
SET @ControlPanelName = 'True/False'

IF NOT EXISTS (SELECT * FROM pControlPanel WHERE UPPER(ControlPanelName) = UPPER(@ControlPanelName))
BEGIN

    -- Add the new Data Validation Table.
    EXECUTE spx_DataValidation_ADD_TABLE @DVTableName, @ControlPanelName

    INSERT INTO dvtTrueFalse (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('false', '0', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00001')

    INSERT INTO dvtTrueFalse (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('true', '1', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00002')

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03407', GetDate())
GO

SET NOCOUNT Off
GO
