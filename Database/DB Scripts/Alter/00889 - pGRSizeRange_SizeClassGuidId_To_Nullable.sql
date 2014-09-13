--
-- Can run repeatedly since this command will work all the time
--
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRClassRange' and COLUMN_NAME = N'SizeClassGuidId')
       BEGIN
            ALTER TABLE pGRClassRange ALTER COLUMN SizeClassGuidId uniqueidentifier NULL
       END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '889', GetDate())
GO
