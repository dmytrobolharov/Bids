IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pAMLMeasHdr' and COLUMN_NAME = N'StyleSet')
       BEGIN 
            ALTER TABLE pAMLMeasHdr ADD StyleSet Int Null
       END
GO

update pamlmeashdr set styleSet=1 where styleset is null

go

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '779', GetDate())

GO