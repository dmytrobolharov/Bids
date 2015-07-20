IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_TradePartnerColor_ApprovedStatusCheck]') AND type in (N'P', N'PC'))
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
	GROUP BY pMaterialTradePartnerColor.MaterialTradePartnerColorID
	HAVING AVG(pMaterialRequestSubmitWorkflow.Status) = 3)	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08738', GetDate())
GO
