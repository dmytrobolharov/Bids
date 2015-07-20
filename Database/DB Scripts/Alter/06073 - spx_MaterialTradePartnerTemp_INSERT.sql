IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialTradePartnerTemp_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialTradePartnerTemp_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialTradePartnerTemp_INSERT]
	@MaterialID UNIQUEIDENTIFIER,
	@TradePartnerIDChain VARCHAR(MAX)
AS
BEGIN

	-- create relationship or just get it's primary key
	declare @TradePartnerRelationshipLevelID UNIQUEIDENTIFIER
	exec spx_TradePartnerRelationshipLevels_INSERT @TradePartnerIDChain, @TradePartnerRelationshipLevelID OUT
	
	INSERT INTO tmpMaterialTradePartner(MaterialID, TradePartnerRelationshipLevelID, CDate)
	VALUES(@MaterialID, @TradePartnerRelationshipLevelID, GETDATE())
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06073', GetDate())
GO
