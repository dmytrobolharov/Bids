
/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitTradePartnerNew_SELECT]    Script Date: 01/24/2013 15:52:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitTradePartnerNew_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitTradePartnerNew_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitTradePartnerNew_SELECT]    Script Date: 01/24/2013 15:52:59 ******/
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
		pMaterialTradePartnerColor.CDate,
		tprl.AgentID,
		tprl.AgentName,
		tprl.VendorID,
		tprl.VendorName,
		tprl.FactoryID,
		tprl.FactoryName
		FROM pMaterial INNER JOIN
			pMaterialTradePartnerColor ON pMaterial.MaterialID = pMaterialTradePartnerColor.MaterialID INNER JOIN
			pComponentType ON pMaterial.MaterialType = pComponentType.ComponentTypeID INNER JOIN
			vwx_MaterialSize_SEL ON pMaterialTradePartnerColor.MaterialSizeID = vwx_MaterialSize_SEL.MaterialSizeID INNER JOIN
			pMaterialTradePartner ON pMaterialTradePartnerColor.MaterialTradePartnerID = pMaterialTradePartner.MaterialTradePartnerId INNER JOIN
			uTradePartner ON uTradePartner.TradePartnerID = pMaterialTradePartner.TradepartnerId LEFT JOIN
			vwx_TradePartnerRelationshipLevels_SEL tprl ON tprl.TradePartnerRelationshipLevelID = pMaterialTradePartner.TradePartnerRelationshipLevelID
		WHERE pMaterialTradePartnerColor.MaterialRequestShare = 1
		AND @TradePartnerId IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID)
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
				pMaterialTradePartnerColor.CDate, 
				tprl.AgentID,
				tprl.AgentName, 
				tprl.VendorID, 
				tprl.VendorName, 
				tprl.FactoryID, 
				tprl.FactoryName 
				FROM pMaterial INNER JOIN
			  pMaterialTradePartnerColor ON pMaterial.MaterialID = pMaterialTradePartnerColor.MaterialID INNER JOIN
			  pComponentType ON pMaterial.MaterialType = pComponentType.ComponentTypeID INNER JOIN
			  vwx_MaterialSize_SEL ON pMaterialTradePartnerColor.MaterialSizeID = vwx_MaterialSize_SEL.MaterialSizeID INNER JOIN
			  pMaterialTradePartner ON pMaterialTradePartnerColor.MaterialTradePartnerID = pMaterialTradePartner.MaterialTradePartnerId INNER JOIN
			  uTradePartner ON uTradePartner.TradePartnerID = pMaterialTradePartner.TradepartnerId  LEFT JOIN
			vwx_TradePartnerRelationshipLevels_SEL tprl ON tprl.TradePartnerRelationshipLevelID = pMaterialTradePartner.TradePartnerRelationshipLevelID
		WHERE pMaterialTradePartnerColor.MaterialRequestShare = 1 
			AND (tprl.AgentID =''' + CAST(@TradePartnerId AS VARCHAR(40)) + ''' 
			OR tprl.VendorID = ''' + CAST(@TradePartnerId AS VARCHAR(40)) +  ''' 
			OR tprl.FactoryID = ''' + CAST(@TradePartnerId AS VARCHAR(40)) + ''') 
			AND pMaterialTradePartnerColor.AgentView = 0 
			AND CAST(pMaterialTradePartner.MaterialRequestWorkflowTempID AS VARCHAR(40)) <> ''''
			ORDER BY dbo.pMaterialTradePartnerColor.CDate DESC, dbo.uTradePartner.TradePartnerCode, dbo.pMaterial.MaterialNo, dbo.pMaterialTradePartnerColor.ColorName, 
           dbo.vwx_MaterialSize_SEL.MaterialSize 
'

EXECUTE sp_executesql @SQLString




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04875', GetDate())
GO
