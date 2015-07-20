 
IF NOT EXISTS(SELECT * FROM sys.columns 
        WHERE [name] = N'TaskProgress' AND [object_id] = OBJECT_ID(N'pTACalTemplateTask'))
BEGIN
    alter table pTACalTemplateTask 
	add TaskProgress decimal(6,2) null 
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07637', GetDate())
GO
