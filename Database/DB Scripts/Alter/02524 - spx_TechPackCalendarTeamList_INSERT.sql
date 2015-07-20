
/****** Object:  StoredProcedure [dbo].[spx_TechPackCalendarTeamList_INSERT]    Script Date: 12/29/2011 19:26:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackCalendarTeamList_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackCalendarTeamList_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_TechPackCalendarTeamList_INSERT]( 
@StyleType varchar(5),
@CalendarId varchar(50),
@StartDate datetime,
@EndDate datetime,
@TeamID uniqueidentifier 
)
AS 

BEGIN
	INSERT INTO pStyleCalendarTemp
		(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
	SELECT  @CalendarId AS CalendarId, StyleID, TechPackID, DevelopmentID, 
		TechPackDate, 'TechPack' AS CalendarType, '1', StyleNo + ' (' + SizeClass + ') ' + Description AS CalendarDescription
	FROM  pStyleHeader WITH (NOLOCK) 
	WHERE (Active = 1) AND (TechPackDate BETWEEN @StartDate AND @EndDate) AND (TechPackID IS NOT NULL) 
	AND  ( pStyleHeader.StyleType  IN  (SELECT StyleTypeID FROM sAccessStyleFolder WITH (NOLOCK) WHERE ( AccessRoleId =3 OR AccessView = 1 )  AND TeamId =  @TeamID ) )

--	AND  	(StyleType = @StyleType)

END 

BEGIN
	INSERT INTO pStyleCalendarTemp
		(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
	SELECT  @CalendarId AS CalendarId, Lower(StyleID), '{00000000-0000-0000-0000-000000000000}', DevelopmentID, 
		DueDate, 'TechPack' AS CalendarType, '1', StyleNo + ' (' + SizeClass + ') ' + Description AS CalendarDescription
	FROM  pStyleHeader WITH (NOLOCK) 
	WHERE (Active = 1) AND (DueDate BETWEEN @StartDate AND @EndDate) AND (TechPackID IS NULL)    -- AND (StyleType = @StyleType)
	AND  ( pStyleHeader.StyleType  IN  (SELECT StyleTypeID FROM sAccessStyleFolder WITH (NOLOCK) WHERE ( AccessRoleId =3 OR AccessView = 1 )  AND TeamId =  @TeamID ) )
END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02524'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02524', GetDate())
END
GO