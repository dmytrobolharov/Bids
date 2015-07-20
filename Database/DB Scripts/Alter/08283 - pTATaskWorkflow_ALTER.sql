IF NOT EXISTS(SELECT * FROM sys.columns 
        WHERE [name] = N'WorkflowSchemaSearchGrid' AND [object_id] = OBJECT_ID(N'pTATaskWorkflow'))
BEGIN
    alter table pTATaskWorkflow
	add WorkflowSchemaSearchGrid NVARCHAR(200) null 
END
GO

UPDATE pTATaskWorkflow set WorkflowSchemaSearchGrid='TACalendarTemplateTask_Style_Reference_Search.xml' where UPPER(WorkflowFolder) = UPPER('STYLE') or UPPER(WorkflowFolder) = UPPER('STYLE TECHPACK')
UPDATE pTATaskWorkflow set WorkflowSchemaSearchGrid='TACalendarTemplateTask_SampleRequest_Reference_Search.xml' where UPPER(WorkflowFolder) = UPPER('SAMPLE REQUEST')
UPDATE pTATaskWorkflow set WorkflowSchemaSearchGrid='TACalendarTemplateTask_Material_Reference_Search.xml' where UPPER(WorkflowFolder) = UPPER('MATERIAL')
UPDATE pTATaskWorkflow set WorkflowSchemaSearchGrid='TACalendarTemplateTask_Image_Reference_Search.xml' where UPPER(WorkflowFolder) = UPPER('IMAGE')
UPDATE pTATaskWorkflow set WorkflowSchemaSearchGrid='TACalendarTemplateTask_Color_Reference_Search.xml' where UPPER(WorkflowFolder) = UPPER('COLOR')
UPDATE pTATaskWorkflow set WorkflowSchemaSearchGrid='TACalendarTemplateTask_MaterialRequest_Reference_Search.xml' where UPPER(WorkflowFolder) = UPPER('MATERIAL REQUEST')

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08283', GetDate())
GO
