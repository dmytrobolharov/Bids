IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_BOMManager_Autogenerate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_BOMManager_Autogenerate]
GO

CREATE PROCEDURE [dbo].[spx_Planning_BOMManager_Autogenerate]
(
	@PlanningID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
	, @TeamID UNIQUEIDENTIFIER
)	
AS
BEGIN
	DECLARE @WorkflowID UNIQUEIDENTIFIER = '40000000-0000-0000-0000-000000000080'
	DECLARE @CreatedBy NVARCHAR(100) = (SELECT ISNULL(FirstName,'') + ' ' + ISNULL(LastName, '') FROM Users WHERE TeamID = @TeamID)
	DECLARE @CreatedDate DATETIME = GETDATE()
	DECLARE @WorkflowItemTypeID UNIQUEIDENTIFIER = (SELECT WorkflowItemTypeId FROM pWorkflowItemType WHERE MapId = @WorkflowID)
	
	DECLARE CUR CURSOR FOR
	SELECT DISTINCT
		pli.StyleID
		, sh.StyleSet
		, NEWID() AS WorkflowItemID
		, pli.PlanningItemID
	FROM vwx_PlanningItem_SELECT pli
	INNER JOIN pStyleHeader sh ON pli.StyleID = sh.StyleID
	INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN pStyleWorkflow sw ON pli.StyleSeasonYearID = sw.StyleSeasonYearID AND sw.WorkflowID = @WorkflowID
	WHERE
		pli.TeamId = @TeamID
		AND pli.PlanningID = @PlanningID
		AND ssy.SeasonYearID = @SeasonYearID
		AND pli.PlanningItemDrop = 'No'
		AND (pli.StyleBOMDimensionID IS NULL OR pli.StyleBOMDimensionID = '00000000-0000-0000-0000-000000000000')
	
	OPEN CUR
	DECLARE @StyleID UNIQUEIDENTIFIER, @StyleSet INT, @WorkflowItemID UNIQUEIDENTIFIER, @PlanningItemID UNIQUEIDENTIFIER
	FETCH NEXT FROM CUR INTO  @StyleID, @StyleSet, @WorkflowItemID, @PlanningItemID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC spx_WorkFlowItem_Seasonal_INSERT @WorkflowItemID, @WorkflowID, @WorkflowItemTypeID, @StyleID, @StyleSet, N'Created from Planning BOM Manager', @CreatedBy, @CreatedDate, @SeasonYearID
		EXEC spx_PlanningItem_BOM_LINK @PlanningItemID, @WorkflowItemID
		FETCH NEXT FROM CUR INTO  @StyleID, @StyleSet, @WorkflowItemID, @PlanningItemID
	END
	CLOSE CUR
	DEALLOCATE CUR

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08359', GetDate())
GO