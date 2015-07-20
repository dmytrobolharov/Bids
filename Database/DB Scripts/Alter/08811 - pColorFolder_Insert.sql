IF NOT EXISTS (SELECT * FROM pColorFolder WHERE ColorFolderID = '00000000-0000-0000-0000-000000000001')
BEGIN
	INSERT INTO pColorFolder (ColorFolderID, ColorFolderDescription) VALUES ('00000000-0000-0000-0000-000000000001', 'Company Library')
END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08811', GetDate())
GO