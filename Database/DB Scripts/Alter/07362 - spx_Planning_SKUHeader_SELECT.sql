IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_SKUHeader_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_SKUHeader_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_SKUHeader_SELECT]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
AS
BEGIN
	WITH SKUDims AS (
		SELECT psh.PlanningSKUHeaderID, CAST(STUFF((
			SELECT ', ' + DimTypeDesc	
			FROM pPlanningSKUHeaderDimType pshdt	
			INNER JOIN pStyleBOMDimType sbdt ON pshdt.DimTypeID = sbdt.DimTypeID
			WHERE psh.PlanningSKUHeaderID = pshdt.PlanningSKUHeaderID
			ORDER BY pshdt.Position
			FOR XML PATH('')
		), 1, 2, '') AS NVARCHAR(MAX)) AS Dimensions
		FROM pPlanningSKUHeader psh
		GROUP BY psh.PlanningSKUHeaderID)
	SELECT *, ws.WorkflowStatusImage AS PlanningSKUHeaderStatusIcon
	FROM pPlanningSKUHeader psh
	LEFT JOIN pWorkflowStatus ws ON psh.WorkStatus = ws.WorkflowStatusID
	INNER JOIN pStyleSKUTemplate skt ON psh.StyleSKUTemplateID = skt.StyleSKUTemplateID	
	INNER JOIN SKUDims ON psh.PlanningSKUHeaderID = SKUDims.PlanningSKUHeaderID
	WHERE PlanningID = @PlanningID AND SeasonYearID = @SeasonYearID
	ORDER BY Sort
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07362', GetDate())
GO
