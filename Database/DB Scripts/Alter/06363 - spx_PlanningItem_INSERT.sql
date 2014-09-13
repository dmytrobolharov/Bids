IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningItem_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningItem_INSERT](
	@PlanningItemID uniqueidentifier,
	@PlanningID uniqueidentifier,
	@StyleID uniqueidentifier,
	@SeasonYearID uniqueidentifier,
	@CreatedDate datetime,
	@CreatedBy nvarchar(200)
)

AS 

DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER
SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID


INSERT INTO pPlanningItem (PlanningItemID, PlanningID, StyleID, StyleSeasonYearID, CUser, CDate, MUser, MDate) 
VALUES (@PlanningItemID, @PlanningID, @StyleID, @StyleSeasonYearID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06363', GetDate())
GO
