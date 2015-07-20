IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pImage'AND COLUMN_NAME = N'ImageWorkflowTemplateID')
BEGIN
      ALTER TABLE pImage ADD ImageWorkflowTemplateID UNIQUEIDENTIFIER NULL
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03565', GetDate())
GO 