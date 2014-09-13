IF EXISTS(SELECT * FROM pColorFolder WHERE ColorFolderID = '00000000-0000-0000-0000-000000000001')
	UPDATE pColorFolder SET ColorFolderDescription = 'Company Library', MChange = 1, Active = 1, StyleColorway = 0, ColorTypeID = 0
	WHERE ColorFolderID = '00000000-0000-0000-0000-000000000001'
ELSE
	INSERT INTO pColorFolder (ColorFolderID, ColorFolderDescription, MChange, Active, StyleColorway, ColorTypeID) 
	VALUES ('00000000-0000-0000-0000-000000000001', 'Company Library', 1, 1, 0, 0)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08839', GetDate())
GO
