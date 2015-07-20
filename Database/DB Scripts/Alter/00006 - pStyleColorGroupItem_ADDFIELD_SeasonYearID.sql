
ALTER TABLE pStyleColorGroupItem ADD
	SeasonYearID uniqueidentifier NULL
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '006', GetDate())

GO
