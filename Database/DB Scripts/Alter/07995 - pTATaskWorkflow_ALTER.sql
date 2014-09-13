IF NOT EXISTS(SELECT * FROM sys.columns 
        WHERE [name] = N'WorkflowSchemaGrid' AND [object_id] = OBJECT_ID(N'pTATaskWorkflow'))
BEGIN
    alter table pTATaskWorkflow
	add WorkflowSchemaGrid NVARCHAR(200) null 
END

GO
UPDATE pTATaskWorkflow set WorkflowSchemaGrid='TACalendarTemplateTask_Reference.xml'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07995', GetDate())
GO