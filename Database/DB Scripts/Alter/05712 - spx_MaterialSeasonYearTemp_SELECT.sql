/****** Object:  StoredProcedure [dbo].[spx_MaterialSeasonYearTemp_SELECT]    Script Date: 05/21/2013 12:05:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialSeasonYearTemp_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialSeasonYearTemp_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialSeasonYearTemp_SELECT]
	@MaterialID UNIQUEIDENTIFIER	
AS
BEGIN
	SELECT * FROM tmpMaterialSeasonYear tmsy
	INNER JOIN pSeasonYear sy ON tmsy.SeasonYearID = sy.SeasonYearID
	WHERE tmsy.MaterialID = @MaterialID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05712', GetDate())
GO
