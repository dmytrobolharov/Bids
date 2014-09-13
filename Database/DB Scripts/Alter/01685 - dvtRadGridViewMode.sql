-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 4 April 2011                                                                               */
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

SET @DVTableName = 'RadGridViewMode'
SET @ControlPanelName = 'RadGrid View Mode'

IF NOT EXISTS (SELECT * FROM pControlPanel WHERE UPPER(ControlPanelName) = UPPER(@ControlPanelName))
BEGIN

    -- Add the new Data Validation Table.
    EXECUTE spx_DataValidation_ADD_TABLE @DVTableName, @ControlPanelName

    INSERT INTO dvtRadGridViewMode (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('ByRow', 'ByRow', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00001')

    INSERT INTO dvtRadGridViewMode (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('ByCard', 'ByCard', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00002')

    INSERT INTO dvtRadGridViewMode (ItemValue, ItemKey, Active, CUser, CDate, MUser, MDate, ItemSort)
    VALUES ('ByList', 'ByList', 1, 'administrator', getutcdate(), 'administrator', getutcdate(), '00003')

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01685', GetDate())
GO

SET NOCOUNT Off
GO
