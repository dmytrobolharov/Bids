IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackCalendarShared_INSERT]') AND type in (N'P', N'PC'))
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

		pStyleHeader.StyleID, 

		pStyleHeader.TechPackID, 

		pStyleHeader.DevelopmentID, 

		TechPackDate, 'TechPack' AS CalendarType, 

		'N', 

		pStyleHeader.StyleNo + ' (' + pStyleHeader.SizeClass + ') ' + pStyleHeader.Description AS CalendarDescription

	FROM pTechPack WITH (NOLOCK) 
	INNER JOIN pTechPackTeam WITH (NOLOCK) ON pTechPack.TechPackID = pTechPackTeam.TechPackID 
	INNER JOIN pStyleHeader WITH (NOLOCK) ON pTechPack.StyleID = pStyleHeader.StyleID
	LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl WITH (NOLOCK) ON pTechPackTeam.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID	

	WHERE (pStyleHeader.Active = 1) 

	AND (pStyleHeader.TechPackDate BETWEEN @StartDate AND @EndDate) 

	AND (pStyleHeader.TechPackID IS NOT NULL)  
	
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

	pStyleHeader.StyleID,

	pStyleHeader.TechPackID,

	pStyleHeader.DevelopmentID,

	pTechPackActivity.CDate, 'TechPack' AS CalendarType, 'D', 

	pStyleHeader.StyleNo + ' (' + pStyleHeader.SizeClass + ') ' + pStyleHeader.Description AS CalendarDescription, 

	1	

	FROM pTechPack WITH (NOLOCK) 
	INNER JOIN pTechPackActivity WITH (NOLOCK)ON pTechPack.TechPackID= pTechPackActivity.TechPackID 
	INNER JOIN pTechPackTeam WITH (NOLOCK) ON pTechPack.TechPackID = pTechPackTeam.TechPackID 
	INNER JOIN pStyleHeader WITH (NOLOCK) ON pTechPack.StyleID = pStyleHeader.StyleID	
	LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl WITH (NOLOCK) ON pTechPackTeam.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
	
	WHERE (pStyleHeader.Active = 1) 

	AND (pStyleHeader.TechPackDate BETWEEN @StartDate AND @EndDate) 

	AND (pStyleHeader.TechPackID IS NOT NULL)  

	AND ((pTechPackTeam.TeamID = @TradePartnerId) OR (@TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID)))

	AND (pTechPackTeam.TradePartner = 1) 

	AND (pTechPackTeam.TechPackDownload = 1) 

	AND pTechPackActivity.ActivityType = 'D'

	

END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06545', GetDate())
GO
