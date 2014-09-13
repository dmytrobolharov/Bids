/****** Object:  StoredProcedure [dbo].[spx_TechPackCalendarTeamListTPBQ_INSERT]    Script Date: 06/03/2014 11:06:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackCalendarTeamListTPBQ_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackCalendarTeamListTPBQ_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TechPackCalendarTeamListTPBQ_INSERT]    Script Date: 06/03/2014 11:06:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_TechPackCalendarTeamListTPBQ_INSERT]
( 
@StyleType nvarchar(5),
@CalendarId nvarchar(50),
@StartDate datetime,
@EndDate datetime,
@TeamID uniqueidentifier 
)
AS 

BEGIN
	INSERT INTO pStyleCalendarTemp
		(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
	SELECT  @CalendarId AS CalendarId, StyleID, TechPackID, DevelopmentID, 
		TechPackDate, 'TechPackTPBQ' AS CalendarType, '1', StyleNo + ' (' + SizeClass + ') ' + Description AS CalendarDescription
	FROM  pStyleHeader WITH (NOLOCK) INNER JOIN
	fnx_Permissions_GetIntProductTypePermissions(@TeamID, 2) access ON access.ProductTypeId = pStyleHeader.StyleType
	WHERE (Active = 1) AND (TechPackDate BETWEEN @StartDate AND @EndDate) AND (TechPackID IS NOT NULL) 
	AND  (  PermissionRoleId =3 OR PermissionView = 1 )

--	AND  	(StyleType = @StyleType)

END 

BEGIN
	INSERT INTO pStyleCalendarTemp
		(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
	SELECT  @CalendarId AS CalendarId, StyleID, '{00000000-0000-0000-0000-000000000000}', DevelopmentID, 
		DueDate, 'TechPackTPBQ' AS CalendarType, '1', StyleNo + ' (' + SizeClass + ') ' + Description AS CalendarDescription
	FROM  pStyleHeader WITH (NOLOCK) INNER JOIN
	fnx_Permissions_GetIntProductTypePermissions(@TeamID, 2) access ON access.ProductTypeId = pStyleHeader.StyleType
	WHERE (Active = 1) AND (DueDate BETWEEN @StartDate AND @EndDate) AND (TechPackID IS NULL)    -- AND (StyleType = @StyleType)
	AND  (  PermissionRoleId =3 OR PermissionView = 1 )
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07846', GetDate())
GO