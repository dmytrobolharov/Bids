IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkflowWhereUsed_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkflowWhereUsed_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_WorkflowWhereUsed_SELECT]    Script Date: 09/23/2013 14:02:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spx_WorkflowWhereUsed_SELECT]
(
	@StyleWorkflowID UNIQUEIDENTIFIER
	, @StyleID UNIQUEIDENTIFIER
	, @ShowParent INT
	, @ConfigFile NVARCHAR(256) = 'report.config'
)
AS
BEGIN
	DECLARE @ServerUrl NVARCHAR(100)
	SELECT @ServerUrl=AppSettingValue FROM sAppSetting WHERE ConfigFileName = @ConfigFile AND AppSettingKey = 'plmOnApplicationServerUrl'

	SELECT
		'<span style="font-weight:bold;">Source Style:</span><span style="padding-bottom:5px; display:block; border-bottom:1 dashed black;">' + ISNULL (sh.StyleNo, '') + ISNULL(' - ' + sh.Description, '') + '</span>' AS StyleInfo
		, @ServerUrl + '/Style/Style_Frame.aspx?SID=' + CAST(sh.StyleID AS NVARCHAR(50)) + '&P=' + CAST(sw.WorkflowID AS NVARCHAR(50)) AS StyleLink
		, '' AS Icon
	FROM pStyleWorkFlow sw
		INNER JOIN pStyleHeader sh ON sw.StyleID = sh.StyleID
	WHERE sw.StyleWorkflowID = @StyleWorkflowID AND @ShowParent = 1
	UNION
	SELECT
		ISNULL (sh.StyleNo, '') + ISNULL(' - ' + sh.Description, '') AS StyleInfo
		, @ServerUrl + '/Style/Style_Frame.aspx?SID=' + CAST(sh.StyleID AS NVARCHAR(50)) + '&P=' + CAST(sw.WorkflowID AS NVARCHAR(50))  AS StyleLink
		, 'icon_link.gif' AS Icon
	FROM pWorkFlowItemLinked wfil
		INNER JOIN pStyleWorkflow sw ON wfil.WorkFlowItemID = sw.StyleWorkflowID
		INNER JOIN pStyleHeader sh ON wfil.StyleID = sh.StyleID
	WHERE wfil.WorkFlowItemID = @StyleWorkflowID
		AND wfil.StyleID <> @StyleID

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06357', GetDate())
GO