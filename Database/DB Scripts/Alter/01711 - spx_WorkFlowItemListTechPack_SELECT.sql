SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_WorkFlowItemListTechPack_SELECT') 
DROP PROCEDURE spx_WorkFlowItemListTechPack_SELECT
GO

CREATE PROCEDURE [dbo].[spx_WorkFlowItemListTechPack_SELECT] 
(   @WorkflowId uniqueidentifier,
	@StyleID uniqueidentifier,
	@StyleSet int
)
AS
BEGIN
	SELECT wfi.WorkFlowItemID
	FROM pWorkFlowItem wfi WITH(NOLOCK) INNER JOIN
	pWorkFlowItemType wfit WITH(NOLOCK) ON wfit.WorkflowItemTypeId = wfi.WorkflowItemTypeId
	WHERE wfi.StyleID = @StyleID
	AND wfi.StyleSet = @StyleSet
	AND wfi.WorkflowId = @WorkflowId
	Order By wfit.ItemTypeLabel, wfi.Sort
END
GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01711'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '01711', GetDate())
	END
GO