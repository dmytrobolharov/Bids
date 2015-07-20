IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_FlashEdit_QuickFill_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_FlashEdit_QuickFill_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_Planning_FlashEdit_QuickFill_SELECT] (
	@TeamID UNIQUEIDENTIFIER,
	@PlanningID UNIQUEIDENTIFIER
	)
AS
BEGIN
	
	SELECT qf.* FROM pPlanningFlashEditQuickFill qf
	INNER JOIN pStyleCategory sc ON sc.StyleCategoryID = qf.StyleCategoryID
	INNER JOIN pStyleType st ON st.StyleTypeID = qf.StyleTypeID
	WHERE qf.TeamID = @TeamID
	UNION
	SELECT DISTINCT qf.* FROM pFlashEditQuickFill qf	
	INNER JOIN (
			SELECT vw.*, pd.PlanningID
			FROM vwx_Division_StyleType_StyleCategory_SELECT vw
			INNER JOIN pPlanningDivision pd ON vw.DivisionID = pd.DivisionID
			WHERE PlanningID = @PlanningID
			) 
	AS PlanningAttributes ON qf.StyleTypeID = PlanningAttributes.StyleTypeID
	AND qf.StyleCategoryID = PlanningAttributes.StyleCategoryID
	WHERE qf.TeamID = @TeamID
	
	ORDER BY qf.MDate DESC
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07095', GetDate())
GO
