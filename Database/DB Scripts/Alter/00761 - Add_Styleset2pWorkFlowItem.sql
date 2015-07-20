IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pWorkFlowItem' and COLUMN_NAME = N'StyleSet')
       BEGIN 
            ALTER TABLE pWorkFlowItem ADD StyleSet INT Null
       END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '761', GetDate())

GO