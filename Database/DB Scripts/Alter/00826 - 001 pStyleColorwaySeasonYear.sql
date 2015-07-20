IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleColorwaySeasonYear' and COLUMN_NAME = N'Locked')
       BEGIN 
            ALTER TABLE pStyleColorwaySeasonYear ADD Locked INT NULL
       END
GO
