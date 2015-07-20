IF OBJECT_ID(N'[dbo].[spx_TechPackCalendarShared_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_TechPackCalendarShared_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_TechPackCalendarShared_INSERT]

(@TradePartnerId nvarchar(50),

@CalendarId nvarchar(50),

@StartDate datetime,

@EndDate datetime)

AS 



BEGIN	

	

	INSERT INTO pStyleCalendarTemp

	(

		CalendarId, 

		PKeyId, 

		CalendarLinkId, 

		CalendarLinkSubId, 

		CalendarDate, 

		CalendarType, 

		CalendarStatus, 

		CalendarDescription

	)

	SELECT  
	
		DISTINCT
	
		@CalendarId AS CalendarId, 

		sh.StyleID, 

		sh.TechPackID, 

		sh.DevelopmentID, 

		TechPackDate, 'TechPack' AS CalendarType, 

		'N', 

		sh.StyleNo + ' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription

	FROM pTechPack WITH (NOLOCK) 
	INNER JOIN pTechPackTeam WITH (NOLOCK) ON pTechPack.TechPackID = pTechPackTeam.TechPackID 
	INNER JOIN pStyleHeader sh WITH (NOLOCK) ON pTechPack.StyleID = sh.StyleID
	LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl WITH (NOLOCK) ON pTechPackTeam.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID	
	LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId

	WHERE (sh.Active = 1) 

	AND (sh.TechPackDate BETWEEN @StartDate AND @EndDate) 

	AND (sh.TechPackID IS NOT NULL)  
	
	AND ((pTechPackTeam.TeamID = @TradePartnerId) OR (@TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID)))

	AND (pTechPackTeam.TradePartner = 1) AND (pTechPackTeam.TechPackDownload = 0)	

	

END  



BEGIN

	

	INSERT INTO pStyleCalendarTemp

	(

		CalendarId, 

		PKeyId, 

		CalendarLinkId, 

		CalendarLinkSubId, 

		CalendarDate,

		CalendarType,

		CalendarStatus,

		CalendarDescription,

		CalendarView

	)

	SELECT  
	
	@CalendarId AS CalendarId, 

	sh.StyleID,

	sh.TechPackID,

	sh.DevelopmentID,

	pTechPackActivity.CDate, 'TechPack' AS CalendarType, 'D', 

	sh.StyleNo + ' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + sh.Description AS CalendarDescription, 

	1	

	FROM pTechPack WITH (NOLOCK) 
	INNER JOIN pTechPackActivity WITH (NOLOCK)ON pTechPack.TechPackID= pTechPackActivity.TechPackID 
	INNER JOIN pTechPackTeam WITH (NOLOCK) ON pTechPack.TechPackID = pTechPackTeam.TechPackID 
	INNER JOIN pStyleHeader sh WITH (NOLOCK) ON pTechPack.StyleID = sh.StyleID	
	LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl WITH (NOLOCK) ON pTechPackTeam.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
	LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	WHERE (sh.Active = 1) 

	AND (sh.TechPackDate BETWEEN @StartDate AND @EndDate) 

	AND (sh.TechPackID IS NOT NULL)  

	AND ((pTechPackTeam.TeamID = @TradePartnerId) OR (@TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID)))

	AND (pTechPackTeam.TradePartner = 1) 

	AND (pTechPackTeam.TechPackDownload = 1) 

	AND pTechPackActivity.ActivityType = 'D'

	

END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09851', GetDate())
GO
