IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LinePlanningBusiness_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LinePlanningBusiness_Logic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_Planning_LinePlanningBusiness_Logic_UPDATE]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
AS
BEGIN
	
	-- optimization: this procedure doesn't need to be called on the page where main procedure is called
	-- doesn't seem to help much
	-- EXEC spx_Planning_LinePlanningBusiness_PlanningLogic_UPDATE @PlanningID, @SeasonYearID
	
	EXEC spx_Planning_LinePlanningBusiness_DIPLogic_UPDATE @PlanningID, @SeasonYearID
	
	EXEC spx_Planning_LinePlanningBusiness_ActualLogic_UPDATE @PlanningID, @SeasonYearID
	
	EXEC spx_Planning_LinePlanningBusiness_LastYearLogic_UPDATE @PlanningID, @SeasonYearID
	
END






GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08272', GetDate())
GO
