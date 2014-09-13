IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_Storyboards_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_Storyboards_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_Storyboards_SELECT]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@Active BIT = NULL
AS
BEGIN
	SELECT *
	FROM pImageCatalog ic
	WHERE (ic.Active = @Active OR @Active Is NULL) AND ic.PlanningID = @PlanningID AND ic.SeasonYearID = @SeasonYearID 
	ORDER BY ic.Sort
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08145', GetDate())
GO