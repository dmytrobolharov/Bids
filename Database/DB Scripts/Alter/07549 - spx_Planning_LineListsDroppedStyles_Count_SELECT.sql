IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LineListsDroppedStyles_Count_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LineListsDroppedStyles_Count_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_LineListsDroppedStyles_Count_SELECT]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT COUNT(*) FROM vwx_Planning_DroppedStyles_SEL 
	WHERE PlanningID = @PlanningID
		AND SeasonYearID = @SeasonYearID
		AND TeamId = @TeamID
	    AND LineFolderItemDrop = 'Yes'
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07549', GetDate())
GO