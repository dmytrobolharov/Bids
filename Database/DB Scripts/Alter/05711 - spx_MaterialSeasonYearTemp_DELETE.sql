/****** Object:  StoredProcedure [dbo].[spx_MaterialSeasonYearTemp_DELETE]    Script Date: 05/21/2013 12:05:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialSeasonYearTemp_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialSeasonYearTemp_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_MaterialSeasonYearTemp_DELETE]
	@MaterialID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
AS
BEGIN
	DELETE FROM tmpMaterialSeasonYear WHERE MaterialID = @MaterialID AND SeasonYearID = @SeasonYearID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05711', GetDate())
GO
