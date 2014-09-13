-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 20 Juky 2012                                                                               */
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

SET @DVTableName = 'CRUD'
SET @ControlPanelName = 'CRUD'

IF NOT EXISTS (SELECT * FROM pControlPanel WHERE UPPER(ControlPanelName) = UPPER(@ControlPanelName))
BEGIN

    -- Add the new Data Validation Table.
    EXECUTE spx_DataValidation_ADD_TABLE @DVTableName, @ControlPanelName

    INSERT INTO dvtCRUD (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('Create', 'C', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00001')

    INSERT INTO dvtCRUD (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('Read', 'R', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00002')

    INSERT INTO dvtCRUD (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('Update', 'U', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00003')

    INSERT INTO dvtCRUD (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('Delete', 'D', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00004')

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03723', GetDate())
GO

SET NOCOUNT Off
GO
