IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleLinkedWorkflow_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleLinkedWorkflow_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleLinkedWorkflow_SELECT]
(
	@WorkflowID uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleSet int
)
AS
BEGIN
	SELECT b.Map, b.MapDetail, 
			dbo.fnx_GetMappingFullRelativePath(app.AppSettingValue, b.MapUrl, b.MapFolder) AS MapUrl, b.MapPageUrl,
			c.WorkflowStatus, c.WorkflowStatusImage,
			a.StyleWorkflowID, a.StyleID, a.StyleSet, a.WorkflowID,  a.WorkflowType,  a.WorkflowOrder,  a.WorkDate, a.WorkStart,
			a.WorkDue, a.WorkAssignedTo, a.WorkComplete, a.WorkStatus, a.WorkStatusDate, a.WorkStatusBy, a.WorkVersion, a.WorkComments,
			a.CUser, a.CDate, a.MUser, a.MDate, a.WorkDay,
			d.StyleNo, a.WorkflowAccessTypeID, d.DevelopmentID, d.StyleType,
			CAST(a.WorkSort as int) WorkSort, ISNULL(d.StyleNo,'') + ISNULL(' (' + d.Description + ')','') AS SourceStyle
		FROM
			pWorkFlowItemLinked wfil
			INNER JOIN dbo.pStyleWorkflow a ON wfil.WorkFlowItemID = a.StyleWorkflowID
			INNER JOIN dbo.Mapping b ON a.WorkflowID = b.Map 
			INNER JOIN dbo.pWorkflowStatus c ON a.WorkStatus = c.WorkflowStatusID 
			INNER JOIN dbo.pStyleHeader d ON a.StyleID = d.StyleID
			INNER JOIN dbo.sAppSetting app ON LOWER(app.ConfigFileName) = 'server.config' AND LOWER(app.AppSettingKey) = 'HttpServer'
		WHERE
			wfil.StyleID = @StyleID
			AND wfil.StyleSet = @StyleSet		
			AND a.WorkflowID = @WorkflowID
		ORDER BY WorkSort, a.WorkflowID
END
	


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05895', GetDate())
GO
