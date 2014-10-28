IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StylePlanningLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StylePlanningLogic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StylePlanningLogic_UPDATE](
	@StyleID UNIQUEIDENTIFIER
)

AS

IF EXISTS (SELECT * FROM pPlanningItem WHERE StyleID = @StyleID)
BEGIN
	IF NOT EXISTS (SELECT * FROM pStyleHeader WHERE StyleID = @StyleID AND DivisionID IN (
	    SELECT DivisionID FROM pPlanningDivision WHERE PlanningID IN (SELECT PlanningID FROM pPlanningItem WHERE StyleID = @StyleID)))
	BEGIN
		DECLARE @CurPlanningItemID UNIQUEIDENTIFIER
		DECLARE @PlanningItemIndex INT = 1
		DECLARE @MaxCount INT = (SELECT COUNT(PlanningItemID) FROM pPlanningItem WHERE StyleID = @StyleID AND PlanningID IN (
			  SELECT PlanningID FROM pPlanningDivision WHERE DivisionID <> (SELECT DivisionID FROM pStyleHeader WHERE StyleID = @StyleID)))

		SELECT IDENTITY(INT, 1,1) AS PlanningItemIndex, PlanningItemID
		INTO #TempPlanningItemIds      
		FROM pPlanningItem WHERE StyleID = @StyleID AND PlanningID IN (
			  SELECT PlanningID FROM pPlanningDivision WHERE DivisionID <> (SELECT DivisionID FROM pStyleHeader WHERE StyleID = @StyleID))

		WHILE @PlanningItemIndex <= @MaxCount
		BEGIN
			SET @CurPlanningItemID = (SELECT PlanningItemID FROM #TempPlanningItemIds WHERE PlanningItemIndex = @PlanningItemIndex)

			EXEC spx_PlanningItem_DELETE @PlanningItemID = @CurPlanningItemID

			SET @PlanningItemIndex = @PlanningItemIndex + 1
		END

		DROP TABLE #TempPlanningItemIds
	END
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09131', GetDate())
GO
