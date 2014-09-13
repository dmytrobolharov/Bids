/****** Object:  StoredProcedure [dbo].[spx_MaterialSeasonYearTemp_INSERT]    Script Date: 05/21/2013 12:04:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialSeasonYearTemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialSeasonYearTemp_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialSeasonYearTemp_INSERT]	
	@MaterialID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
AS
BEGIN
	if NOT EXISTS(SELECT * FROM tmpMaterialSeasonYear WHERE MaterialID = @MaterialID AND SeasonYearID = @SeasonYearID)
	begin
		INSERT INTO tmpMaterialSeasonYear(MaterialID, SeasonYearID)
		VALUES(@MaterialID, @SeasonYearID)
	end
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05710', GetDate())
GO
