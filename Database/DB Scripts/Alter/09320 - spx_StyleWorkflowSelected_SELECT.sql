/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowSelected_SELECT]    Script Date: 02/04/2015 16:07:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowSelected_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowSelected_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowSelected_SELECT]    Script Date: 02/04/2015 16:07:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_StyleWorkflowSelected_SELECT]
(
	@StyleID uniqueidentifier,
	@StyleSet int,
	@SeasonYearID uniqueidentifier = NULL,
	@ConfigFile NVARCHAR(256) = 'server.config',
	@workflowID uniqueidentifier
)
AS

	DECLARE @StyleWorkflowID uniqueidentifier,
			@StyleSeasonYearID uniqueidentifier;
	SELECT @StyleWorkflowID = StyleWorkflowId FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID
	SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID

	IF @StyleWorkflowID IS NOT NULL
	BEGIN
		SELECT b.Map, b.MapDetail, 
			dbo.fnx_GetMappingFullRelativePath(app.AppSettingValue, b.MapUrl, b.MapFolder) AS MapUrl, b.MapPageUrl,
			c.WorkflowStatus, c.WorkflowStatusImage,
			a.StyleWorkflowID, a.StyleID, a.StyleSet, a.WorkflowID,  a.WorkflowType,  a.WorkflowOrder,  a.WorkDate, a.WorkStart,
			a.WorkDue, a.WorkAssignedTo, a.WorkComplete, a.WorkStatus, a.WorkStatusDate, a.WorkStatusBy, a.WorkVersion, a.WorkComments,
			a.CUser, a.CDate, a.MUser, a.MDate, a.WorkDay,
			d.StyleNo, a.WorkflowAccessTypeID, e.StartDate,
			CAST(a.WorkSort as int) WorkSort, 
			(SELECT CASE WHEN COUNT(*)>0 THEN 1 ELSE 0 END FROM pWorkFlowItemLinked WHERE WorkFlowItemID = a.StyleWorkflowID) AS HasLinks
		FROM dbo.pStyleWorkflow a WITH (NOLOCK) 
			INNER JOIN dbo.Mapping  b WITH (NOLOCK) ON a.WorkflowID = b.Map 
			INNER JOIN dbo.pWorkflowStatus  c WITH (NOLOCK) ON a.WorkStatus = c.WorkflowStatusID 
			INNER JOIN dbo.pStyleHeader d WITH (NOLOCK) ON a.StyleID = d.StyleID
			INNER JOIN dbo.pWorkflowTemplateItem e WITH (NOLOCK) ON  e.WorkflowID  = b.Map
			INNER JOIN dbo.sAppSetting app WITH (NOLOCK) ON LOWER(app.ConfigFileName) = @ConfigFile AND LOWER(app.AppSettingKey) = 'HttpServer'
		WHERE a.StyleID = @StyleID
			AND a.StyleSet = @StyleSet
			AND e.WorkflowTemplateID = @StyleWorkflowID
			AND (a.StyleSeasonYearID = @StyleSeasonYearID OR a.StyleSeasonYearID IS NULL)
			AND a.WorkflowID = @workflowID
		ORDER BY WorkflowSort, e.WorkflowID
	END
	ELSE
	BEGIN
		SELECT b.Map, b.MapDetail, 
			dbo.fnx_GetMappingFullRelativePath(app.AppSettingValue, b.MapUrl, b.MapFolder) AS MapUrl, b.MapPageUrl,
			c.WorkflowStatus, c.WorkflowStatusImage,
			a.StyleWorkflowID, a.StyleID, a.StyleSet, a.WorkflowID,  a.WorkflowType,  a.WorkflowOrder,  a.WorkDate, a.WorkStart,
			a.WorkDue, a.WorkAssignedTo, a.WorkComplete, a.WorkStatus, a.WorkStatusDate, a.WorkStatusBy, a.WorkVersion, a.WorkComments,
			a.CUser, a.CDate, a.MUser, a.MDate, a.WorkDay,
			d.StyleNo, a.WorkflowAccessTypeID, 
			CAST(a.WorkSort as int) WorkSort,
			(SELECT CASE WHEN COUNT(*)>0 THEN 1 ELSE 0 END FROM pWorkFlowItemLinked WHERE WorkFlowItemID = a.StyleWorkflowID) AS HasLinks
		FROM dbo.pStyleWorkflow a WITH (NOLOCK) 
			INNER JOIN dbo.Mapping  b WITH (NOLOCK) ON a.WorkflowID = b.Map 
			INNER JOIN dbo.pWorkflowStatus  c WITH (NOLOCK) ON a.WorkStatus = c.WorkflowStatusID 
			INNER JOIN dbo.pStyleHeader d WITH (NOLOCK) ON a.StyleID = d.StyleID
			INNER JOIN dbo.sAppSetting app WITH (NOLOCK) ON LOWER(app.ConfigFileName) = @ConfigFile AND LOWER(app.AppSettingKey) = 'HttpServer'
		WHERE a.StyleID = @StyleID
			AND a.StyleSet = @StyleSet
			AND (a.StyleSeasonYearID = @StyleSeasonYearID OR a.StyleSeasonYearID IS NULL)
			AND a.WorkflowID = @workflowID
		ORDER BY WorkSort, a.WorkflowID
	END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09320', GetDate())
GO
