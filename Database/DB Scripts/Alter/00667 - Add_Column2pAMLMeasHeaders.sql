IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pAMLMeasHdr' and COLUMN_NAME = N'WorkFlowItemId')
       BEGIN 
            ALTER TABLE pAMLMeasHdr ADD WorkFlowItemId uniqueidentifier NULL
       END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '667', GetDate())

GO