
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'sDeskTop' and COLUMN_NAME = N'MenuWidth')
       BEGIN 
			
            ALTER TABLE sDeskTop ADD MenuWidth int NULL
       END
GO

update sDeskTop set MenuWidth = 200
GO

update sDeskTop set MenuWidth = 280 where DeskLabel1 = 'Business'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04146', GetDate())
GO