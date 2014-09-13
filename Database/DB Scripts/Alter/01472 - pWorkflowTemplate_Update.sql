Update pWorkflowTemplate set Body = 1 Where TemplateName = 'Body'

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01472', GetDate())
GO

