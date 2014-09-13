IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
			WHERE TABLE_NAME = N'pRadGridFieldSort' AND COLUMN_NAME = N'ColumnGroupBySortOrder')
BEGIN
	ALTER TABLE pRadGridFieldSort ADD ColumnGroupBySortOrder VARCHAR(5) DEFAULT 'ASC'
END
GO

UPDATE pRadGridFieldSort SET ColumnGroupBySortOrder = 'ASC' WHERE ColumnGroupBySortOrder IS NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04507', GetDate())
GO
