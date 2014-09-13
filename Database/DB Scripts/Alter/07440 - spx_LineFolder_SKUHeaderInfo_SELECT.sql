IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_SKUHeaderInfo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_SKUHeaderInfo_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LineFolder_SKUHeaderInfo_SELECT]
	@SKUHeaderID UNIQUEIDENTIFIER -- SKUHeaderID could either be LineFolderSKUHeaderID or PlanningSKUHeaderID
AS
BEGIN

	SELECT * FROM (
        SELECT LineFolderSKUHeaderID AS SKUHeaderID, LineFolderSKUHeaderName AS SKUHeaderName, WorkStatus, StyleSKUTemplateID
        FROM pLineFolderSKUHeader 
        UNION 
        SELECT PlanningSKUHeaderID AS SKUHeaderID, PlanningSKUHeaderName AS SKUHeaderName, WorkStatus, StyleSKUTemplateID
        FROM pPlanningSKUHeader psh) sh
    LEFT JOIN pWorkflowStatus ws ON sh.WorkStatus = ws.WorkflowStatusID 
    INNER JOIN pStyleSKUTemplate sst ON sh.StyleSKUTemplateID = sst.StyleSKUTemplateID
    WHERE sh.SKUHeaderID = @SKUHeaderID
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07440', GetDate())
GO
