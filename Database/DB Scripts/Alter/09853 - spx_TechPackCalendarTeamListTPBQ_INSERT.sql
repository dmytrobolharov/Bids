IF OBJECT_ID(N'[dbo].[spx_TechPackCalendarTeamListTPBQ_INSERT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_TechPackCalendarTeamListTPBQ_INSERT]
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
	SELECT @CalendarId AS CalendarId, sh.StyleID, sh.TechPackID, sh.DevelopmentID, sh.TechPackDate, 
	       'TechPackTPBQ' AS CalendarType, '1', sh.StyleNo + ' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + Description AS CalendarDescription
	FROM pStyleHeader sh WITH (NOLOCK) 
	INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 2) access ON access.ProductTypeId = sh.StyleType
	LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	WHERE (sh.Active = 1) AND (sh.TechPackDate BETWEEN @StartDate AND @EndDate) AND (sh.TechPackID IS NOT NULL) 
	AND  (access.PermissionRoleId =3 OR access.PermissionView = 1 )

--	AND  	(StyleType = @StyleType)

END 

BEGIN
	INSERT INTO pStyleCalendarTemp
		(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
	SELECT @CalendarId AS CalendarId, sh.StyleID, '{00000000-0000-0000-0000-000000000000}', sh.DevelopmentID, sh.DueDate, 
	       'TechPackTPBQ' AS CalendarType, '1', sh.StyleNo + ' (' + COALESCE(sc.Custom, sh.SizeClass) + ') ' + Description AS CalendarDescription
	FROM pStyleHeader sh WITH (NOLOCK) 
	INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 2) access ON access.ProductTypeId = sh.StyleType
	LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	WHERE (sh.Active = 1) AND (sh.DueDate BETWEEN @StartDate AND @EndDate) AND (sh.TechPackID IS NULL)    -- AND (StyleType = @StyleType)
	AND  (access.PermissionRoleId =3 OR access.PermissionView = 1 )
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09853', GetDate())
GO
