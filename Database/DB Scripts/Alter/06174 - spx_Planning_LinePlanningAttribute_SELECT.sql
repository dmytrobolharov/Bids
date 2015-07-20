IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LinePlanningAttribute_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LinePlanningAttribute_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_Planning_LinePlanningAttribute_SELECT]
	@PlanningID UNIQUEIDENTIFIER
AS
BEGIN
	SELECT vw.* FROM vwx_Division_StyleType_StyleCategory_SELECT vw
	INNER JOIN pPlanningDivision pd ON vw.DivisionID = pd.DivisionID AND pd.PlanningID = @PlanningID
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06174', GetDate())
GO
