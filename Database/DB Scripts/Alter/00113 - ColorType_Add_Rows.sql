
IF  NOT EXISTS (SELECT * FROM dbo.ColorType WHERE ColorType = 'Pantone' OR ColorType = 'plmOn Default' )

BEGIN	
INSERT INTO dbo.ColorType
VALUES('404966b9-ba43-de11-af59-028037ec0200','Pantone',0,'Color_Library_Default.xml','Color_Library_Search.xml','Color_LibraryItem_Default.xml',0,'Pantone',0)

INSERT INTO dbo.ColorType
VALUES('434966b9-ba43-de11-af59-028037ec0200','plmOn Default',0,'Color_Library_Default.xml','Color_Library_Search.xml','Color_LibraryItem_Default.xml',0,'plmOn Default',0)
END

ELSE

BEGIN	
Update dbo.ColorType
SET Active = 0
WHERE ColorType = 'Pantone' OR ColorType = 'plmOn Default'
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '113', GetDate())
GO