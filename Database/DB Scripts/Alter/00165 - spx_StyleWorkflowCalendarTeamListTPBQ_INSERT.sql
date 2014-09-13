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


CREATE   PROCEDURE [dbo].[spx_StyleWorkflowCalendarTeamListTPBQ_INSERT]
(
@CalendarId varchar(50),
@StartDate datetime,
@EndDate datetime,
@StyleType int ,
@TeamID uniqueidentifier 
)
AS

/*Holiday's INSERT SELECT Statement.*/
INSERT INTO pStyleCalendarTemp
		(CalendarID, PKeyID, CalendarLinkID, CalendarLinkSubID, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
SELECT	@CalendarID AS CalendarID, '00000000-0000-0000-0000-000000000000' AS PKeyID, '00000000-0000-0000-0000-000000000000' AS CalendarLinkID, 
	'00000000-0000-0000-0000-000000000000' AS CalendarLinkSubID, CalendarEventDate AS CalendarDate, 'HolidayTPBQ' AS CalendarType, 0 AS CalendarStatus,
	CalendarEventCountry +  ' - ' + CalendarEventName as CalendarDescription
FROM	cCalendarEvent WITH (NOLOCK)


INSERT INTO dbo.pStyleCalendarTemp
                      (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
SELECT     @CalendarId AS CalendarId, dbo.pStyleWorkflow.StyleID, dbo.pStyleWorkflow.WorkflowID, dbo.Mapping.MapDetail, dbo.pStyleWorkflow.WorkDue, 
                      'StyleTPBQ' AS CalendarType, dbo.pStyleWorkflow.WorkStatus, 
                      dbo.pStyleHeader.StyleNo + ' (' + dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription
FROM         dbo.pStyleWorkflow WITH (NOLOCK) INNER JOIN
                      dbo.Mapping WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkflowID = dbo.Mapping.Map INNER JOIN
                      dbo.pWorkflowStatus WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkStatus = dbo.pWorkflowStatus.WorkflowStatusID INNER JOIN
                      dbo.pStyleHeader WITH (NOLOCK) ON dbo.pStyleWorkflow.StyleID = dbo.pStyleHeader.StyleID
WHERE     (dbo.pStyleHeader.Active = 1) AND (dbo.pStyleWorkflow.WorkDue BETWEEN @StartDate AND @EndDate) 
		AND ( pStyleHeader.StyleType  IN  (SELECT StyleTypeID FROM sAccessStyleFolder WITH (NOLOCK) WHERE ( AccessRoleId =3 OR AccessView = 1 )  AND TeamId = @TeamID  )  )
/*
		AND (dbo.pStyleHeader.StyleType = @StyleType)
		AND ( pStyleHeader.StyleType  IN  (SELECT StyleTypeID FROM sAccessStyleFolder WITH (NOLOCK) WHERE ( AccessRoleId =3 OR AccessView = 1 )  AND TeamId = @TeamID  )  )
*/
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '165', GetDate())
GO
