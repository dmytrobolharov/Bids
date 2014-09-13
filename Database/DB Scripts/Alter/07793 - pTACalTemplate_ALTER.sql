IF NOT EXISTS(SELECT * FROM sys.columns 
        WHERE [name] = N'TACalTemplateDuration' AND [object_id] = OBJECT_ID(N'pTACalTemplate'))
BEGIN
    alter table pTACalTemplate
	add TACalTemplateDuration NVARCHAR(2000) null 
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07793', GetDate())
GO