IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleColorwaySeasonYear_Sort]') AND type = 'D')
BEGIN
ALTER TABLE pStyleColorwaySeasonYear ADD Sort int
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04115', GetDate())
GO
