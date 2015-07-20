IF NOT EXISTS(SELECT * FROM sys.columns 
        WHERE [name] = N'TaskNote' AND [object_id] = OBJECT_ID(N'pTACalTemplateTask'))
BEGIN
    alter table pTACalTemplateTask 
	add TaskNote NVARCHAR(2000) null 
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07783', GetDate())
GO
