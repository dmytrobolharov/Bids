IF NOT EXISTS(SELECT * FROM sys.columns 
        WHERE [name] = N'New' AND [object_id] = OBJECT_ID(N'pTACalTemplateTask'))
BEGIN
    alter table pTACalTemplateTask 
	add New int not null default 1 
END

IF NOT EXISTS(SELECT * FROM sys.columns 
        WHERE [name] = N'CarryOver' AND [object_id] = OBJECT_ID(N'pTACalTemplateTask'))
BEGIN
    alter table pTACalTemplateTask 
	add CarryOver int default 0 
END

GO

update pTACalTemplateTask set New=0, CarryOver=0


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07778', GetDate())
GO