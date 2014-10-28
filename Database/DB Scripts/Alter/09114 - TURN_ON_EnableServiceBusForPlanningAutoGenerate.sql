-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 16 September 2014                                                                          */
-- *                                                                                            */
-- * Copyright (c) 2002-2014 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS:
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

UPDATE sAppSetting
SET AppSettingValue = 'TRUE'
WHERE ConfigFileName = 'LINEPLAN'
AND AppSettingKey = 'EnableServiceBusForPlanningAutoGenerate'
GO


SET NOCOUNT OFF
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '09114', GetDate())
GO
