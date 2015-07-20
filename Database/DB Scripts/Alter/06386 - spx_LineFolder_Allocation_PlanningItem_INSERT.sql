IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_Allocation_PlanningItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_Allocation_PlanningItem_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_LineFolder_Allocation_PlanningItem_INSERT]
	@LineFolderID UNIQUEIDENTIFIER,
	@PlanningItemID	UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	
	DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER = (SELECT StyleSeasonYearID FROM pPlanningItem WHERE PlanningItemID = @PlanningItemID),
			@LineFolderItemID UNIQUEIDENTIFIER = NEWID()
			
	exec spx_LineFolderItem_INSERT @StyleSeasonYearID, @LineFolderItemID, @LineFolderID, @CDate, @CUser
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06386', GetDate())
GO
