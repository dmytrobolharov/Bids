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


CREATE PROCEDURE [dbo].[spx_StyleWorkflowCalendarListTPBQ_INSERT]
(@CalendarId varchar(50),
@StartDate datetime,
@EndDate datetime,
@StyleType int)
AS INSERT INTO dbo.pStyleCalendarTemp
                      (CalendarId, PKeyId, CalendarLinkId, CalendarLinkSubId, CalendarDate, CalendarType, CalendarStatus, CalendarDescription)
SELECT     @CalendarId AS CalendarId, dbo.pStyleWorkflow.StyleID, dbo.pStyleWorkflow.WorkflowID, dbo.Mapping.MapDetail, dbo.pStyleWorkflow.WorkDue, 
                      'StyleTPBQ' AS CalendarType, dbo.pStyleWorkflow.WorkStatus, 
                      dbo.pStyleHeader.StyleNo + ' (' + dbo.pStyleHeader.SizeClass + ') ' + dbo.pStyleHeader.Description AS CalendarDescription
FROM         dbo.pStyleWorkflow WITH (NOLOCK) INNER JOIN
                      dbo.Mapping WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkflowID = dbo.Mapping.Map INNER JOIN
                      dbo.pWorkflowStatus WITH (NOLOCK) ON dbo.pStyleWorkflow.WorkStatus = dbo.pWorkflowStatus.WorkflowStatusID INNER JOIN
                      dbo.pStyleHeader WITH (NOLOCK) ON dbo.pStyleWorkflow.StyleID = dbo.pStyleHeader.StyleID
WHERE     (dbo.pStyleHeader.Active = 1) AND (dbo.pStyleWorkflow.WorkDue BETWEEN @StartDate AND @EndDate) AND 
                      (dbo.pStyleHeader.StyleType = @StyleType)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '164', GetDate())
GO
