update pMaterialRequestWorkflow set MaterialRequestWorkflowColor=1 where 
MaterialRequestWorkflowID='A90' and MaterialRequestWorkflow='Testing'


update pMaterialRequestWorkflow set MaterialRequestWorkflowColor=0 where 
MaterialRequestWorkflowID<>'A90' and MaterialRequestWorkflow<>'Testing'

update pMaterialRequestSubmitWorkflow set MaterialRequestSubmitAllColors=(select MaterialRequestWorkflowColor
from  pMaterialRequestWorkflow where 
pMaterialRequestWorkflow.MaterialRequestWorkflowID=pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID)


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04086', GetDate())
GO