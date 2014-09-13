IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_SKUHeader_DUPLICATE_CHECK]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_SKUHeader_DUPLICATE_CHECK]
GO

CREATE PROCEDURE [dbo].[spx_Planning_SKUHeader_DUPLICATE_CHECK]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@PlanningSKUHeaderID UNIQUEIDENTIFIER = NULL,
	@Name NVARCHAR(400) = '' 
AS
BEGIN
	
	IF @PlanningSKUHeaderID IS NULL -- for new item
		SELECT COUNT(*) FROM pPlanningSKUHeader
		WHERE PlanningID = @PlanningID AND SeasonYearID = @SeasonYearID AND PlanningSKUHeaderName = @Name
	ELSE
		SELECT COUNT(*) FROM pPlanningSKUHeader
		WHERE PlanningID = @PlanningID AND SeasonYearID = @SeasonYearID 
			AND PlanningSKUHeaderID <> @PlanningSKUHeaderID
			AND PlanningSKUHeaderName = @Name
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07374', GetDate())
GO
