IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestWorkflow_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestWorkflow_INSERT]
GO
/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestWorkflow_INSERT]    Script Date: 08/27/2014 13:46:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[spx_MaterialRequestWorkflow_INSERT] (
@MaterialRequestWorkflowID nVARCHAR(5),
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
AS 

INSERT INTO pMaterialRequestWorkflow(MaterialRequestWorkflowID, 
MaterialRequestSubmitSchema, MaterialRequestWorkflowSchema, MaterialRequestWorkflowItemSchema, MaterialRequestWorkflowControlSchema,
CUser, CDate, MUser, MDate, MaterialRequestWorkflowGUIDID) 
VALUES (@MaterialRequestWorkflowID, 
'Material_RequestSubmit.xml', 'Material_RequestSubmitItem.xml', 'Material_RequestWorkflowItem.xml', 'Control_MaterialRequestWorkflowItem_Default.xml',
@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate, NEWID())
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '09001', GetDate())
GO