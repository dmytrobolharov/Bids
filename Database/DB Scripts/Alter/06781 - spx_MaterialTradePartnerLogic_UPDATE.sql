IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialTradePartnerLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialTradePartnerLogic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_MaterialTradePartnerLogic_UPDATE]  (
@MaterialTradePartnerID  uniqueidentifier , 
@Query nvarchar(4000),
@MUser nvarchar ( 200 )  , 
@MDate datetime 
)
AS

	--SELECT TOP 1 * FROM pMaterialTradePartner WITH (NOLOCK) WHERE MaterialTradePartnerID = @MaterialTradePartnerID


	BEGIN TRAN

	EXEC(@Query)
	
	
	/*- update Currency field from TradePartner table if it is empty -*/
	DECLARE @TradePartnerID UNIQUEIDENTIFIER
	DECLARE @DefaultCurrency NVARCHAR(5)

	-- low level of hierarchy
	SELECT @TradePartnerID = coalesce(FactoryID,VendorID,AgentID) FROM vwx_TradePartnerRelationshipLevels_SEL 
	WHERE TradePartnerRelationshipLevelID = (SELECT TradePartnerRelationshipLevelID FROM pMaterialTradePartner WHERE MaterialTradePartnerId = @MaterialTradePartnerID)
	
	SELECT @DefaultCurrency = DefaultCurrency FROM uTradePartner WHERE TradePartnerID = @TradePartnerID
	
	IF @DefaultCurrency <> '' AND @DefaultCurrency IS NOT NULL
	BEGIN
		UPDATE pMaterialTradePartner
		SET CurrencyType = @DefaultCurrency
		WHERE MaterialTradePartnerId = @MaterialTradePartnerID
	END
	/*----------------------------------------------------------------*/
	
	
	DECLARE @MaterialTradePartnerCustom1 nvarchar(50)
	SELECT @MaterialTradePartnerCustom1 = MaterialTradePartnerCustom1 FROM pMaterialTradePartner WITH (NOLOCK) WHERE MaterialTradePartnerID = @MaterialTradePartnerID
	

	IF (SELECT COUNT(*) FROM pMaterialTradePartner WITH (NOLOCK) WHERE MaterialTradePartnerCustom1 = @MaterialTradePartnerCustom1 AND MaterialTradePartnerID <> @MaterialTradePartnerID) = 0
		BEGIN
			COMMIT TRAN
			SELECT 1
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
			SELECT 0
		END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06781', GetDate())
GO
