IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowURL_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowURL_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleWorkflowURL_SELECT]
(
	@WorkflowID uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleSet int
)
AS
BEGIN
	SELECT
		dbo.fnx_GetMappingFullRelativePath(app.AppSettingValue, b.MapUrl, b.MapFolder) AS MapUrl
		, a.StyleWorkflowID
		, a.StyleID
		, d.DevelopmentID
		, d.StyleType
	FROM dbo.pStyleWorkflow a
		INNER JOIN dbo.Mapping b ON a.WorkflowID = b.Map 
		INNER JOIN dbo.pStyleHeader d ON a.StyleID = d.StyleID
		INNER JOIN dbo.sAppSetting app ON LOWER(app.ConfigFileName) = 'server.config' AND LOWER(app.AppSettingKey) = 'HttpServer'
	WHERE
		a.StyleID = @StyleID
		AND a.StyleSet = @StyleSet		
		AND a.WorkflowID = @WorkflowID
END
	


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05897', GetDate())
GO
