 
IF NOT EXISTS(SELECT * FROM sys.columns 
        WHERE [name] = N'startIsMilestone' AND [object_id] = OBJECT_ID(N'pTACalTemplateTask'))
BEGIN
    alter table pTACalTemplateTask 
	add startIsMilestone int null 
END

IF NOT EXISTS(SELECT * FROM sys.columns 
        WHERE [name] = N'endIsMilestone' AND [object_id] = OBJECT_ID(N'pTACalTemplateTask'))
BEGIN
    alter table pTACalTemplateTask 
	add endIsMilestone int null 
END

IF NOT EXISTS(SELECT * FROM sys.columns 
        WHERE [name] = N'level' AND [object_id] = OBJECT_ID(N'pTACalTemplateTask'))
BEGIN
    alter table pTACalTemplateTask 
	add level int null 
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07691', GetDate())
GO
