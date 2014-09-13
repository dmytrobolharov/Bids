IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningMaterial_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningMaterial_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningMaterial_INSERT]
	@PlanningID UNIQUEIDENTIFIER
	, @MaterialID UNIQUEIDENTIFIER
	, @PlanningMaterialID UNIQUEIDENTIFIER = NULL
	, @SeasonYearID UNIQUEIDENTIFIER
	, @CUser NVARCHAR(200)
	, @CDate DATETIME
AS

BEGIN

	SET @PlanningMaterialID = ISNULL(@PlanningMaterialID, NEWID())
	
	-- Add new material to Planning
	INSERT INTO pPlanningMaterial (PlanningMaterialID, PlanningID, MaterialID, CUser, CDate, MUser, MDate, SeasonYearID)
	VALUES (@PlanningMaterialID, @PlanningID, @MaterialID, @CUser, @CDate, @CUser, @CDate, @SeasonYearID)
	
	---- Add Material to Material SeasonYear
	IF NOT EXISTS (SELECT * FROM pMaterialSeasonYear WHERE MaterialID = @MaterialID AND SeasonYearID = @SeasonYearID)
	BEGIN
		DECLARE @MaterialSeasonYearID UNIQUEIDENTIFIER = NEWID()
		EXEC spx_MaterialSeasonYear_INSERT
				@MaterialSeasonYearID = @MaterialSeasonYearID,
				@MaterialID = @MaterialID,
				@SeasonYearID = @SeasonYearID,
				@CUser = @CUser,
				@CDate = @CDate
				
		EXEC spx_MaterialSeasonYear_Logic_INSERT
				@MaterialSeasonYearID = @MaterialSeasonYearID,
				@CUser = @CUser,
				@CDate = @CDate
	END			

END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06729', GetDate())
GO
