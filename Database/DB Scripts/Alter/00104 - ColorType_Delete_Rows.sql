DELETE FROM dbo.ColorType
WHERE ColorType like 'Pantone'
GO
DELETE FROM dbo.ColorType
WHERE ColorType like 'plmOn Default'
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '104', GetDate())
GO