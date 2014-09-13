select MaterialRequestWorkflowID from pMaterialRequestWorkflow 

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pMaterialRequestWorkflow' AND COLUMN_NAME = 'MaterialRequestWorkflowGUIDID')
BEGIN
	ALTER TABLE pMaterialRequestWorkflow ADD MaterialRequestWorkflowGUIDID UNIQUEIDENTIFIER
END
GO

UPDATE pMaterialRequestWorkflow SET MaterialRequestWorkflowGUIDID='A0000000-0000-0000-0000-000000000010' WHERE MaterialRequestWorkflowID = 'A10'
UPDATE pMaterialRequestWorkflow SET MaterialRequestWorkflowGUIDID='A0000000-0000-0000-0000-000000000015' WHERE MaterialRequestWorkflowID = 'A15'
UPDATE pMaterialRequestWorkflow SET MaterialRequestWorkflowGUIDID='A0000000-0000-0000-0000-000000000020' WHERE MaterialRequestWorkflowID = 'A20'
UPDATE pMaterialRequestWorkflow SET MaterialRequestWorkflowGUIDID='A0000000-0000-0000-0000-000000000030' WHERE MaterialRequestWorkflowID = 'A30'
UPDATE pMaterialRequestWorkflow SET MaterialRequestWorkflowGUIDID='A0000000-0000-0000-0000-000000000040' WHERE MaterialRequestWorkflowID = 'A40'
UPDATE pMaterialRequestWorkflow SET MaterialRequestWorkflowGUIDID='A0000000-0000-0000-0000-000000000080' WHERE MaterialRequestWorkflowID = 'A80'
UPDATE pMaterialRequestWorkflow SET MaterialRequestWorkflowGUIDID='A0000000-0000-0000-0000-000000000084' WHERE MaterialRequestWorkflowID = 'A84'
UPDATE pMaterialRequestWorkflow SET MaterialRequestWorkflowGUIDID='A0000000-0000-0000-0000-000000000088' WHERE MaterialRequestWorkflowID = 'A88'
UPDATE pMaterialRequestWorkflow SET MaterialRequestWorkflowGUIDID='A0000000-0000-0000-0000-000000000090' WHERE MaterialRequestWorkflowID = 'A90'
UPDATE pMaterialRequestWorkflow SET MaterialRequestWorkflowGUIDID='A0000000-0000-0000-0000-000000000094' WHERE MaterialRequestWorkflowID = 'A94'
UPDATE pMaterialRequestWorkflow SET MaterialRequestWorkflowGUIDID='A0000000-0000-0000-0000-000000000096' WHERE MaterialRequestWorkflowID = 'A96'
UPDATE pMaterialRequestWorkflow SET MaterialRequestWorkflowGUIDID='A0000000-0000-0000-0000-000000000098' WHERE MaterialRequestWorkflowID = 'A98'

UPDATE pMaterialRequestWorkflow SET MaterialRequestWorkflowGUIDID = NEWID() WHERE MaterialRequestWorkflowGUIDID IS NULL
GO

ALTER TABLE pMaterialRequestWorkflow ALTER COLUMN MaterialRequestWorkflowGUIDID UNIQUEIDENTIFIER NOT NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08063', GetDate())
GO