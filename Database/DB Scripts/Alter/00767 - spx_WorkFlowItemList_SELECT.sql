IF EXISTS (select * from sysobjects where id = object_id('spx_WorkFlowItemList_SELECT') and sysstat & 0xf = 4)
	drop procedure spx_WorkFlowItemList_SELECT
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
	Order By Sort
END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '767', GetDate())

GO