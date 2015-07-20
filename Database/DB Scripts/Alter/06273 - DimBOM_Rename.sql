UPDATE pWorkFlow
SET Workflow = 'Bill of Material'
WHERE WorkflowID = '40000000-0000-0000-0000-000000000080'
GO

UPDATE Mapping
SET MapDetail = 'Bill of Material'
WHERE Map = '40000000-0000-0000-0000-000000000080'
GO

UPDATE pWorkflowItemType
SET ItemTypeLabel = 'Bill of Material'
WHERE MapId = '40000000-0000-0000-0000-000000000080'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06273', GetDate())
GO
