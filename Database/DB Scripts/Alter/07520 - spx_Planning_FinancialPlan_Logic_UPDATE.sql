IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_FinancialPlan_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_FinancialPlan_Logic_UPDATE]
GO

-- dummy procedure if there will be need to do calculations on Financial Plan page
CREATE PROCEDURE [dbo].[spx_Planning_FinancialPlan_Logic_UPDATE]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
AS
BEGIN
	
	-- Currently this procedures don't need to be called on Finanacial Plan page
	-- unless Brand/Division/StyleType/StyleCategory tree has been changed and there are some sofisticated aggregate recalculations
	-- EXEC spx_Planning_LinePlanningBusiness_PlanningLogic_UPDATE @PlanningID, @SeasonYearID
	
	-- EXEC spx_Planning_LinePlanningBusiness_DIPLogic_UPDATE @PlanningID, @SeasonYearID
	
	-- EXEC spx_Planning_LinePlanningBusiness_ActualLogic_UPDATE @PlanningID, @SeasonYearID
	
	-- EXEC spx_LineFolder_LinePlanningBusiness_LastYearLogic_UPDATE @LineFolderID
	
	RETURN
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07520', GetDate())
GO
