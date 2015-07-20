-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 25 February 2011                                                                           */
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

IF NOT EXISTS (select * from Information_Schema.COLUMNS where TABLE_NAME = N'pControlPanel' and COLUMN_NAME = N'IsDataValidation')
BEGIN
    ALTER TABLE pControlPanel ADD IsDataValidation int NULL

    ALTER TABLE pControlPanel ADD CONSTRAINT DF_pControlPanel_IsDataValidation DEFAULT 0 FOR IsDataValidation
END
GO


UPDATE pControlPanel SET IsDataValidation = 0 WHERE IsDataValidation IS NULL
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01669', GetDate())
GO

SET NOCOUNT Off
GO
