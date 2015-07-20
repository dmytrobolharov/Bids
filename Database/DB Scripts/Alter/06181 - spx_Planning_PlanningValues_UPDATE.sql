IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_PlanningValues_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_PlanningValues_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_Planning_PlanningValues_UPDATE]
	@PlanningID UNIQUEIDENTIFIER,
	@PlanningDivisionID UNIQUEIDENTIFIER,
	@PlanningStyleTypeID INT,
	@PlanningStyleCategoryID UNIQUEIDENTIFIER,
	@PlanningFinancialID UNIQUEIDENTIFIER,
	@PlanningPlanningCh DECIMAL(18, 5)
AS
BEGIN

	-- carry over styles shouldn't be greater then No of Styles
	-- it's crucial for No Of Styles to be updated before carry over styles
	if @PlanningFinancialID = '10000000-0000-0000-0000-000000000001'
	begin
		declare @NoOfStyles DECIMAL(18, 5) = 
		   (SELECT PlanningPlanningCh FROM pPlanningBusiness 
			WHERE PlanningID = @PlanningID
				AND PlanningDivisionID = @PlanningDivisionID
				AND PlanningStyleTypeID = @PlanningStyleTypeID
				AND ISNULL(PlanningStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@PlanningStyleCategoryID, '00000000-0000-0000-0000-000000000000')
				AND PlanningFinancialID = '10000000-0000-0000-0000-000000000000')
				
		if @NoOfStyles < @PlanningPlanningCh
			set @PlanningPlanningCh = @NoOfStyles			
	end
	

	UPDATE pPlanningBusiness SET PlanningPlanningCh = @PlanningPlanningCh
	WHERE PlanningID = @PlanningID
		AND PlanningDivisionID = @PlanningDivisionID
		AND PlanningStyleTypeID = @PlanningStyleTypeID
		AND ISNULL(PlanningStyleCategoryID, '00000000-0000-0000-0000-000000000000') = ISNULL(@PlanningStyleCategoryID, '00000000-0000-0000-0000-000000000000')
		AND PlanningFinancialID = @PlanningFinancialID
	
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06181', GetDate())
GO
