DELETE FROM pMaterialColorSeasonYear WHERE MaterialColorID NOT IN (SELECT MaterialColorID FROM pMaterialColor)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03871', GetDate())
GO
