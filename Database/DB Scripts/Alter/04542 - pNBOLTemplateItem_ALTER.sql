if EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pNBOLTemplateItem' and COLUMN_NAME = N'OperationTypeID')
	begin
		ALTER TABLE pNBOLTemplateItem ALTER COLUMN OperationTypeID UNIQUEIDENTIFIER NULL
	end
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04542', GetDate())
GO