if NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleType' AND COLUMN_NAME = 'StyleTypeTemplateID')
begin
	ALTER TABLE pStyleType ADD StyleTypeTemplateID UNIQUEIDENTIFIER NULL
end
GO

UPDATE pStyleType SET StyleTypeTemplateID = (SELECT StyleTypeTemplateID FROM pStyleTypeTemplate WHERE StyleTypeTemplateName = 'Style')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05825', GetDate())
GO
