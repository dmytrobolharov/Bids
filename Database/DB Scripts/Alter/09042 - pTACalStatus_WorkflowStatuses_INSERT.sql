DELETE FROM pTACalStatus
GO

INSERT INTO pTACalStatus (StatusID, StatusName)
SELECT WorkflowStatusID, WorkflowStatus 
FROM pWorkflowStatus
WHERE Active = 1
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09042', GetDate())
GO
