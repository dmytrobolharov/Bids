

CREATE PROCEDURE spx_MaterialTradePartnerCheck_SELECT (
@MaterialTradePartnerID UNIQUEIDENTIFIER 
)
AS


DECLARE @MaterialID UNIQUEIDENTIFIER 
DECLARE @TradepartnerVendorId UNIQUEIDENTIFIER 
DECLARE @SeasonYearID UNIQUEIDENTIFIER


SELECT @MaterialID = b.MaterialID, 
@TradepartnerVendorId = b.TradepartnerVendorId, @SeasonYearID = b.SeasonYearID 
FROM pMaterialTradePartner b 
WHERE b.MaterialTradePartnerID = @MaterialTradePartnerID


SELECT  COUNT(*)
FROM pStyleSourcingItem a
INNER JOIN pStyleSourcing b ON a.StyleSourcingID = b.StyleSourcingID 
INNER JOIN pStyleSeasonYear c ON c.StyleSeasonYearID = b.StyleSeasonYearID 
INNER JOIN pStyleMaterials d ON d.StyleMaterialID = a.StyleMaterialID 
INNER JOIN pStyleColorway e ON e.StyleColorID = a.StyleColorID 
INNER JOIN pStyleColorwayItem f ON ( f.StyleColorID = a.StyleColorID AND f.StyleMaterialID = a.StyleMaterialID )
WHERE c.SeasonYearID = @SeasonYearID
AND d.MaterialID = @MaterialID
AND a.TradePartnerVendorID = @TradepartnerVendorId
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '022', GetDate())
GO

