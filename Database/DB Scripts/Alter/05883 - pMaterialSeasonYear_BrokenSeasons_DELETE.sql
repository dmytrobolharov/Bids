DELETE FROM pMaterialSeasonYear WHERE SeasonYearID IS NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05883', GetDate())
GO
