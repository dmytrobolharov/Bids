IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_SubCategory_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_SubCategory_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_Planning_SubCategory_UPDATE]
(
	@PlanningID UNIQUEIDENTIFIER, 
	@SeasonYearID UNIQUEIDENTIFIER,
	@BrandID UNIQUEIDENTIFIER,
	@DivisionID UNIQUEIDENTIFIER,
	@StyleTypeID INT,
	@StyleCategoryID UNIQUEIDENTIFIER,
	@SubCategoryID UNIQUEIDENTIFIER,
	@IsSet INT
)
AS
BEGIN

	BEGIN TRANSACTION
	
	IF @IsSet = 0 -- remove data about this Sub category
	BEGIN
	
		IF EXISTS (SELECT * FROM pPlanningStyleCategoryToSubCategory
			WHERE PlanningID = @PlanningID
			AND SeasonYearID = @SeasonYearID
			AND PlanningBrandID = @BrandID
			AND PlanningDivisionID = @DivisionID
			AND PlanningStyleTypeID = @StyleTypeID
			AND PlanningStyleCategoryID = @StyleCategoryID
			AND SubCategoryID = @SubCategoryID)
		BEGIN
		
			DELETE FROM pPlanningStyleCategoryToSubCategory
			WHERE PlanningID = @PlanningID
				AND SeasonYearID = @SeasonYearID
				AND PlanningBrandID = @BrandID
				AND PlanningDivisionID = @DivisionID
				AND PlanningStyleTypeID = @StyleTypeID
				AND PlanningStyleCategoryID = @StyleCategoryID
				AND SubCategoryID = @SubCategoryID
				
			DELETE FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID
				AND SeasonYearID = @SeasonYearID
				AND PlanningBrandID = @BrandID
				AND PlanningDivisionID = @DivisionID
				AND PlanningStyleTypeID = @StyleTypeID
				AND PlanningStyleCategoryID = @StyleCategoryID
				AND PlanningSubCategoryID = @SubCategoryID
		END
		
	END
	ELSE IF @IsSet = 1 -- add data for this Sub category
	BEGIN

		IF NOT EXISTS (SELECT * FROM pPlanningStyleCategoryToSubCategory
			WHERE PlanningID = @PlanningID
			AND SeasonYearID = @SeasonYearID
			AND PlanningBrandID = @BrandID
			AND PlanningDivisionID = @DivisionID
			AND PlanningStyleTypeID = @StyleTypeID
			AND PlanningStyleCategoryID = @StyleCategoryID
			AND SubCategoryID = @SubCategoryID)
		BEGIN
		
			DECLARE @SubCategoryName NVARCHAR(200)
			SELECT @SubCategoryName = Custom FROM pSubCategory WHERE CustomID = @SubCategoryID
		
			INSERT INTO pPlanningStyleCategoryToSubCategory (PlanningStyleCategoryToSubCategoryID, PlanningID, SeasonYearID, 
				PlanningBrandID, PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, SubCategoryID)
			SELECT NEWID(), @PlanningID, @SeasonYearID, @BrandID, @DivisionID, @StyleTypeID, @StyleCategoryID, @SubCategoryID
		
			INSERT INTO pPlanningBusiness (PlanningBusinessID, PlanningID, PlanningFinancialID, PlanningFinancialText, PlanningFinancialSort,
				PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, PlanningDivision, PlanningStyleTypeDescription, PlanningStyleCategory, 
				PlanningDivisionSort, PlanningStyleTypeSort, 
				CUser, CDate, MUser, MDate, PlanningBrandID, PlanningBrand, SeasonYearID, PlanningSubCategoryID, PlanningSubCategory)
			SELECT NEWID(), PlanningID, PlanningFinancialID, PlanningFinancialText, PlanningFinancialSort,
				PlanningDivisionID, PlanningStyleTypeID, PlanningStyleCategoryID, PlanningDivision, PlanningStyleTypeDescription, PlanningStyleCategory, 
				PlanningDivisionSort, PlanningStyleTypeSort, 
				CUser, CDate, MUser, MDate, PlanningBrandID, PlanningBrand, SeasonYearID, @SubCategoryID, @SubCategoryName
			FROM pPlanningBusiness
			WHERE PlanningID = @PlanningID
				AND SeasonYearID = @SeasonYearID
				AND PlanningDivisionID = @DivisionID
				AND PlanningStyleTypeID = @StyleTypeID
				AND PlanningStyleCategoryID = @StyleCategoryID
				AND PlanningSubCategoryID IS NULL
	
		END	
	
	END
	

	IF @@Error <> 0 GOTO Error
	COMMIT TRANSACTION
	RETURN
Error:
	ROLLBACK TRANSACTION
	

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06850', GetDate())
GO
