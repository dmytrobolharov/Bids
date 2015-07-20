IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_SKUHeaderInfo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_SKUHeaderInfo_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_SKUHeaderInfo_SELECT]
	@PlanningSKUHeaderID UNIQUEIDENTIFIER
AS
BEGIN

	SELECT *
	FROM pPlanningSKUHeader psh
	LEFT JOIN pWorkflowStatus ws ON psh.WorkStatus = ws.WorkflowStatusID
	INNER JOIN pStyleSKUTemplate sst ON psh.StyleSKUTemplateID = sst.StyleSKUTemplateID
	WHERE PlanningSKUHeaderID = @PlanningSKUHeaderID

	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07447', GetDate())
GO
