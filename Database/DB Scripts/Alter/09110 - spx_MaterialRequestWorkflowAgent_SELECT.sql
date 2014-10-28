IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestWorkflowAgent_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestWorkflowAgent_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialRequestWorkflowAgent_SELECT] (
@TradePartnerID UNIQUEIDENTIFIER
)
AS 


SELECT MaterialRequestWorkflowID, MaterialRequestWorkflow, GroupName, MaterialRequestWorkflowSort
FROM  pMaterialRequestWorkflow WHERE MaterialRequestWorkflowID IN (
	SELECT MaterialRequestWorkflowID
	FROM pMaterialRequestSubmitWorkflow mrsw
	INNER JOIN pMaterialTradePartner mtp 
		ON mrsw.MaterialTradePartnerID = mtp.MaterialTradePartnerId
	LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tprl 
		ON mtp.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
	WHERE @TradePartnerID IN (mrsw.TradePartnerID, tprl.AgentID, tprl.VendorID, tprl.FactoryID))
ORDER BY pMaterialRequestWorkflow.MaterialRequestWorkflowSort

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09110', GetDate())
GO
