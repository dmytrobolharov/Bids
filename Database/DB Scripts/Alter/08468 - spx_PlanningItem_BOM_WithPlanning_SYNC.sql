IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningItem_BOM_WithPlanning_SYNC]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningItem_BOM_WithPlanning_SYNC]
GO

CREATE PROCEDURE [dbo].[spx_PlanningItem_BOM_WithPlanning_SYNC]
	@PlanningItemID UNIQUEIDENTIFIER
AS

UPDATE lfi SET lfi.StyleBOMDimensionID = pli.StyleBOMDimensionID
FROM pPlanningItem pli
INNER JOIN pLineFolderItem lfi
	INNER JOIN pLineFolder lf ON lfi.LineFolderID = lf.LineFolderID
	ON pli.StyleSeasonYearID = lfi.StyleSeasonYearID AND pli.PlanningID = lf.PlanningID
WHERE pli.PlanningItemID = @PlanningItemID 
	AND pli.StyleBOMDimensionID <> lfi.StyleBOMDimensionID
	

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08468', GetDate())
GO
