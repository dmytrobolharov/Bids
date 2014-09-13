IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LineFolders_REMOVE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LineFolders_REMOVE]
GO

CREATE PROCEDURE [dbo].[spx_Planning_LineFolders_REMOVE]
	@PlanningID UNIQUEIDENTIFIER,
	@LineFolderIDs VARCHAR(MAX),
	@RemoveStyles INT,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN

	IF @RemoveStyles = 1
	BEGIN
		DECLARE @PlanningItems TABLE(
			ROWID INT IDENTITY(1, 1),
			PlanningItemID UNIQUEIDENTIFIER)
		
		-- get planning items that are allocated only to selected line lists
		INSERT INTO @PlanningItems(PlanningItemID)
		EXEC spx_PlanningItem_FromLineFolders_SELECT @PlanningID, @LineFolderIDs
		
		DELETE FROM pPlanningItem
		WHERE PlanningItemID IN (
			SELECT PlanningItemID FROM @PlanningItems)
	END
	
	-- remove association to planning
	UPDATE lf SET PlanningID = NULL
	FROM dbo.fnx_Split(@LineFolderIDs, ',') t
	INNER JOIN pLineFolder lf ON t.value = lf.LineFolderID
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07763', GetDate())
GO
