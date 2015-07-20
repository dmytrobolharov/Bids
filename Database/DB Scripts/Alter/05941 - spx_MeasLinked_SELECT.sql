IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MeasLinked_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MeasLinked_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MeasLinked_SELECT]
(
	@SourceStyleID UNIQUEIDENTIFIER
	, @StyleID UNIQUEIDENTIFIER
	, @SourceStyleSet INT
	, @StyleSet INT
)
AS
BEGIN
	SELECT wfi.WorkFlowItemID, wfi.WorkflowID, wfit.MapId, wfi.WorkflowItemTypeId, wfs.WorkflowStatus as Custom, wfit.ItemTypeLabel, wfi.StyleID, wfi.WorkFlowItemName, wfi.Sort, wfi.CUser, wfi.CDate, wfi.MUser, wfi.MDate,wfi.WorkStatus, CASE WHEN wfil.WorkFlowItemLinkedID IS NOT NULL THEN 0 ELSE 1 END AS LinkEnabled, ISNULL(sh.StyleNo, '') + ISNULL (' (' + sh.Description, ')') AS SourceStyle, 0 AS IsLinked
	FROM dbo.pWorkFlowItem AS wfi 
		LEFT OUTER JOIN pWorkFlowItemLinked wfil ON wfi.WorkFlowItemID = wfil.WorkFlowItemID
												AND wfil.StyleID = @StyleID
												AND wfil.StyleSet = @StyleSet
		INNER JOIN pWorkflowItemType AS wfit ON wfit.WorkflowItemTypeId = wfi.WorkflowItemTypeId 
		INNER JOIN pStyleHeader sh ON wfi.StyleID = sh.StyleID
		LEFT OUTER JOIN pWorkflowStatus AS wfs ON wfi.WorkStatus = wfs.WorkflowStatusID
	WHERE wfi.StyleID = @SourceStyleID
		AND wfi.StyleSet = @SourceStyleSet
		AND wfi.WorkflowID = '40000000-0000-0000-0000-000000000050'
	UNION
SELECT wfi.WorkFlowItemID, wfi.WorkflowID, wfit.MapId, wfi.WorkflowItemTypeId, wfs.WorkflowStatus as Custom, wfit.ItemTypeLabel, wfi.StyleID, wfi.WorkFlowItemName, wfi.Sort, wfi.CUser, wfi.CDate, wfi.MUser, wfi.MDate, wfi.WorkStatus, CASE WHEN wfill.WorkFlowItemLinkedID IS NOT NULL THEN 0 ELSE 1 END AS LinkEnabled, ISNULL(sh.StyleNo, '') + ISNULL (' (' + sh.Description, ')') AS SourceStyle, 1 AS IsLinked
FROM pWorkFlowItemLinked wfil
	INNER JOIN dbo.pWorkFlowItem AS wfi ON wfil.WorkFlowItemID = wfi.WorkFlowItemID
	INNER JOIN pWorkflowItemType AS wfit ON wfit.WorkflowItemTypeId = wfi.WorkflowItemTypeId 
	INNER JOIN pStyleHeader sh ON wfi.StyleID = sh.StyleID
	LEFT OUTER JOIN pWorkflowStatus AS wfs ON wfi.WorkStatus = wfs.WorkflowStatusID
	LEFT OUTER JOIN pWorkFlowItemLinked wfill ON wfi.WorkFlowItemID = wfill.WorkFlowItemID
											AND wfill.StyleID = @StyleID
											AND wfill.StyleSet = @StyleSet
WHERE
	wfi.WorkflowID = '40000000-0000-0000-0000-000000000050'
	AND wfil.StyleID = @SourceStyleID
	AND wfil.StyleSet = @SourceStyleSet
	ORDER BY wfi.Sort

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05941', GetDate())
GO
