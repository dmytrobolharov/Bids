IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_SKUHeader_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_SKUHeader_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LineFolder_SKUHeader_SELECT]
	@LineFolderID UNIQUEIDENTIFIER
AS
BEGIN
	
	WITH LineFolderSKUDims AS (
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
	SELECT *		
 	FROM pLineFolderSKUHeader lfsh
	LEFT JOIN pWorkflowStatus ws ON lfsh.WorkStatus = ws.WorkflowStatusID
	INNER JOIN pStyleSKUTemplate sst ON lfsh.StyleSKUTemplateID = sst.StyleSKUTemplateID
	INNER JOIN LineFolderSKUDims ON lfsh.LineFolderSKUHeaderID = LineFolderSKUDims.LineFolderSKUHeaderID
	WHERE LineFolderID = @LineFolderID
	ORDER BY SortOrder
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07435', GetDate())
GO
