DROP PROCEDURE [dbo].[spx_Material_TradePartnerColor_ApprovedStatusCheck]
GO

CREATE PROCEDURE [dbo].[spx_Material_TradePartnerColor_ApprovedStatusCheck]
	@MaterialId uniqueidentifier
AS
BEGIN
	UPDATE pMaterialTradePartnerColor SET Status = 10
	WHERE MaterialTradePartnerColorID IN (
	SELECT pMaterialTradePartnerColor.MaterialTradePartnerColorID
	FROM  pMaterialTradePartnerColor INNER JOIN
		pMaterialTradePartner ON pMaterialTradePartnerColor.MaterialTradePartnerID = pMaterialTradePartner.MaterialTradePartnerId INNER JOIN
		pMaterialRequestSubmitWorkflow ON pMaterialTradePartnerColor.MaterialTradePartnerColorID = pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID INNER JOIN
		pMaterialRequestSubmitItemStatus ON pMaterialRequestSubmitWorkflow.Status = pMaterialRequestSubmitItemStatus.StatusID
	WHERE pMaterialTradePartner.MaterialId = @MaterialId
	AND (pMaterialRequestSubmitItemStatus.StatusID = 2 OR pMaterialRequestSubmitItemStatus.StatusID = 3)
	GROUP BY pMaterialTradePartnerColor.MaterialTradePartnerColorID
	HAVING COUNT(pMaterialRequestSubmitItemStatus.StatusID) = (
		SELECT COUNT(MaterialRequestWorkflowID) FROM pMaterialRequestSubmitWorkflow mrsw
		INNER JOIN pMaterialTradePartnerColor mtpc ON mtpc.MaterialTradePartnerColorID = mrsw.MaterialTradePartnerColorID
		WHERE mrsw.MaterialTradePartnerColorID = pMaterialTradePartnerColor.MaterialTradePartnerColorID
		GROUP BY mrsw.MaterialTradePartnerColorID))
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08840', GetDate())
GO



