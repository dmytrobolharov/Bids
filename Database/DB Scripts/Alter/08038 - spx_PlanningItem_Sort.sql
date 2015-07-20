IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningItem_Sort]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningItem_Sort]
GO

CREATE PROCEDURE [dbo].[spx_PlanningItem_Sort]
	@PlanningID NVARCHAR(200),
	@SeasonYearID NVARCHAR(200),
	@TeamID NVARCHAR(200)
	
AS
BEGIN
	DECLARE @CountNew int 

	SELECT @CountNew = COUNT(*) FROM vwx_PlanningItem_SELECT
	WHERE PlanningID = @PlanningID
	and SeasonYearID = @SeasonYearID
	and TeamId = @TeamID
	and PlanningItemSort is null

	IF (@CountNew > 0)
	BEGIN 
		DECLARE @temp TABLE
		(
			SortOrder INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
			PlanningItemID uniqueidentifier
		)
		
		INSERT INTO @temp SELECT PlanningItemID FROM vwx_PlanningItem_SELECT
		WHERE PlanningID = @PlanningID
		AND SeasonYearID = @SeasonYearID
		AND TeamId = @TeamID
		ORDER BY PlanningItemSort, CDate desc, StyleNo
		
		UPDATE pPlanningItem SET pPlanningItem.PlanningItemSort = RIGHT ('0000' + LTRIM(STR(temp.SortOrder)),4) 
		FROM pPlanningItem INNER JOIN @temp temp ON pPlanningItem.PlanningItemID = temp.PlanningItemID
	END

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08038', GetDate())
GO