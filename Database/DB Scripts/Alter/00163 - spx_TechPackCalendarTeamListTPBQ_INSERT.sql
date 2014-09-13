-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 15 June 2010                                                                               */
-- *                                                                                            */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
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


CREATE PROCEDURE [dbo].[spx_TechPackCalendarTeamListTPBQ_INSERT]
( 
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
		TechPackDate, 'TechPackTPBQ' AS CalendarType, '1', StyleNo + ' (' + SizeClass + ') ' + Description AS CalendarDescription
	FROM  pStyleHeader WITH (NOLOCK) 
	WHERE (Active = 1) AND (TechPackDate BETWEEN @StartDate AND @EndDate) AND (TechPackID IS NOT NULL) 
	AND  ( pStyleHeader.StyleType  IN  (SELECT StyleTypeID FROM sAccessStyleFolder WITH (NOLOCK) WHERE ( AccessRoleId =3 OR AccessView = 1 )  AND TeamId =  @TeamID ) )

--	AND  	(StyleType = @StyleType)

END 

BEGIN
	INSERT INTO pStyleCalendarTemp
		(CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
	SELECT  @CalendarId AS CalendarId, StyleID, '{00000000-0000-0000-0000-000000000000}', DevelopmentID, 
		DueDate, 'TechPackTPBQ' AS CalendarType, '1', StyleNo + ' (' + SizeClass + ') ' + Description AS CalendarDescription
	FROM  pStyleHeader WITH (NOLOCK) 
	WHERE (Active = 1) AND (DueDate BETWEEN @StartDate AND @EndDate) AND (TechPackID IS NULL)    -- AND (StyleType = @StyleType)
	AND  ( pStyleHeader.StyleType  IN  (SELECT StyleTypeID FROM sAccessStyleFolder WITH (NOLOCK) WHERE ( AccessRoleId =3 OR AccessView = 1 )  AND TeamId =  @TeamID ) )
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '163', GetDate())
GO
