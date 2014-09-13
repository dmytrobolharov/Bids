
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequestMaterialBOM_SEL]') AND type in (N'V'))
	DROP VIEW [dbo].[vwx_SampleRequestMaterialBOM_SEL]
GO



SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwx_SampleRequestMaterialBOM_SEL]
AS
SELECT a.SampleRequestMaterialID, a.SampleRequestTradeID, a.SampleWorkflowID,
	a.Status, a.Submit, a.StyleMaterialID, a.StyleSourcingID, a.MUser, a.MDate,
	a.ItemDim1Id, a.ItemDim2Id, a.ItemDim3Id, '' as Colorway, '' as ColorCode, '' as ColorName,
	b.MaterialNo  + ' - ' + b.MaterialName  as Material, b.MaterialImageID, b.MaterialImageVersion	 
	, c.TradePartnerVendorID	
	FROM pSampleRequestMaterialBOM a 	
	INNER JOIN pMaterial b On a.MaterialID =  b.MaterialID 
	INNER JOIN pSampleRequestBOMTrade c On c.SampleRequestTradeID = a.SampleRequestTradeID
	

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02592'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02592', GetDate())

END
GO