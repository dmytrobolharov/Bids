IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Planning_BOMList_SEL]'))
DROP VIEW [dbo].[vwx_Planning_BOMList_SEL]
GO

CREATE VIEW [dbo].[vwx_Planning_BOMList_SEL]
AS

SELECT b.StyleBOMDimensionID AS StyleBOMDimensionID
	, w.WorkFlowItemName AS WorkFlowItemName
	, b.StyleID
	, pli.PlanningItemID
FROM pWorkFlowItem w
INNER JOIN pStyleBOMDimension b ON w.WorkFlowItemID = b.WorkFlowItemID
INNER JOIN pPlanningItem pli ON pli.StyleID = w.StyleID
	AND w.StyleSeasonYearID = pli.StyleSeasonYearID
	

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '08453', GetDate())
GO
