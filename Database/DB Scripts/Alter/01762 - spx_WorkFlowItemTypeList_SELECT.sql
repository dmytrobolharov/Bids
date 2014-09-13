
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_WorkFlowItemTypeList_SELECT') 
DROP PROCEDURE spx_WorkFlowItemTypeList_SELECT
GO
CREATE PROCEDURE [dbo].[spx_WorkFlowItemTypeList_SELECT] 
(  
	@StyleID uniqueidentifier
)
AS
BEGIN
	SELECT wfi.StyleID, wfi.WorkFlowItemID, wfi.StyleSet, wfit.MapId
	FROM pWorkFlowItem wfi WITH(NOLOCK) INNER JOIN
	pWorkFlowItemType wfit WITH(NOLOCK) ON wfit.WorkflowItemTypeId = wfi.WorkflowItemTypeId
	WHERE wfi.StyleID = @StyleID
	ORDER BY wfit.MapId, wfi.StyleSet

END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01762', GetDate())
GO
