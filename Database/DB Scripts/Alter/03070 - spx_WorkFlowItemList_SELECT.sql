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
	SELECT     wfi.WorkFlowItemID, wfi.WorkflowID, wfit.MapId, wfi.WorkflowItemTypeId, wfi.StatusID, wfit.ItemTypeLabel, wfi.StyleID, wfi.WorkFlowItemName, wfi.Sort, 
						  wfi.CUser, wfi.CDate, wfi.MUser, wfi.MDate, wfisl.Custom
	FROM         dbo.pWorkFlowItem AS wfi INNER JOIN
						  pWorkflowItemType AS wfit ON wfit.WorkflowItemTypeId = wfi.WorkflowItemTypeId left outer JOIN
						  xCustom8 AS wfisl ON wfi.StatusID = wfisl.CustomID
	WHERE     (wfi.StyleID = @StyleID) AND (wfi.StyleSet = @StyleSet) AND (wfi.WorkflowID = @WorkflowId)
	ORDER BY wfi.Sort
END


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03070'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03070', GetDate())

END

GO


