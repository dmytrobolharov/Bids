IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pConPageDetail' and COLUMN_NAME = N'WorkFlowItemId')
       BEGIN 
            ALTER TABLE pConPageDetail ADD WorkFlowItemId uniqueidentifier NULL
       END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '662', GetDate())

GO