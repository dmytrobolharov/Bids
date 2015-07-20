
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pControlPanel' and COLUMN_NAME = N'SPXLogicUpdate')
    BEGIN 
        ALTER TABLE pControlPanel ADD SPXLogicUpdate NVARCHAR(200) 
    END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01038', GetDate())
GO

