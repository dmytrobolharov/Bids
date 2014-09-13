-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 18 April 2011                                                                              */
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

-- Make sure the record does not already exist.
DECLARE @DVTableName nvarchar(50)
DECLARE @ControlPanelName nvarchar(50)

SET @DVTableName = 'ValidatorType'
SET @ControlPanelName = 'Validator Type'

IF NOT EXISTS (SELECT * FROM pControlPanel WHERE UPPER(ControlPanelName) = UPPER(@ControlPanelName))
BEGIN

    -- Add the new Data Validation Table.
    EXECUTE spx_DataValidation_ADD_TABLE @DVTableName, @ControlPanelName

    INSERT INTO dvtValidatorType (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('currency', 'currency', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00001')

    INSERT INTO dvtValidatorType (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('integer', 'integer', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00002')

    INSERT INTO dvtValidatorType (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('double', 'double', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00003')

    INSERT INTO dvtValidatorType (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('date', 'date', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00004')

    INSERT INTO dvtValidatorType (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('datetime', 'datetime', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00005')

    INSERT INTO dvtValidatorType (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('string', 'string', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00006')

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01689', GetDate())
GO

SET NOCOUNT Off
GO
