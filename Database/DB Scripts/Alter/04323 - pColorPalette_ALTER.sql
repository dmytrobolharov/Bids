IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pColorPalette_Active]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[pColorPalette] DROP CONSTRAINT [DF_pColorPalette_Active]
END
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pColorPalette' AND COLUMN_NAME = 'Active')
BEGIN
	ALTER TABLE pColorPalette ALTER COLUMN Active INT NOT NULL
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pColorPalette_Active]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[pColorPalette] ADD  CONSTRAINT [DF_pColorPalette_Active]  DEFAULT ((1)) FOR [Active]
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04323', GetDate())
GO
