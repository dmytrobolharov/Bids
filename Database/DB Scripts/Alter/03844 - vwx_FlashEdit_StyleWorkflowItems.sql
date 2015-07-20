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

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_FlashEdit_StyleWorkflowItems]'))
	DROP VIEW [dbo].[vwx_FlashEdit_StyleWorkflowItems]
GO

CREATE VIEW [dbo].[vwx_FlashEdit_StyleWorkflowItems]
AS

	SELECT b.Map, b.MapDetail, 
		dbo.fnx_GetMappingFullRelativePath(app.AppSettingValue, b.MapUrl, b.MapFolder) AS MapUrl,
		c.WorkflowStatus,c.WorkflowStatusImage, 
		a.StyleWorkflowID, a.StyleID, a.StyleSet, a.WorkflowID, a.WorkflowType, a.WorkflowOrder, 
		a.WorkDate, a.WorkStart, a.WorkDue, ISNULL(a.WorkAssignedTo, 0) AS WorkAssignedTo, a.WorkComplete, a.WorkStatus, a.WorkStatusDate, a.WorkStatusBy, 
		a.WorkVersion, a.WorkComments, a.WorkSort, 
		a.CUser, a.CDate, a.MUser, a.MDate, a.WorkDay, 
		d.StyleNo, d.StyleType, 
		e.StyleTypeDescription, 
		f.StyleSeason, f.StyleYear
	FROM dbo.pStyleWorkflow AS a WITH (NOLOCK) 
		INNER JOIN dbo.Mapping AS b WITH (NOLOCK) ON a.WorkflowID = b.Map 
		INNER JOIN dbo.pWorkflowStatus AS c WITH (NOLOCK) ON a.WorkStatus = c.WorkflowStatusID 
		INNER JOIN dbo.pStyleHeader AS d WITH (NOLOCK) ON a.StyleID = d.StyleID 
		INNER JOIN dbo.pStyleType AS e WITH (NOLOCK) ON d.StyleType = e.StyleTypeID 
		INNER JOIN dbo.pStyleSeasonYear AS f WITH (NOLOCK) ON d.StyleID = f.StyleID
		INNER JOIN dbo.sAppSetting app WITH (NOLOCK) ON LOWER(app.ConfigFileName) = 'server.config' AND LOWER(app.AppSettingKey) = 'HttpServer'
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03844', GetDate())
GO

SET NOCOUNT Off
GO
