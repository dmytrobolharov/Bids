update pMaterialRequestWorkflow set MaterialRequestWorkflowColor=1 
where MaterialRequestWorkflow='Quality'

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04044', GetDate())
GO
