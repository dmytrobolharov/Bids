IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LineFolderItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LineFolderItem_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_LineFolderItem_INSERT]
	@PlanningItemID uniqueidentifier,
	@PlanningID uniqueidentifier,
	@LineFolderItemID uniqueidentifier,
	@SeasonYearID uniqueidentifier,
	@Status INT, -- 1 - to add with current status, 0 - drop
	@CDate datetime,
	@CUser nvarchar(200)	
AS
BEGIN
	
	DECLARE @StyleID UNIQUEIDENTIFIER,
			@StyleBOMDimensionID UNIQUEIDENTIFIER,
			@LineFolderItemDrop NVARCHAR(5)
	SELECT @StyleID = StyleID
		 , @StyleBOMDimensionID = StyleBOMDimensionID 
		 , @LineFolderItemDrop = LineFolderItemDrop
	FROM pLineFolderItem WHERE LineFolderItemID = @LineFolderItemID
	
	EXEC spx_PlanningItem_INSERT
		@PlanningItemID = @PlanningItemID,
		@PlanningID = @PlanningID,
		@StyleID = @StyleID,
		@SeasonYearID = @SeasonYearID,
		@CreatedDate = @CDate,
		@CreatedBy = @CUser,
		@StyleBOMDimensionID = @StyleBOMDimensionID
	
	IF @Status = 1
	BEGIN
		UPDATE pPlanningItem SET PlanningItemDrop = @LineFolderItemDrop
			, PlanningItemDropUser = @CUser
			, PlanningItemDropDate = @CDate
		WHERE PlanningItemID = @PlanningItemID AND PlanningItemDrop <> @LineFolderItemDrop
	END
	ELSE
	BEGIN
		UPDATE pPlanningItem SET PlanningItemDrop = 'Yes'
			, PlanningItemDropUser = @CUser
			, PlanningItemDropDate = @CDate
		WHERE PlanningItemID = @PlanningItemID
		
		UPDATE pLineFolderItem SET LineFolderItemDrop = 'Yes'
			, LineFolderItemDropUser = @CUser
			, LineFolderItemDropDate = @CDate
		WHERE LineFolderItemID = @LineFolderItemID
	END
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07485', GetDate())
GO
