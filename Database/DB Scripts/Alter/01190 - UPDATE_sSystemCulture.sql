-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 24 February 2011                                                                           */
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

IF EXISTS (select * from Information_Schema.COLUMNS where TABLE_NAME = N'sSystemCulture' and COLUMN_NAME = N'CultureName' and CHARACTER_MAXIMUM_LENGTH < 10)
BEGIN
    ALTER Table sSystemCulture ALTER COLUMN CultureName VARCHAR(10)
END

-- UPDATE sSystemCulture
-- SET CultureName = 'zh-Hans'
-- WHERE CultureName = 'zh-CHS'
-- GO

-- UPDATE sSystemCulture
-- SET CultureName = 'zh-Hant'
-- WHERE CultureName = 'zh-CHT'
-- GO

-- UPDATE sSystemCulture
-- SET CultureName = 'ja-JP'
-- WHERE CultureName = 'ja-JA'
-- GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.0.0000', '01190', GetDate())
GO
