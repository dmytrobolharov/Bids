IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowURL_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowURL_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowURL_SELECT]    Script Date: 09/23/2013 14:01:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spx_StyleWorkflowURL_SELECT]
(
	@WorkflowID uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleSet int,
	@ConfigFile NVARCHAR(256) = 'server.config'
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
		INNER JOIN dbo.sAppSetting app ON LOWER(app.ConfigFileName) = @ConfigFile AND LOWER(app.AppSettingKey) = 'HttpServer'
	WHERE
		a.StyleID = @StyleID
		AND a.StyleSet = @StyleSet		
		AND a.WorkflowID = @WorkflowID
END
	


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06356', GetDate())
GO