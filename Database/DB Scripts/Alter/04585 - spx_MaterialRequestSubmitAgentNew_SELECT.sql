IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitAgentNew_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitAgentNew_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitAgentNew_SELECT](
@TradePartnerId uniqueidentifier,
@Top INT ,
@Total INT OUTPUT 
)
AS 


DECLARE @SQLString nvarchar(4000)
DECLARE @ParmDefinition nvarchar(500)


SET @SQLString = 'SELECT @pTotal = COUNT(*) FROM ( 
		SELECT pMaterialTradePartnerColor.MaterialTradePartnerColorID, pMaterial.MaterialID, pComponentType.ComponentDescription, 
		  pMaterial.MaterialNo, pMaterial.MaterialName, pMaterialTradePartnerColor.ColorCode, pMaterialTradePartnerColor.ColorNo, 
		  pMaterialTradePartnerColor.ColorName, vwx_MaterialSize_SEL.MaterialSize, pMaterialTradePartnerColor.AgentView, uTradePartnerVendor.VendorCode,
		  uTradePartnerVendor.VendorName, pMaterialTradePartnerColor.CDate
		FROM pMaterial INNER JOIN
		  pMaterialTradePartnerColor ON pMaterial.MaterialID = pMaterialTradePartnerColor.MaterialID INNER JOIN
		  pComponentType ON pMaterial.MaterialType = pComponentType.ComponentTypeID INNER JOIN
		  vwx_MaterialSize_SEL ON pMaterialTradePartnerColor.MaterialSizeID = vwx_MaterialSize_SEL.MaterialSizeID INNER JOIN
		  pMaterialTradePartner ON pMaterialTradePartnerColor.MaterialTradePartnerID = pMaterialTradePartner.MaterialTradePartnerId INNER JOIN
		  uTradePartnerVendor ON pMaterialTradePartner.TradepartnerVendorId = uTradePartnerVendor.TradePartnerVendorID
		WHERE pMaterialTradePartnerColor.MaterialRequestShare = 1 AND uTradePartnerVendor.TradePartnerID = @pTradePartnerId AND pMaterialTradePartnerColor.AgentView = 0 AND CAST(pMaterialTradePartner.MaterialRequestWorkflowTempID AS VARCHAR(40)) <> '''' 
)  AS FOO
'

SET @ParmDefinition = '@pTradePartnerId UNIQUEIDENTIFIER, @pTotal INT OUTPUT'

EXECUTE sp_executesql @SQLString, @ParmDefinition, 
		@pTradePartnerId = @TradePartnerId, 
		@pTotal = @Total OUTPUT

IF (@Top IS NULL) OR ( @Top<=0 )
	SET @SQLString = 'SELECT ' 
ELSE 
	SET @SQLString = 'SELECT TOP ' +  CAST ( @Top AS NVARCHAR(5) ) 


SET @SQLString = @SQLString  + 'pMaterialTradePartnerColor.MaterialTradePartnerColorID, pMaterial.MaterialID, pComponentType.ComponentDescription, 
		  pMaterial.MaterialNo, pMaterial.MaterialName, pMaterialTradePartnerColor.ColorCode, pMaterialTradePartnerColor.ColorNo, 
		  pMaterialTradePartnerColor.ColorName, vwx_MaterialSize_SEL.MaterialSize, pMaterialTradePartnerColor.AgentView, uTradePartnerVendor.VendorCode,
		  uTradePartnerVendor.VendorName, pMaterialTradePartnerColor.CDate
		FROM pMaterial INNER JOIN
		  pMaterialTradePartnerColor ON pMaterial.MaterialID = pMaterialTradePartnerColor.MaterialID INNER JOIN
		  pComponentType ON pMaterial.MaterialType = pComponentType.ComponentTypeID INNER JOIN
		  vwx_MaterialSize_SEL ON pMaterialTradePartnerColor.MaterialSizeID = vwx_MaterialSize_SEL.MaterialSizeID INNER JOIN
		  pMaterialTradePartner ON pMaterialTradePartnerColor.MaterialTradePartnerID = pMaterialTradePartner.MaterialTradePartnerId INNER JOIN
		  uTradePartnerVendor ON pMaterialTradePartner.TradepartnerVendorId = uTradePartnerVendor.TradePartnerVendorID
		WHERE pMaterialTradePartnerColor.MaterialRequestShare = 1 AND uTradePartnerVendor.TradePartnerID = @pTradePartnerId AND pMaterialTradePartnerColor.AgentView = 0 
		AND CAST(pMaterialTradePartner.MaterialRequestWorkflowTempID AS VARCHAR(40)) <> ''''
		ORDER BY dbo.pMaterialTradePartnerColor.CDate DESC, dbo.uTradePartnerVendor.VendorCode, dbo.pMaterial.MaterialNo, dbo.pMaterialTradePartnerColor.ColorName, 
           dbo.vwx_MaterialSize_SEL.MaterialSize
'


SET @ParmDefinition = '@pTradePartnerId UNIQUEIDENTIFIER'
EXECUTE sp_executesql @SQLString, @ParmDefinition, 
		@pTradePartnerId = @TradePartnerId



/*
MODIFIED: July 25, 2008

SELECT     a.SampleRequestTradeID, a.CDate, b.StyleID, b.StyleNo,     b.Description, b.SizeClass, c.VendorName, a.TradePartnerID, c.VendorCode , d.StyleSet
FROM         pStyleHeader b WITH (NOLOCK) INNER JOIN
    pSampleRequestTrade  a WITH (NOLOCK) ON b.StyleID = a.StyleID INNER JOIN
    uTradePartnerVendor  c WITH (NOLOCK) ON a.TradePartnerVendorID = c.TradePartnerVendorID 
    INNER JOIN pSampleRequestWorkflow d ON d.SampleRequestTradeID = a.SampleRequestTradeID
WHERE ( a.TradePartnerID = @TradePartnerId ) 
AND (a.AgentView = 0) AND (a.SampleRequestShare = 1)
GROUP BY a.SampleRequestTradeID, a.CDate, b.StyleID, b.StyleNo,     b.Description, b.SizeClass, c.VendorName, a.TradePartnerID, c.VendorCode , d.StyleSet
ORDER BY c.VendorCode, a.CDate, b.SizeClass, d.StyleSet



*/

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04585', GetDate())
GO
