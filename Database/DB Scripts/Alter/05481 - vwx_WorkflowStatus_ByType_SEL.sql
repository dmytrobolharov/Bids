/****** Object:  View [dbo].[vwx_WorkflowStatus_ByType_SEL]    Script Date: 04/03/2013 16:46:00 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_WorkflowStatus_ByType_SEL]'))
DROP VIEW [dbo].[vwx_WorkflowStatus_ByType_SEL]
GO

CREATE VIEW [dbo].[vwx_WorkflowStatus_ByType_SEL]
AS
SELECT '00000000-0000-0000-0000-000000000001' as WorkflowTypeID, WorkflowStatusID as StatusID, WorkflowStatus as Status 
FROM pWorkflowStatus WHERE Active = 1
UNION
SELECT '00000000-0000-0000-0000-000000000002' as WorkflowTypeID, CustomKey as StatusID, Custom as Status 
FROM xCustom8 WHERE Active = 1
UNION
SELECT '00000000-0000-0000-0000-000000000003' as WorkflowTypeID, StatusID, Status 
FROM pMaterialRequestSubmitStatus WHERE Active = 1
UNION
SELECT '00000000-0000-0000-0000-000000000004' as WorkflowTypeID, StatusID, Status 
FROM pSampleRequestSubmitStatus WHERE Active = 1     


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05481', GetDate())
GO
