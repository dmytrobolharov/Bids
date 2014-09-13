IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_Storyboard_REMOVE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_Storyboard_REMOVE]
GO

CREATE PROCEDURE [dbo].[spx_Planning_Storyboard_REMOVE]
	@ImageCatalogID UNIQUEIDENTIFIER
AS
BEGIN
	
	UPDATE pImageCatalog SET PlanningID = NULL, SeasonYearID = NULL, Sort = NULL
	WHERE ImageCatalogID = @ImageCatalogID
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08147', GetDate())
GO
