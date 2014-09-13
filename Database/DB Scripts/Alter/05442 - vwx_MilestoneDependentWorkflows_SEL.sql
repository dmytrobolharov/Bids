/****** Object:  View [dbo].[vwx_MilestoneDependentWorkflows_SEL]    Script Date: 03/29/2013 14:07:38 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MilestoneDependentWorkflows_SEL]'))
DROP VIEW [dbo].[vwx_MilestoneDependentWorkflows_SEL]
GO

CREATE VIEW [dbo].[vwx_MilestoneDependentWorkflows_SEL]
AS
SELECT '00000000-0000-0000-0000-000000000001' as WorkflowTypeID, WorkflowID, Workflow 
FROM pWorkflow WHERE Active = 1 AND Body = 0

UNION

SELECT '00000000-0000-0000-0000-000000000002' as WorkflowTypeID, MaterialTemplatePageID, MaterialTemplatePageName 
FROM pMaterialTemplatePage WHERE Active = 1

UNION

SELECT '00000000-0000-0000-0000-000000000003' as WorkflowTypeID, MaterialRequestWorkflowRepId, MaterialRequestWorkflow 
FROM pMaterialRequestWorkflow WHERE Active = 1

UNION

SELECT '00000000-0000-0000-0000-000000000004' as WorkflowTypeID, SampleWorkflowRepId, SampleWorkflow
FROM pSampleWorkflow WHERE Active = 'Yes'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05442', GetDate())
GO
