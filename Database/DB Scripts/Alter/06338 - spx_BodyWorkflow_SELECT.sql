IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_BodyWorkflow_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_BodyWorkflow_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_BodyWorkflow_SELECT]    Script Date: 09/23/2013 13:14:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_BodyWorkflow_SELECT]
(
	@BodyID uniqueidentifier,
	@BodySet int,
	@ConfigFile VARCHAR (256) = 'server.config'
)
AS

	DECLARE @BodyWorkflowID as uniqueidentifier
	SELECT @BodyWorkflowID = BodyWorkflowID FROM pBody WITH (NOLOCK) WHERE BodyID = @BodyID

	IF @BodyWorkflowID IS NOT NULL
	BEGIN
		SELECT b.Map, b.MapDetail, 
			dbo.fnx_GetMappingFullRelativePath(app.AppSettingValue, b.MapUrl, b.MapFolder) AS MapUrl,
			c.WorkflowStatus, c.WorkflowStatusImage, 
			a.BodyWorkflowID, a.BodyID, a.BodySet, a.WorkflowID, a.WorkDate, a.WorkStart, 
			a.WorkDue, a.WorkAssignedTo, a.WorkStatus, a.CUser, a.CDate, a.MUser, a.MDate, a.WorkDay,
			d.BodyNo, CAST(e.WorkflowSort as int) WorkSort
		FROM dbo.pBodyWorkflow a 
			INNER JOIN dbo.Mapping  b ON a.WorkflowID = b.Map 
			INNER JOIN dbo.pWorkflowStatus  c ON a.WorkStatus = c.WorkflowStatusID 
			INNER JOIN dbo.pBody d ON a.BodyID = d.BodyID
			INNER JOIN dbo.pWorkflowTemplateItem e ON  e.WorkflowID  = b.Map 
			INNER JOIN dbo.sAppSetting app WITH (NOLOCK) ON LOWER(app.ConfigFileName) = @ConfigFile AND LOWER(app.AppSettingKey) = 'HttpServer'
		WHERE a.BodyID = @BodyID  
			AND a.BodySet = @BodySet 
			AND e.WorkflowTemplateID = @BodyWorkflowID
		ORDER BY e.WorkflowSort, e.WorkflowID
	END
	ELSE
	BEGIN
		SELECT b.Map, b.MapDetail, 
			dbo.fnx_GetMappingFullRelativePath(app.AppSettingValue, b.MapUrl, b.MapFolder) AS MapUrl,
			c.WorkflowStatus, c.WorkflowStatusImage, 
			a.BodyWorkflowID, a.BodyID, a.BodySet, a.WorkflowID, 
			a.WorkDate, a.WorkStart, 
			a.WorkDue, a.WorkAssignedTo,  
			a.WorkSort, a.CUser, a.CDate, a.MUser, a.MDate, 
			a.WorkDay, d.BodyNo, CAST(a.WorkSort as int) WorkSort
		FROM dbo.pBodyWorkflow a 
			INNER JOIN  dbo.Mapping b ON a.WorkflowID = b.Map 
			INNER JOIN dbo.pWorkflowStatus c ON a.WorkStatus = c.WorkflowStatusID 
			INNER JOIN dbo.pBody d ON a.BodyID = d.BodyID
			INNER JOIN dbo.sAppSetting app WITH (NOLOCK) ON LOWER(app.ConfigFileName) = @ConfigFile AND LOWER(app.AppSettingKey) = 'HttpServer'
		WHERE a.BodyID = @BodyID
			AND a.BodySet = @BodySet
		ORDER BY a.WorkSort, a.WorkflowID
	END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06338', GetDate())
GO