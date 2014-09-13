/****** Object:  StoredProcedure [dbo].[spx_TechPackCalendarTeamList_INSERT]    Script Date: 06/05/2014 14:25:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackCalendarTeamList_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackCalendarTeamList_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_TechPackCalendarTeamList_INSERT]    Script Date: 06/05/2014 14:25:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_TechPackCalendarTeamList_INSERT]( 
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
	SELECT  @CalendarId AS CalendarId, LOWER(StyleID), TechPackID, DevelopmentID, 
		TechPackDate, 'TechPack' AS CalendarType, '1', StyleNo + ' (' + SizeClass + ') ' + Description AS CalendarDescription
	FROM  pStyleHeader WITH (NOLOCK) INNER JOIN
	fnx_Permissions_GetIntProductTypePermissions(@TeamID, 2) access ON access.ProductTypeId = pStyleHeader.StyleType
	WHERE (Active = 1) AND (TechPackDate BETWEEN @StartDate AND @EndDate) AND (TechPackID IS NOT NULL) 
	AND  access.PermissionRoleId <> 0
END 

BEGIN
	INSERT INTO pStyleCalendarTemp
		(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
	SELECT  @CalendarId AS CalendarId, LOWER(StyleID), '{00000000-0000-0000-0000-000000000000}', DevelopmentID, 
		DueDate, 'TechPack' AS CalendarType, '1', StyleNo + ' (' + SizeClass + ') ' + Description AS CalendarDescription
	FROM  pStyleHeader WITH (NOLOCK) INNER JOIN
	fnx_Permissions_GetIntProductTypePermissions(@TeamID, 2) access ON access.ProductTypeId = pStyleHeader.StyleType
	WHERE (Active = 1) AND (DueDate BETWEEN @StartDate AND @EndDate) AND (TechPackID IS NULL)    -- AND (StyleType = @StyleType)
	AND  access.PermissionRoleId <> 0
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07932', GetDate())
GO