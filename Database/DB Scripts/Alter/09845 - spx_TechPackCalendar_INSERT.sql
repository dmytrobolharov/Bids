IF OBJECT_ID(N'[dbo].[spx_TechPackCalendar_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_TechPackCalendar_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_TechPackCalendar_INSERT]
(@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime)
AS 

BEGIN
	INSERT INTO pStyleCalendarTemp
		(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
	SELECT  @CalendarId AS CalendarId, sh.StyleID, sh.TechPackID, sh.DevelopmentID, TechPackDate, 'TechPack' AS CalendarType, 'N', 
		sh.StyleNo + ' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription
	FROM pStyleHeader sh WITH (NOLOCK) 
	INNER JOIN pTechPackTeam WITH (NOLOCK) ON sh.TechpackID = pTechPackTeam.TechpackId
	LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	WHERE (sh.Active = 1) AND (sh.TechPackDate BETWEEN @StartDate AND @EndDate) AND 
	(sh.TechPackID IS NOT NULL) AND 
	(pTechPackTeam.TradePartner = 1) AND (pTechPackTeam.TechPackDownload = 0)
END  

BEGIN
	INSERT INTO pStyleCalendarTemp
		(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
	SELECT  @CalendarId AS CalendarId, sh.StyleID, sh.TechPackID, sh.DevelopmentID, TechPackDate, 'TechPack' AS CalendarType, 'D', 
		sh.StyleNo + ' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription
	FROM  pTechPackActivity WITH (NOLOCK) 
	INNER JOIN pTechPackTeam WITH (NOLOCK) ON pTechPackActivity.TeamID = pTechPackTeam.TeamID AND 
		                                      pTechPackActivity.TechPackID = pTechPackTeam.TechPackID 
    INNER JOIN pStyleHeader sh WITH (NOLOCK) ON pTechPackTeam.TechPackID = sh.TechPackId
	LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	WHERE (sh.Active = 1) AND (sh.TechPackDate BETWEEN @StartDate AND @EndDate) AND 
	(sh.TechPackID IS NOT NULL) AND 
	(pTechPackTeam.TradePartner = 1) AND (pTechPackTeam.TechPackDownload = 1) AND pTechPackActivity.ActivityType = 'D'
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09845', GetDate())
GO
