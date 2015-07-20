IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_MeasPage_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_MeasPage_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequest_MeasPage_SELECT]
(
	@SampleRequestWorkflowID nvarchar(50)
	, @SampleRequestTradeID nvarchar(50)
	, @StyleID nvarchar(50)
	, @StyleSet nvarchar(5)
	, @StyleColorID nvarchar(50)
	, @WorkflowId nvarchar(50)
)
AS 
BEGIN
	SELECT
		ah.AMLMeasHdrId
		, wfi.WorkFlowItemID
		, wfi.WorkflowID
		, wfi.StyleID
		, wfi.WorkFlowItemName
		, wfi.StyleSet
		, wfi.Sort
		, 0 AS IsLinked
	FROM
		pAMLMeasHdr ah
		INNER JOIN pWorkFlowItem wfi ON ah.WorkFlowItemId = wfi.WorkFlowItemID
	WHERE
		wfi.StyleID=@StyleID
		AND wfi.StyleSet=@StyleSet
		AND wfi.WorkflowID=@WorkflowId
	UNION
	SELECT
		ah.AMLMeasHdrId
		, wfi.WorkFlowItemID
		, wfi.WorkflowID
		, wfi.StyleID
		, wfi.WorkFlowItemName
		, wfi.StyleSet
		, wfi.Sort
		, 1 AS IsLinked
	FROM 
		pAMLMeasHdr ah
		INNER JOIN pWorkFlowItem wfi ON ah.WorkFlowItemId = wfi.WorkFlowItemID
		INNER JOIN pWorkFlowItemLinked wfil ON wfi.WorkFlowItemID = wfil.WorkFlowItemID
	WHERE
		wfil.StyleID = @StyleID 
		AND wfil.StyleSet = @StyleSet 
		AND wfi.WorkflowID = @WorkflowID
	ORDER BY wfi.Sort
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05938', GetDate())
GO
