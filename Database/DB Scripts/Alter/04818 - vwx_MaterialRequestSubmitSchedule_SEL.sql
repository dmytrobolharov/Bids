IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MaterialRequestSubmitSchedule_SEL]'))
DROP VIEW [dbo].[vwx_MaterialRequestSubmitSchedule_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_MaterialRequestSubmitSchedule_SEL]
AS
SELECT     TOP (100) PERCENT dbo.pMaterialTradePartner.MaterialTradePartnerId, dbo.pMaterialTradePartner.SeasonYearID, 
                      dbo.pMaterialTradePartner.MaterialRequestWorkflowTempID, dbo.pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID, 
                      '<IMG src=''' + '../System/Icons/' + dbo.pMaterialRequestSubmitStatus.StatusIcon + '''>' AS StatusUrl, 
                      dbo.pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID, dbo.pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowTempItemID, 
                      dbo.pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID, dbo.pMaterialRequestSubmitWorkflow.MaterialID, 
                      dbo.pMaterialRequestSubmitWorkflow.MaterialColorID, dbo.pMaterialRequestSubmitWorkflow.TradePartnerID, 
                      dbo.pMaterialRequestSubmitWorkflow.TradePartnerVendorID, dbo.pMaterialRequestSubmitWorkflow.Submit, dbo.pMaterialRequestSubmitWorkflow.SubmitDays, 
                      dbo.pMaterialRequestSubmitWorkflow.ResubmitDays, ISNULL(dbo.pMaterialRequestSubmitWorkflow.AssignedTo, 0) AS AssignedTo, 
                      dbo.pMaterialRequestSubmitWorkflow.StartDate, dbo.pMaterialRequestSubmitWorkflow.DueDate, dbo.pMaterialRequestSubmitWorkflow.EndDate, 
                      dbo.pMaterialRequestSubmitWorkflow.CUser, dbo.pMaterialRequestSubmitWorkflow.CDate, dbo.pMaterialRequestSubmitWorkflow.MUser, 
                      dbo.pMaterialRequestSubmitWorkflow.MDate, dbo.pMaterialRequestSubmitWorkflow.TUser, dbo.pMaterialRequestSubmitWorkflow.TDate, 
                      dbo.pMaterialRequestSubmitWorkflow.FinalDate, dbo.pMaterialRequestWorkflow.MaterialRequestWorkflow, dbo.pMaterialRequestSubmitStatus.StatusID, 
                      dbo.pMaterialRequestSubmitStatus.Status, dbo.pMaterialRequestWorkflow.MaterialRequestWorkflowSort, dbo.pMaterialRequestSubmitWorkflow.Active, 
                      dbo.pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowGroupID, dbo.pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowSort AS Sort, 
                      dbo.pMaterialRequestSubmitWorkflow.MaterialRequestSubmitAllColors,
                      dbo.pMaterialRequestSubmitWorkflow.MaterialRequestPartnerTypeID
FROM         dbo.pMaterialRequestWorkflowTemplateItem INNER JOIN
                      dbo.pMaterialRequestWorkflowTemplate ON 
                      dbo.pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowTempID = dbo.pMaterialRequestWorkflowTemplate.MaterialRequestWorkflowTempID RIGHT OUTER
                       JOIN
                      dbo.pMaterialTradePartner INNER JOIN
                      dbo.pMaterialRequestSubmitStatus INNER JOIN
                      dbo.pMaterialRequestSubmitWorkflow ON dbo.pMaterialRequestSubmitStatus.StatusID = dbo.pMaterialRequestSubmitWorkflow.Status INNER JOIN
                      dbo.pMaterialRequestWorkflow ON 
                      dbo.pMaterialRequestWorkflow.MaterialRequestWorkflowID = dbo.pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID ON 
                      dbo.pMaterialTradePartner.MaterialTradePartnerId = dbo.pMaterialRequestSubmitWorkflow.MaterialTradePartnerID ON 
                      dbo.pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowTempItemID = dbo.pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowTempItemID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04818', GetDate())
GO
