UPDATE pStyleType SET StyleTypeTemplateID = (SELECT StyleTypeTemplateID FROM pStyleTypeTemplate WHERE StyleTypeTemplateName = 'Style')
WHERE StyleTypeTemplateID IS NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05832', GetDate())
GO
