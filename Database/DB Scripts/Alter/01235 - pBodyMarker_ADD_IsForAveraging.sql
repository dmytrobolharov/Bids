-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 9 March 2011                                                                               */
-- *                                                                                            */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
IF NOT EXISTS (select * from Information_Schema.COLUMNS where TABLE_NAME = N'pBodyMarker' and COLUMN_NAME = N'IsForAveraging')
BEGIN
    ALTER TABLE pBodyMarker ADD IsForAveraging int NULL

    ALTER TABLE pBodyMarker ADD CONSTRAINT
	    DF_pBodyMarker_IsForAveraging DEFAULT 1 FOR IsForAveraging
END
GO

UPDATE pBodyMarker SET IsForAveraging = 1 WHERE IsForAveraging IS NULL
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.0.0000', '01235', GetDate())
GO
