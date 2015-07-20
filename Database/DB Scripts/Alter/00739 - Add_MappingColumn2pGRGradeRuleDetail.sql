IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRGradeRuleDetail' and COLUMN_NAME = N'Mapsizerangeid')
       BEGIN 
            ALTER TABLE pGRGradeRuleDetail ADD Mapsizerangeid uniqueidentifier NULL
       END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '739', GetDate())

GO