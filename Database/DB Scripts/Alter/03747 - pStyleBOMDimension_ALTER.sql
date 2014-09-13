IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleBOMDimension' AND COLUMN_NAME = 'AverageCost')
BEGIN
	ALTER TABLE pStyleBOMDimension ADD AverageCost decimal(19,3) 
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03747', GetDate())
GO
