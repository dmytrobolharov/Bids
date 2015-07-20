ALTER TABLE [pControlBOMConfig] ADD [DimensionOptions] BIT NOT NULL DEFAULT ((1))
GO

ALTER TABLE [pStyleBOMConfig] ADD [DimensionOptions] BIT NOT NULL DEFAULT ((1))
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06476', GetDate())
GO
