-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 14 December 2010                                                                           */
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
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'vwx_Users_SELECT') AND type = N'V' )
	DROP VIEW vwx_Users_SELECT
GO

CREATE VIEW vwx_Users_SELECT
AS
SELECT     Users.*, sSystemCulture.CultureCountry + ' [' + sSystemCulture.CultureLanguage + ']' AS 'PreferredLangName'
FROM       Users LEFT OUTER JOIN
           sSystemCulture ON Users.PreferredLang = sSystemCulture.CultureName
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '867', GetDate())
GO
