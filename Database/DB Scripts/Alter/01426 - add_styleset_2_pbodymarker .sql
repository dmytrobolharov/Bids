
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pBodyMarker' and COLUMN_NAME = N'StyleSet')
       BEGIN 
             ALTER TABLE pBodyMarker ADD StyleSet int null
       END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01426', GETDATE())
GO


