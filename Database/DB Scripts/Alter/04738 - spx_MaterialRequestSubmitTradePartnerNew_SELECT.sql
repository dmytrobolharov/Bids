/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitTradePartnerNew_SELECT]    Script Date: 01/10/2013 18:24:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitTradePartnerNew_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitTradePartnerNew_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitTradePartnerNew_SELECT]    Script Date: 01/10/2013 18:24:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE[dbo].[spx_MaterialRequestSubmitTradePartnerNew_SELECT](
@TradePartnerId uniqueidentifier,
@Top INT ,
@Total INT OUTPUT 
)
AS 


DECLARE @SQLString nvarchar(4000)

CREATE TABLE #tmpChildVendors
(
	TradePartnerID UNIQUEIDENTIFIER,
	TradePartnerName NVARCHAR(200),
	TradePartnerRelationshipID UNIQUEIDENTIFIER
)

-- Selecting all children of given trade partner
;WITH partners AS (
SELECT *, 0 as Level FROM vwx_Sourcing_TradePartner_REL_SEL
WHERE TradePartnerMasterID IS NULL	
AND TradePartnerID = @TradePartnerID

UNION ALL 

SELECT tp.*, Level + 1 FROM vwx_Sourcing_TradePartner_REL_SEL tp
INNER JOIN partners p ON p.TradePartnerID = tp.TradePartnerMasterID
WHERE Level < 3
) 
INSERT INTO #tmpChildVendors (TradePartnerID, TradePartnerName, TradePartnerRelationshipID)
SELECT p.TradePartnerID, tp.TradePartnerName, TradePartnerRelationshipID FROM partners p
LEFT JOIN uTradePartner tp ON tp.TradePartnerID = p.TradePartnerID

SELECT @Total = COUNT(*) FROM ( 
		SELECT pMaterialTradePartnerColor.MaterialTradePartnerColorID, 
		pMaterial.MaterialID, 
		pComponentType.ComponentDescription, 
		pMaterial.MaterialNo, pMaterial.MaterialName, 
		pMaterialTradePartnerColor.ColorCode, 
		pMaterialTradePartnerColor.ColorNo, 
		pMaterialTradePartnerColor.ColorName, 
		vwx_MaterialSize_SEL.MaterialSize, 
		pMaterialTradePartnerColor.AgentView,
		uTradePartner.TradePartnerID,
		uTradePartner.TradePartnerName,
		uTradePartner.TradePartnerCode,
		pMaterialTradePartnerColor.CDate
		FROM pMaterial INNER JOIN
			pMaterialTradePartnerColor ON pMaterial.MaterialID = pMaterialTradePartnerColor.MaterialID INNER JOIN
			pComponentType ON pMaterial.MaterialType = pComponentType.ComponentTypeID INNER JOIN
			vwx_MaterialSize_SEL ON pMaterialTradePartnerColor.MaterialSizeID = vwx_MaterialSize_SEL.MaterialSizeID INNER JOIN
			pMaterialTradePartner ON pMaterialTradePartnerColor.MaterialTradePartnerID = pMaterialTradePartner.MaterialTradePartnerId INNER JOIN
			uTradePartner ON uTradePartner.TradePartnerID = pMaterialTradePartner.TradepartnerId INNER JOIN
			#tmpChildVendors ON uTradePartner.TradePartnerId = #tmpChildVendors.TradePartnerID
		WHERE pMaterialTradePartnerColor.MaterialRequestShare = 1 
		AND pMaterialTradePartnerColor.AgentView = 0 
		AND CAST(pMaterialTradePartner.MaterialRequestWorkflowTempID AS VARCHAR(40)) <> ''
) AS tbl

IF (@Top IS NULL) OR ( @Top<=0 )
	SET @SQLString = 'SELECT ' 
ELSE 
	SET @SQLString = 'SELECT TOP ' +  CAST ( @Top AS NVARCHAR(5) ) 


SET @SQLString = @SQLString  + '
				pMaterialTradePartnerColor.MaterialTradePartnerColorID, 
				pMaterial.MaterialID, 
				pComponentType.ComponentDescription, 
				pMaterial.MaterialNo, 
				pMaterial.MaterialName, 
				pMaterialTradePartnerColor.ColorCode, 
				pMaterialTradePartnerColor.ColorNo, 
				pMaterialTradePartnerColor.ColorName, 
				vwx_MaterialSize_SEL.MaterialSize, 
				pMaterialTradePartnerColor.AgentView,
				uTradePartner.TradePartnerID,
				uTradePartner.TradePartnerName,
				uTradePartner.TradePartnerCode, 
				pMaterialTradePartnerColor.CDate
		FROM pMaterial INNER JOIN
			  pMaterialTradePartnerColor ON pMaterial.MaterialID = pMaterialTradePartnerColor.MaterialID INNER JOIN
			  pComponentType ON pMaterial.MaterialType = pComponentType.ComponentTypeID INNER JOIN
			  vwx_MaterialSize_SEL ON pMaterialTradePartnerColor.MaterialSizeID = vwx_MaterialSize_SEL.MaterialSizeID INNER JOIN
			  pMaterialTradePartner ON pMaterialTradePartnerColor.MaterialTradePartnerID = pMaterialTradePartner.MaterialTradePartnerId INNER JOIN
			  uTradePartner ON uTradePartner.TradePartnerID = pMaterialTradePartner.TradepartnerId INNER JOIN
			  #tmpChildVendors ON uTradePartner.TradePartnerId = #tmpChildVendors.TradePartnerID
		WHERE pMaterialTradePartnerColor.MaterialRequestShare = 1 
			AND pMaterialTradePartnerColor.AgentView = 0 
			AND CAST(pMaterialTradePartner.MaterialRequestWorkflowTempID AS VARCHAR(40)) <> ''''
			ORDER BY dbo.pMaterialTradePartnerColor.CDate DESC, dbo.uTradePartner.TradePartnerCode, dbo.pMaterial.MaterialNo, dbo.pMaterialTradePartnerColor.ColorName, 
           dbo.vwx_MaterialSize_SEL.MaterialSize 
'

EXECUTE sp_executesql @SQLString


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04738', GetDate())
GO
