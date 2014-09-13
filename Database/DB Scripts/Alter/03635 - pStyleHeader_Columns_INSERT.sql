-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 14 June 2012                                                                               */
-- * WorkItem #9008                                                               */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleHeader' and COLUMN_NAME = N'DesignSketchBackID')
BEGIN 
	ALTER TABLE pStyleHeader ADD DesignSketchBackID  UNIQUEIDENTIFIER NULL
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleHeader' and COLUMN_NAME = N'DesignSketchBackVersion')
BEGIN 
	ALTER TABLE pStyleHeader ADD DesignSketchBackVersion  UNIQUEIDENTIFIER NULL
END


IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleColorwaySeasonYear' and COLUMN_NAME = N'DesignImageFrontVersion')
BEGIN 	
	ALTER TABLE pStyleColorwaySeasonYear ADD DesignImageFrontVersion  INT NULL
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleColorwaySeasonYear' and COLUMN_NAME = N'DesignImageFrontId')
BEGIN 	
	ALTER TABLE pStyleColorwaySeasonYear ADD DesignImageFrontId  UNIQUEIDENTIFIER NULL
END	

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleColorwaySeasonYear' and COLUMN_NAME = N'DesignImageBackVersion')
BEGIN 
	ALTER TABLE pStyleColorwaySeasonYear ADD DesignImageBackVersion  INT NULL
END	


IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleColorwaySeasonYear' and COLUMN_NAME = N'DesignImageBackId')
BEGIN 
	ALTER TABLE pStyleColorwaySeasonYear ADD DesignImageBackId  UNIQUEIDENTIFIER NULL
END	



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03635', GetDate())
	

GO

