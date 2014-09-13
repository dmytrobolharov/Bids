IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LineFolder_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LineFolder_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_LineFolder_INSERT] (
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@LineFolderID UNIQUEIDENTIFIER, 
	@CreatedDate DATETIME, 
	@CreatedBy NVARCHAR(200)
)
AS

	exec spx_LineFolder_INSERT @LineFolderID, @CreatedDate, @CreatedBy
	
	UPDATE pLineFolder
	SET SeasonYearID = @SeasonYearID, PlanningID = @PlanningID, LineFolderTypeID = (SELECT LineFolderTypeID FROM pLineFolderType WHERE LineFolderTypeName = 'seasonal')
	WHERE LineFolderID = @LineFolderID	


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06384', GetDate())
GO
