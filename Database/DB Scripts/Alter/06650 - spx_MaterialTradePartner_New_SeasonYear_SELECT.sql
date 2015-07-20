IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialTradePartner_New_SeasonYear_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialTradePartner_New_SeasonYear_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_MaterialTradePartner_New_SeasonYear_SELECT]
	@MaterialID UNIQUEIDENTIFIER , 
	@MaterialTradePartnerID UNIQUEIDENTIFIER
AS
BEGIN
	DECLARE @SeasonYearID UNIQUEIDENTIFIER
	DECLARE @TradePartnerID UNIQUEIDENTIFIER 
	DECLARE @TradePartnerRelationshipLevelID UNIQUEIDENTIFIER 

	SELECT @TradePartnerID = TradePartnerID , @TradePartnerRelationshipLevelID = TradePartnerRelationshipLevelID, @SeasonYearID = SeasonYearID
	FROM pMaterialTradePartner  
	WHERE MaterialTradePartnerID = @MaterialTradePartnerID 

	SELECT DISTINCT a.SeasonYearID,  b.Season + ' ' + b.Year AS SeasonYear , a.TradePartnerVendorID
	FROM pMaterialTradePartner  a  
	INNER JOIN pSeasonYear b ON a.SeasonYearID = b.SeasonYearID  
	WHERE  MaterialID = @MaterialID
	AND TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID
END

SELECT @SeasonYearID AS SeasonYearID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06650', GetDate())
GO
