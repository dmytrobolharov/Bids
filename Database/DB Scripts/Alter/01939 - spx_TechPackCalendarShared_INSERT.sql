-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 14 September 2011                                                                           */
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

SET NOCOUNT ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'spx_TechPackCalendarShared_INSERT') AND type = N'P' )
	DROP PROCEDURE spx_TechPackCalendarShared_INSERT
	
GO
/****** Object:  StoredProcedure [dbo].[spx_TechPackCalendarShared_INSERT]    Script Date: 09/14/2011 12:57:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_TechPackCalendarShared_INSERT]
(@TradePartnerId varchar(50),
@CalendarId varchar(50),
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
	WHERE (pStyleHeader.Active = 1) 
	AND (pStyleHeader.TechPackDate BETWEEN @StartDate AND @EndDate) 
	AND (pStyleHeader.TechPackID IS NOT NULL)  AND (pTechPackTeam.TeamID = @TradePartnerId) 
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
	WHERE (pStyleHeader.Active = 1) 
	AND (pStyleHeader.TechPackDate BETWEEN @StartDate AND @EndDate) 
	AND (pStyleHeader.TechPackID IS NOT NULL)  
	AND (pTechPackTeam.TeamID = @TradePartnerId) 
	AND (pTechPackTeam.TradePartner = 1) 
	AND (pTechPackTeam.TechPackDownload = 1) 
	AND pTechPackActivity.ActivityType = 'D'
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01939', GetDate())
GO

SET NOCOUNT Off
GO
