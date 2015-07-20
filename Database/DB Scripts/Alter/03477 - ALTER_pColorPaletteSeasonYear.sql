--
-- Change pColorPaletteSeasonYear to NVARCHAR
--
GO
ALTER TABLE pColorPaletteSeasonYear ALTER COLUMN ColorYear nvarchar(100) NULL
GO
ALTER TABLE pColorPaletteSeasonYear ALTER COLUMN ColorSeason nvarchar(100) NULL

GO



	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03477', GetDate())
GO

