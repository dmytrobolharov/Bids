IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningItem_Drop]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningItem_Drop]
GO

CREATE PROCEDURE [dbo].[spx_PlanningItem_Drop] 
	@PlanningItemID UNIQUEIDENTIFIER,
	@PlanningItemDrop NVARCHAR(10),
	@PlanningItemDropUser NVARCHAR(200),
	@PlanningItemDropDate DATETIME,
	@SyncLineFolderItems INT = 1
AS
BEGIN

	UPDATE pPlanningItem SET
		PlanningItemDrop = @PlanningItemDrop,
		PlanningItemDropUser = @PlanningItemDropUser,
		PlanningItemDropDate = @PlanningItemDropDate
	WHERE PlanningItemID = @PlanningItemID
	
	
	/* WI#24021 */
	IF @SyncLineFolderItems = 1
	BEGIN
		DECLARE @StyleID UNIQUEIDENTIFIER
		DECLARE @PlanningID UNIQUEIDENTIFIER
		SELECT @StyleID = StyleID, @PlanningID = PlanningID FROM pPlanningItem WHERE PlanningItemID = @PlanningItemID

		UPDATE pLineFolderItem SET
			LineFolderItemDrop = @PlanningItemDrop, 
			LineFolderItemDropUser = @PlanningItemDropUser,
			LineFolderItemDropDate = @PlanningItemDropDate
		WHERE StyleID = @StyleID
			AND LineFolderID IN (SELECT LineFolderID FROM pLineFolder WHERE PlanningID = @PlanningID)
	END


END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07563', GetDate())
GO
