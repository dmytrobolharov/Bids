UPDATE pStyleHeader SET SubCategoryId = NULL WHERE SubCategoryId = 'null'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10424', GetUTCDate())
GO
