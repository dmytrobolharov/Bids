
/****** Object:  StoredProcedure [dbo].[spx_WorkFlowItemList_SELECT]    Script Date: 09/14/2012 12:16:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkFlowItemList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkFlowItemList_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_WorkFlowItemList_SELECT]    Script Date: 09/14/2012 12:16:48 ******/
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
IF @WorkflowId='40000000-0000-0000-0000-000000000050' or @WorkflowId='40000000-0000-0000-0000-000000000078' or @WorkflowId='40000000-0000-0000-0000-000000000018' 
or @WorkflowId='40000000-0000-0000-0000-000000000080' or @WorkflowId='40000000-0000-0000-0000-000000000777' or @WorkflowId='40000000-0000-0000-0000-000000000999' or @WorkflowId='80000000-0000-0000-0000-000000000008'
Begin
	SELECT     wfi.WorkFlowItemID, wfi.WorkflowID, wfit.MapId, wfi.WorkflowItemTypeId, wfs.WorkflowStatus as Custom, wfit.ItemTypeLabel, wfi.StyleID, wfi.WorkFlowItemName, wfi.Sort, 
						  wfi.CUser, wfi.CDate, wfi.MUser, wfi.MDate,wfi.WorkStatus
	FROM         dbo.pWorkFlowItem AS wfi INNER JOIN
						  pWorkflowItemType AS wfit ON wfit.WorkflowItemTypeId = wfi.WorkflowItemTypeId left outer JOIN
						  pWorkflowStatus AS wfs ON wfi.WorkStatus = wfs.WorkflowStatusID
	WHERE     (wfi.StyleID = @StyleID) AND (wfi.StyleSet = @StyleSet) AND (wfi.WorkflowID = @WorkflowId)
	ORDER BY wfi.Sort
	end 
	Else Begin
	
	SELECT     wfi.WorkFlowItemID, wfi.WorkflowID, wfit.MapId, wfi.WorkflowItemTypeId, wfi.StatusID, wfit.ItemTypeLabel, wfi.StyleID, wfi.WorkFlowItemName, wfi.Sort, 
						  wfi.CUser, wfi.CDate, wfi.MUser, wfi.MDate, wfisl.Custom
	FROM         dbo.pWorkFlowItem AS wfi INNER JOIN
						  pWorkflowItemType AS wfit ON wfit.WorkflowItemTypeId = wfi.WorkflowItemTypeId left outer JOIN
						  xCustom8 AS wfisl ON wfi.StatusID = wfisl.CustomID
	WHERE     (wfi.StyleID = @StyleID) AND (wfi.StyleSet = @StyleSet) AND (wfi.WorkflowID = @WorkflowId)
	ORDER BY wfi.Sort
	End
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04265', GetDate())
GO

