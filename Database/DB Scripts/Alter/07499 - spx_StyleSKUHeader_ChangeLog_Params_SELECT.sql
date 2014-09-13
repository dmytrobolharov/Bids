IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSKUHeader_ChangeLog_Params_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSKUHeader_ChangeLog_Params_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleSKUHeader_ChangeLog_Params_SELECT]
	@StyleSKUHeaderID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT DISTINCT v.*
	FROM pStyleSKUItem ssi
	INNER JOIN pWorkFlowItem wfi ON ssi.WorkflowItemID = wfi.WorkFlowItemID
	INNER JOIN pStyleHeader sh ON wfi.StyleID = sh.StyleID
	LEFT JOIN pPlanningSKUHeader psh ON ssi.PlanningSKUHeaderID = psh.PlanningSKUHeaderID
	LEFT JOIN pPlanning p ON psh.PlanningID = p.PlanningID
	LEFT JOIN pLineFolder lf ON psh.PlanningID = lf.PlanningID
		AND psh.SeasonYearID = lf.SeasonYearID
	CROSS APPLY (VALUES (ssi.WorkflowItemID, 'D617FAAE-7ACD-DF11-AF06-005056C00010', '##ALIAS##'), 
						(ssi.PlanningSKUHeaderID, '7D33005D-6007-4381-A7F1-E0E1D10BF7A8', sh.StyleNo + ' (' + sh.Description + '): ##ALIAS##'), 
						(ssi.LineFolderSKUHeaderID, 'EEE3BEB9-026F-4260-9B0E-B25F3560D778', sh.StyleNo + ' (' + sh.Description + '): ##ALIAS##'), 
						(CASE WHEN lf.LineFolderID IS NOT NULL THEN ssi.PlanningSKUHeaderID ELSE NULL END, 
							'EEE3BEB9-026F-4260-9B0E-B25F3560D778', sh.StyleNo + ' (' + sh.Description + '): ##ALIAS##')) 
					   V(ChangeTablePKID, ChangeTableID, ChangeFieldAlias)
	WHERE V.ChangeTablePKID IS NOT NULL AND ssi.StyleSKUItemID = @StyleSKUHeaderID
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '07499', GetDate())
GO
