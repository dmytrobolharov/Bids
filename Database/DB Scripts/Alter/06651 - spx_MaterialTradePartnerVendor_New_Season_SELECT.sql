IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialTradePartnerVendor_New_Season_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialTradePartnerVendor_New_Season_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_MaterialTradePartnerVendor_New_Season_SELECT] (
@MaterialTradePartnerID UNIQUEIDENTIFIER ,
@SeasonYearID UNIQUEIDENTIFIER
)
AS 

	DECLARE @TradePartnerID UNIQUEIDENTIFIER
	DECLARE @TradePartnerRelationshipLevelID UNIQUEIDENTIFIER
	DECLARE @MaterialID UNIQUEIDENTIFIER
	
	SELECT @TradePartnerID = TradePartnerID, @TradePartnerRelationshipLevelID = TradePartnerRelationshipLevelID, @MaterialID = MaterialID
	FROM pMaterialTradePartner 
	WHERE  MaterialTradePartnerID = @MaterialTradePartnerID

	SELECT MaterialTradePartnerID FROM pMaterialTradePartner 
	WHERE TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID
	AND MaterialID = @MaterialID
	AND SeasonYearID = @SeasonYearID 
	
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06651', GetDate())
GO
