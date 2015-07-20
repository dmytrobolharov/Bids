IF NOT EXISTS(SELECT * FROM pColorClass)
BEGIN
	INSERT INTO pColorClass (ColorClassDisplayID, ColorClassName, ColorClassSort, ColorClassDefault, Active)
	VALUES('10', 'Solid', 0, 1, 1)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07624', GetDate())
GO