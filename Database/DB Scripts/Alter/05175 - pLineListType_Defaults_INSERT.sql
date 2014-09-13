IF NOT EXISTS(SELECT * FROM pLineListType)
BEGIN
	INSERT INTO pLineListType (LineListCode, LineListType, Active, Sort)
	VALUES('LIN0001', 'Unspecified Line', 1, 0)
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05175', GetDate())
GO
