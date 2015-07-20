IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Planning_SKUHeader_SEL]'))
DROP VIEW [dbo].[vwx_Planning_SKUHeader_SEL]
GO

CREATE VIEW [dbo].[vwx_Planning_SKUHeader_SEL]
AS
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
SELECT psh.PlanningSKUHeaderID, psh.PlanningID, psh.SeasonYearID, psh.PlanningSKUHeaderName, psh.StyleSKUTemplateID, psh.WorkStatus, psh.Sort, psh.CUser, psh.CDate, psh.MUser, psh.MDate, ws.WorkflowStatusID, ws.WorkflowStatus, ws.WorkflowStatusImage, skt.TemplateName, SKUDims.Dimensions, ws.WorkflowStatusImage AS PlanningSKUHeaderStatusIcon
FROM pPlanningSKUHeader psh
LEFT JOIN pWorkflowStatus ws ON psh.WorkStatus = ws.WorkflowStatusID
INNER JOIN pStyleSKUTemplate skt ON psh.StyleSKUTemplateID = skt.StyleSKUTemplateID	
INNER JOIN SKUDims ON psh.PlanningSKUHeaderID = SKUDims.PlanningSKUHeaderID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07360', GetDate())
GO
