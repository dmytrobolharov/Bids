
/****** Object:  Trigger [tgx_StyleHeader_DELETE]    Script Date: 12/14/2012 15:58:27 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_StyleHeader_DELETE]'))
DROP TRIGGER [dbo].[tgx_StyleHeader_DELETE]
GO

/****** Object:  Trigger [dbo].[tgx_StyleHeader_DELETE]    Script Date: 12/14/2012 15:58:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE TRIGGER [dbo].[tgx_StyleHeader_DELETE]
ON [dbo].[pStyleHeader]
FOR DELETE 
AS

DECLARE @StyleDevelopmentId Uniqueidentifier
SET @StyleDevelopmentId = (SELECT DevelopmentID FROM deleted)  

DELETE FROM pStyleAttribute WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pStyleCare WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pStyleChange WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pStyleColorway WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pStyleColorwayItem WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pStyleColorwayItemTemp WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pStyleComment WHERE StyleID IN (SELECT StyleID FROM deleted) 
--DELETE FROM pStyleCosting WHERE StyleID IN (SELECT StyleID FROM deleted) 
--DELETE FROM pStyleCostingHeader WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pStyleDetail WHERE StyleID IN (SELECT StyleID FROM deleted) 

--DELETE FROM pStyleDevelopment WHERE StyleDevelopmentID = @StyleDevelopmentId 

DELETE FROM pStyleDevelopmentItem WHERE StyleID IN (SELECT StyleID FROM deleted) 

DELETE FROM pStyleDocument WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pStyleHistory WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pStyleImage WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pStyleImageItem WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pStyleLicensee WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pStyleMaterials WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pStyleMaterialTemp WHERE StyleID IN (SELECT StyleID FROM deleted) 


DELETE FROM pStyleQuoteItemFreightCost WHERE StyleQuoteItemId IN (SELECT StyleQuoteItemId FROM pStyleQuoteItem WHERE StyleId IN (SELECT StyleId FROM deleted) ) 
DELETE FROM pStyleQuoteItem WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pStyleQuoteItemActivity WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pStyleQuoteItemTeam WHERE StyleID IN (SELECT StyleID FROM deleted)
DELETE FROM pStyleQuoteLog WHERE StyleID IN (SELECT StyleID FROM deleted) 

--DELETE FROM pStyleQuoteMessage WHERE StyleID IN (SELECT StyleID FROM deleted) 

DELETE FROM pStyleQuoteVariationFreightCost WHERE StyleQuoteVariationID IN (SELECT StyleQuoteVariationID FROM pStyleQuoteVariation WHERE StyleId IN (SELECT StyleId FROM deleted)) 
DELETE FROM pStyleQuoteVariation WHERE StyleID IN (SELECT StyleID FROM deleted) 
--DELETE FROM pStyleQuote WHERE StyleDevelopmentID = @StyleDevelopmentId 

DELETE FROM pStyleSpec WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pStyleSpecSize WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pStyleSpecSizeTemp WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pStyleSpecTemp WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pStyleTeam WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pStyleUPC WHERE StyleID IN (SELECT StyleID FROM deleted) 

DELETE FROM pStyleWorkflow WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pStyleWorkflowSchedule WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pStyleWorkflowTeam WHERE StyleID IN (SELECT StyleID FROM deleted)


--DELETE FROM pTechPackMessage WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pTechPack WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pTechPackActivity WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pTechPackLog WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pTechPackStyle WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pTechPackTeam WHERE StyleID IN (SELECT StyleID FROM deleted) 

DELETE FROM pLineFolderItem WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pLineFolderItemColor WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pLineFolderItemMessage WHERE StyleID IN (SELECT StyleID FROM deleted) 


DELETE FROM pSampleRequestSetItem WHERE SampleRequestTradeID IN (SELECT SampleRequestTradeID FROM pSampleRequestTrade WHERE StyleId IN (SELECT StyleId FROM deleted)) 
DELETE FROM pSampleRequestActivity WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pSampleRequestGroupTemp WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pSampleRequestMaterial WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pSampleRequestMaterialTemp WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pSampleRequestSpecItem WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pSampleRequestSpecItemTemp WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pSampleRequestSpecSize WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pSampleRequestSpecSizeTemp WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pSampleRequestStyle WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pSampleRequestStyleTemp WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pSampleRequestSubmit WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pSampleRequestSubmitImage WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pSampleRequestSubmitTemp WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pSampleRequestWorkflow WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pSampleRequestWorkflowTemp WHERE StyleID IN (SELECT StyleID FROM deleted) 
DELETE FROM pSampleRequestTrade WHERE StyleID IN (SELECT StyleID FROM deleted)

DELETE FROM pStyleSeasonYear WHERE StyleID IN (SELECT StyleID FROM deleted)
DELETE FROM pStyleColorwaySeasonYear WHERE StyleID IN (SELECT StyleID FROM deleted)

UPDATE pLinePlanItem SET StyleID = '00000000-0000-0000-0000-000000000000' Where StyleID IN (SELECT StyleID From deleted)
DELETE FROM pLinePlanShowroomStyleColor Where StyleID IN (SELECT StyleID From deleted)
DELETE FROM pLinePlanBusinessItem Where StyleID IN (SELECT StyleID From deleted)

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04633', GetDate())
GO
