-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 29 August 2012                                                                             */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
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


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_Schedule_Calendar_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_Style_Schedule_Calendar_SELECT]
GO

CREATE  PROCEDURE [dbo].[spx_Style_Schedule_Calendar_SELECT]
(
	@StyleID uniqueidentifier
)
AS

	SELECT b.Map, b.MapDetail, 
		dbo.fnx_GetMappingFullRelativePath(app.AppSettingValue, b.MapUrl, b.MapFolder) AS MapUrl,
		c.WorkflowStatus, c.WorkflowStatusImage,
		a.StyleWorkflowID, a.StyleID, a.StyleSet, a.WorkflowID,  a.WorkflowType,  a.WorkflowOrder,  a.WorkDate, a.WorkStart,
		a.WorkDue, a.WorkAssignedTo, a.WorkComplete, a.WorkStatus, a.WorkStatusDate, a.WorkStatusBy, a.WorkVersion, a.WorkComments,
		a.CUser, a.CDate, a.MUser, a.MDate, a.WorkDay,
		d.StyleNo, a.WorkflowAccessTypeID, 
		CAST(a.WorkSort as int) WorkSort
	FROM dbo.pStyleWorkflow a WITH (NOLOCK) 
		INNER JOIN dbo.Mapping b WITH (NOLOCK) ON a.WorkflowID = b.Map 
		INNER JOIN dbo.pWorkflowStatus  c WITH (NOLOCK) ON a.WorkStatus = c.WorkflowStatusID 
		INNER JOIN dbo.pStyleHeader d WITH (NOLOCK) ON a.StyleID = d.StyleID
		INNER JOIN dbo.sAppSetting app WITH (NOLOCK) ON LOWER(app.ConfigFileName) = 'server.config' AND LOWER(app.AppSettingKey) = 'HttpServer'
	WHERE a.StyleID = @StyleID
	ORDER BY WorkSort
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03841', GetDate())
GO

SET NOCOUNT Off
GO
