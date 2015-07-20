IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_SKUHeader_Full_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_SKUHeader_Full_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LineFolder_SKUHeader_Full_SELECT]
	@LineFolderID UNIQUEIDENTIFIER
AS
BEGIN
	
	WITH PlanningSKUDims AS (
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
	, LineFolderSKUDims AS (
		SELECT lfsh.LineFolderSKUHeaderID, CAST(STUFF((
			SELECT ', ' + DimTypeDesc	
			FROM pLineFolderSKUHeaderDimType lfshdt	
			INNER JOIN pStyleBOMDimType sbdt ON lfshdt.DimTypeID = sbdt.DimTypeID
			WHERE lfsh.LineFolderSKUHeaderID = lfshdt.LineFolderSKUHeaderID
			ORDER BY lfshdt.Position
			FOR XML PATH('')
		), 1, 2, '') AS NVARCHAR(MAX)) AS Dimensions
		FROM pLineFolderSKUHeader lfsh
		GROUP BY lfsh.LineFolderSKUHeaderID)
	-- SKU plans created from line list	
	SELECT lfsh.LineFolderSKUHeaderID AS SKUHeaderID
		, lfsh.LineFolderSKUHeaderName AS SKUHeaderName
		, lfsh.WorkStatus
		, ws.WorkflowStatus
		, ws.WorkflowStatusImage AS SKUHeaderStatusIcon
		, sst.TemplateName
		, LineFolderSKUDims.Dimensions
		, lfsh.SortOrder
		, lfsh.CUser
		, lfsh.CDate
		, lfsh.MUser
		, lfsh.MDate
		, 0 AS FromPlanning
 	FROM pLineFolderSKUHeader lfsh
	LEFT JOIN pWorkflowStatus ws ON lfsh.WorkStatus = ws.WorkflowStatusID
	INNER JOIN pStyleSKUTemplate sst ON lfsh.StyleSKUTemplateID = sst.StyleSKUTemplateID
	INNER JOIN LineFolderSKUDims ON lfsh.LineFolderSKUHeaderID = LineFolderSKUDims.LineFolderSKUHeaderID
	WHERE LineFolderID = @LineFolderID
	
	UNION ALL
	-- SKU plans created from Planning	
	SELECT psh.PlanningSKUHeaderID AS SKUHeaderID
		, psh.PlanningSKUHeaderName AS SKUHeaderName
		, psh.WorkStatus
		, ws.WorkflowStatus
		, ws.WorkflowStatusImage AS SKUHeaderStatusIcon
		, sst.TemplateName
		, PlanningSKUDims.Dimensions
		, psh.Sort AS SortOrder
		, psh.CUser
		, psh.CDate
		, psh.MUser
		, psh.MDate
		, 1 AS FromPlanning
	FROM pLineFolder lf
	INNER JOIN pPlanning p ON lf.PlanningID = p.PlanningID
	INNER JOIN pPlanningSKUHeader psh ON p.PlanningID = psh.PlanningID AND lf.SeasonYearID = psh.SeasonYearID
	INNER JOIN pStyleSKUTemplate sst ON psh.StyleSKUTemplateID = sst.StyleSKUTemplateID
	LEFT JOIN pWorkflowStatus ws ON psh.WorkStatus = ws.WorkflowStatusID
	INNER JOIN PlanningSKUDims ON psh.PlanningSKUHeaderID = PlanningSKUDims.PlanningSKUHeaderID
	WHERE lf.LineFolderID = @LineFolderID
	ORDER BY FromPlanning, SortOrder
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07434', GetDate())
GO
