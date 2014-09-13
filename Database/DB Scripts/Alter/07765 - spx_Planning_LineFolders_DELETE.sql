IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LineFolders_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LineFolders_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_Planning_LineFolders_DELETE]
	@PlanningID UNIQUEIDENTIFIER,
	@LineFolderIDs nVARCHAR(MAX),
	@RemoveStyles INT,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	
	DECLARE @LineLists TABLE(LineFolderID UNIQUEIDENTIFIER)
	INSERT INTO @LineLists(LineFolderID)
	SELECT value FROM dbo.fnx_Split(@LineFolderIDs, N',')
	
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

	DELETE FROM pLineFolder WHERE LineFolderID IN (SELECT LineFolderID FROM @LineLists)
	DELETE FROM pLineFolderItem WHERE LineFolderID IN (SELECT LineFolderID FROM @LineLists)
	DELETE FROM pLineFolderItemColor WHERE LineFolderID IN (SELECT LineFolderID FROM @LineLists)
	DELETE FROM pLineFolderItemMessage WHERE LineFolderID IN (SELECT LineFolderID FROM @LineLists)
	DELETE FROM pLineFolderStyleCategory WHERE LineFolderID IN (SELECT LineFolderID FROM @LineLists)
	DELETE FROM pLineFolderStyleType WHERE LineFolderID IN (SELECT LineFolderID FROM @LineLists)
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07765', GetDate())
GO
