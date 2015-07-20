IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanWorkflow_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanWorkflow_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanWorkflow_SELECT]    Script Date: 09/23/2013 13:18:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[spx_LinePlanWorkflow_SELECT]
(
	@StyleID uniqueidentifier,
	@StyleSet int,
	@ConfigFile NVARCHAR(256) = 'server.config'
)
AS

	DECLARE @StyleWorkflowID as uniqueidentifier
	SELECT @StyleWorkflowID = StyleWorkflowId FROM pStyleHeader WITH (NOLOCK) WHERE StyleID = @StyleID

	IF @StyleWorkflowID IS NOT NULL
	BEGIN
		SELECT b.Map, b.MapDetail, 
			dbo.fnx_GetMappingFullRelativePath(app.AppSettingValue, b.MapConceptUrl, b.MapFolder) AS MapConceptUrl,
			c.WorkflowStatus, c.WorkflowStatusImage,
			a.StyleWorkflowID, a.StyleID, a.StyleSet, a.WorkflowID,  a.WorkflowType,  a.WorkflowOrder,  a.WorkDate, a.WorkStart,
			a.WorkDue, a.WorkAssignedTo, a.WorkComplete, a.WorkStatus, a.WorkStatusDate, a.WorkStatusBy, a.WorkVersion, a.WorkComments,
			a.CUser, a.CDate, a.MUser, a.MDate, a.WorkDay,
			d.StyleNo, a.WorkflowAccessTypeID, e.StartDate,
			CAST(e.WorkflowSort as int) WorkSort
		FROM dbo.pStyleWorkflow a WITH (NOLOCK) 
			INNER JOIN dbo.Mapping  b WITH (NOLOCK) ON a.WorkflowID = b.Map 
			INNER JOIN dbo.pWorkflowStatus  c WITH (NOLOCK) ON a.WorkStatus = c.WorkflowStatusID 
			INNER JOIN dbo.pStyleHeader d WITH (NOLOCK) ON a.StyleID = d.StyleID
			INNER JOIN dbo.pWorkflowTemplateItem e WITH (NOLOCK) ON  e.WorkflowID  = b.Map
			INNER JOIN dbo.sAppSetting app WITH (NOLOCK) ON LOWER(app.ConfigFileName) = @ConfigFile AND LOWER(app.AppSettingKey) = 'HttpServer'
		WHERE a.StyleID = @StyleID
			AND a.StyleSet = @StyleSet
			AND e.WorkflowTemplateID = @StyleWorkflowID
		ORDER BY WorkSort, e.WorkflowID
	END
	ELSE
	BEGIN
		SELECT b.Map, b.MapDetail, 
			dbo.fnx_GetMappingFullRelativePath(app.AppSettingValue, b.MapConceptUrl, b.MapFolder) AS MapConceptUrl,
			c.WorkflowStatus, c.WorkflowStatusImage,
			a.StyleWorkflowID, a.StyleID, a.StyleSet, a.WorkflowID, a.WorkflowType, a.WorkflowOrder, a.WorkDate, a.WorkStart,
			a.WorkDue, a.WorkAssignedTo, a.WorkComplete, a.WorkStatus, a.WorkStatusDate, a.WorkStatusBy, a.WorkVersion, a.WorkComments,
			a.CUser, a.CDate, a.MUser, a.MDate, a.WorkDay,
			d.StyleNo, a.WorkflowAccessTypeID, 
			CAST(a.WorkSort as int) WorkSort
		FROM dbo.pStyleWorkflow a WITH (NOLOCK) 
			INNER JOIN dbo.Mapping  b WITH (NOLOCK) ON a.WorkflowID = b.Map 
			INNER JOIN dbo.pWorkflowStatus  c WITH (NOLOCK) ON a.WorkStatus = c.WorkflowStatusID 
			INNER JOIN dbo.pStyleHeader d WITH (NOLOCK) ON a.StyleID = d.StyleID
			INNER JOIN dbo.sAppSetting app WITH (NOLOCK) ON LOWER(app.ConfigFileName) = @ConfigFile AND LOWER(app.AppSettingKey) = 'HttpServer'
		WHERE a.StyleID = @StyleID
			AND a.StyleSet = @StyleSet
		ORDER BY WorkSort, a.WorkflowID
	END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06340', GetDate())
GO