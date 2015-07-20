IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkFlowItemList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkFlowItemList_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_WorkFlowItemList_SELECT] 
(   @WorkflowId uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleSet int
)
AS
BEGIN
	SELECT wfi.WorkFlowItemID, wfi.WorkflowID, wfi.WorkflowItemTypeId, wfit.ItemTypeLabel, wfi.StyleID, wfi.WorkFlowItemName, wfi.Sort, wfi.CUser, wfi.CDate, wfi.MUser, wfi.MDate
	FROM pWorkFlowItem wfi INNER JOIN
	pWorkFlowItemType wfit ON wfit.WorkflowItemTypeId = wfi.WorkflowItemTypeId
	WHERE wfi.StyleID = @StyleID
	AND wfi.StyleSet = @StyleSet
	AND wfi.WorkflowId = @WorkflowId
	Order By wfi.Sort
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02188'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02188', GetDate())
END	
GO