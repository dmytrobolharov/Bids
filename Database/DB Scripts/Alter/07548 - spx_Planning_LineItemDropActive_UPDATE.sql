IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LineItemDropActive_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LineItemDropActive_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_Planning_LineItemDropActive_UPDATE]
	@PlanningID uniqueidentifier,
	@LineFolderItemID uniqueidentifier,
	@Status INT, -- 1 - set active, 0 - drop
	@Type INT, -- 1 - activate in Line List, 0 - activate in Line Plan
	@CDate datetime,
	@CUser nvarchar(200)
AS
BEGIN
	
	IF @Type = 1
	BEGIN
		IF @Status = 1
		BEGIN 
			UPDATE pLineFolderItem 
			SET LineFolderItemDrop = 'No',
				LineFolderItemDropUser = @CUser,
				LineFolderItemDropDate = @CDate
			WHERE LineFolderItemID = @LineFolderItemID
		END
		ELSE
		BEGIN
			UPDATE pPlanningItem 
			SET PlanningItemDrop = 'Yes',
				PlanningItemDropUser = @CUser,
				PlanningItemDropDate = @CDate
			WHERE PlanningID = @PlanningID 
			AND StyleID = (SELECT StyleID FROM pLineFolderItem WHERE LineFolderItemID = @LineFolderItemID)
		END
	END
	ELSE
	BEGIN
		IF @Status = 1
		BEGIN
			UPDATE pPlanningItem 
			SET PlanningItemDrop = 'No',
				PlanningItemDropUser = @CUser,
				PlanningItemDropDate = @CDate
			WHERE PlanningID = @PlanningID 
			AND StyleID = (SELECT StyleID FROM pLineFolderItem WHERE LineFolderItemID = @LineFolderItemID)
		END
		ELSE
		BEGIN
			UPDATE pLineFolderItem 
			SET LineFolderItemDrop = 'Yes',
				LineFolderItemDropUser = @CUser,
				LineFolderItemDropDate = @CDate
			WHERE LineFolderItemID = @LineFolderItemID
		END
	END
			
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07548', GetDate())
GO