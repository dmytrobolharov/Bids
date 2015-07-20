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

SET @DVTableName = 'ValidatorClass'
SET @ControlPanelName = 'Validator Class'

IF NOT EXISTS (SELECT * FROM pControlPanel WHERE UPPER(ControlPanelName) = UPPER(@ControlPanelName))
BEGIN

    -- Add the new Data Validation Table.
    EXECUTE spx_DataValidation_ADD_TABLE @DVTableName, @ControlPanelName

    INSERT INTO dvtValidatorClass (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('range', 'range', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00001')

    INSERT INTO dvtValidatorClass (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('dropdown', 'dropdown', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00002')

    INSERT INTO dvtValidatorClass (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('required', 'required', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00003')

    INSERT INTO dvtValidatorClass (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('date', 'date', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00004')

    INSERT INTO dvtValidatorClass (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('dateus', 'dateus', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00005')

    INSERT INTO dvtValidatorClass (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('dateeu', 'dateeu', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00006')

    INSERT INTO dvtValidatorClass (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('daterequired', 'datereq', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00007')

    INSERT INTO dvtValidatorClass (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('dateeyrequired', 'dateeureq', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00008')

    INSERT INTO dvtValidatorClass (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('email', 'email', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00009')

    INSERT INTO dvtValidatorClass (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('currency', 'currency', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00010')

    INSERT INTO dvtValidatorClass (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('memo', 'memo', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00011')

    INSERT INTO dvtValidatorClass (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('length', 'length', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00012')

    INSERT INTO dvtValidatorClass (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('validationexpression', 'validexp', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00013')

    INSERT INTO dvtValidatorClass (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('decimal', 'decimal', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00014')

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01688', GetDate())
GO

SET NOCOUNT Off
GO
