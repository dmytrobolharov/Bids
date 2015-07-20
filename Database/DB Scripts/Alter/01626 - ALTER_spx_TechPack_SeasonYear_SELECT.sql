-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 30 June 2011                                                                               */
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


IF EXISTS (select * from sysobjects where id = object_id('spx_TechPack_SeasonYear_SELECT') and sysstat & 0xf = 4)
    drop procedure spx_TechPack_SeasonYear_SELECT
GO


CREATE PROCEDURE spx_TechPack_SeasonYear_SELECT
(@TechPackId uniqueidentifier)  
AS   

SELECT a.*, b.Season AS Season, b.Year AS [YEAR], 
       e.CultureName, e.CultureLanguage + ' (' + e.CultureCountry + ')' AS CultureDesc
FROM pTechPack a WITH (NOLOCK)
LEFT OUTER JOIN pStyleSeasonYear c ON a.StyleSeasonYearID = c.StyleSeasonYearID
LEFT OUTER JOIN pSeasonYear b ON c.SeasonYearID  = b.SeasonYearID  
LEFT OUTER JOIN sSystemCulture e ON a.SystemCultureId = e.SystemCultureId
WHERE a.TechPackID = @TechPackId 
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES      ('DB_Version', '4.1.0000', '01626', GetDate())
GO
