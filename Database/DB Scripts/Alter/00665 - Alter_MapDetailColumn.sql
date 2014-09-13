IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'Mapping' and COLUMN_NAME = N'MapDetail'
               AND CHARACTER_MAXIMUM_LENGTH < 200)
       BEGIN
            ALTER Table Mapping ALTER COLUMN MapDetail NVARCHAR(200)
       END


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '665', GetDate())

GO