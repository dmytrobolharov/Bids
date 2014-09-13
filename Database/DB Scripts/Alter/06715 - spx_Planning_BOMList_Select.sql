IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_BOMList_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_BOMList_Select]
GO

CREATE PROCEDURE [dbo].[spx_Planning_BOMList_Select]
(
@PlanningItemID UNIQUEIDENTIFIER
)
AS 

BEGIN
	 SELECT b.StyleBOMDimensionID as StyleBOMDimensionID, w.WorkFlowItemName as WorkFlowItemName , b.StyleID
	 FROM  pWorkFlowItem w 
		INNER JOIN pStyleBOMDimension b  ON w.WorkFlowItemID = b.WorkFlowItemID 
		INNER JOIN pPlanningItem pli ON pli.StyleID = w.StyleID AND w.StyleSeasonYearID = pli.StyleSeasonYearID
	 where pli.PlanningItemID = @PlanningItemID
	 ORDER BY WorkFlowItemName 
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06715', GetDate())
GO
