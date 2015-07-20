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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'vwx_TechPack_SEL') AND type = N'V')
	DROP VIEW vwx_TechPack_SEL
GO


CREATE VIEW vwx_TechPack_SEL
AS
SELECT	CASE WHEN dbo.pTechPack.TechPackID = dbo.pStyleHeader.TechPackId 
             THEN CASE WHEN dbo.pTechPack.StyleVersion = dbo.pStyleHeader.Change 
                       THEN '<img  src=''../System/Icons/icon_packageok.gif'' >'
		               ELSE '<img  src=''../System/Icons/icon_packagefail.gif'' >' 
		          END 
		     ELSE CASE WHEN dbo.pTechPack.StyleVersion = dbo.pStyleHeader.Change 
		               THEN '<img  src=''../System/Icons/icon_packageok.gif'' >'
		               ELSE '<img  src=''../System/Icons/icon_packagefail.gif'' >' 
		          END 
		     END AS ImagePath, 
		dbo.pTechPack.TechPackID, dbo.pTechPack.TechPackNo, dbo.pTechPack.TechPackStatus, 
		dbo.pTechPack.TechPackName, dbo.pTechPack.StyleID, dbo.pTechPack.CDate, dbo.pTechPack.CUser, 
		dbo.pStyleHeader.TechPackId AS FinalTechPackId, dbo.pTechPack.Notes, dbo.pStyleHeader.TechPackDate AS FinalTechPackDate, 
		dbo.pTechPack.StyleVersion AS TechPackStyleVersion, dbo.pStyleHeader.Change AS StyleVersion, 
		dbo.pTechPack.TechPackRelease, b.Season, b.Year, dbo.sSystemCulture.CultureName, 
		dbo.sSystemCulture.CultureLanguage + ' (' + dbo.sSystemCulture.CultureCountry + ')' AS CultureDesc
FROM	dbo.pTechPack WITH (NOLOCK) 
		INNER JOIN dbo.pStyleHeader WITH (NOLOCK) ON dbo.pTechPack.StyleID = dbo.pStyleHeader.StyleID 
		LEFT OUTER JOIN dbo.pStyleSeasonYear AS c ON dbo.pTechPack.StyleSeasonYearID = c.StyleSeasonYearID 
		LEFT OUTER JOIN dbo.pSeasonYear AS b ON c.SeasonYearID = b.SeasonYearID
		LEFT OUTER JOIN dbo.sSystemCulture ON dbo.pTechPack.SystemCultureId = dbo.sSystemCulture.SystemCultureId
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES      ('DB_Version', '4.1.0000', '01625', GetDate())
GO
