IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestWorkflow_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestWorkflow_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialRequestWorkflow_INSERT] (
@MaterialRequestWorkflowID VARCHAR(5),
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
AS 

INSERT INTO pMaterialRequestWorkflow(MaterialRequestWorkflowID, 
MaterialRequestSubmitSchema, MaterialRequestWorkflowSchema, MaterialRequestWorkflowItemSchema, MaterialRequestWorkflowControlSchema,
CUser, CDate, MUser, MDate) 
VALUES (@MaterialRequestWorkflowID, 
'Material_RequestSubmit.xml', 'Material_RequestSubmitItem.xml', 'Material_RequestWorkflowItem.xml', 'Control_MaterialRequestWorkflowItem_Default.xml',
@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '097', GetDate())

GO



