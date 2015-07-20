IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MaterialRequest_TACalendar_SEL]'))
DROP VIEW [dbo].[vwx_MaterialRequest_TACalendar_SEL]
GO


CREATE VIEW [dbo].[vwx_MaterialRequest_TACalendar_SEL]
AS
SELECT		pMaterialTradePartner.MaterialTradePartnerId, pMaterialTradePartner.MaterialId, pMaterialTradePartner.SeasonYearID,
		pMaterialTradePartner.MaterialRequestWorkflowTempID, pMaterialTradePartner.MaterialRequestWorkflowStartDate, pMaterialTradePartner.MaterialRequestWorkflowDueDate,
		pMaterialTradePartner.MaterialTradePartnerCustom3, pMaterialTradePartner.MaterialTradePartnerCustom4, 
		pMaterialTradePartner.CUser, pMaterialTradePartner.CDate, pMaterialTradePartner.MUser, pMaterialTradePartner.MDate,
		pTACalTemplate.TACalTemplateId as MaterialRequestTACalendarID,
		pTACalTemplate.TACalTemplateId, pTACalTemplate.TACalTemplateName, pTACalTemplate.TACalTemplateDescription
				
FROM		pMaterialTradePartner 
		LEFT JOIN pTACalReference ON pMaterialTradePartner.MaterialTradePartnerId = pTACalReference.ReferenceId
		LEFT JOIN pTACalTemplate ON pTACalReference.TACalTemplateId = pTACalTemplate.TACalTemplateId

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08646', GetDate())
GO
