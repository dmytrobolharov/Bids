IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_Storyboard_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_Storyboard_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_Storyboard_INSERT]
	@PlanningID UNIQUEIDENTIFIER
	, @ImageCatalogID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
	, @MUser NVARCHAR(200)
	, @MDate DATETIME
AS

BEGIN

	IF NOT EXISTS(SELECT * FROM pImageCatalog WHERE ImageCatalogID = @ImageCatalogID AND (PlanningID Is Not NULL OR SeasonYearID Is Not NULL))
	BEGIN
		UPDATE pImageCatalog SET PlanningID = @PlanningID, SeasonYearID = @SeasonYearID, MUser = @MUser, MDate=@MDate
		WHERE ImageCatalogID = @ImageCatalogID
	END
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08146', GetDate())
GO