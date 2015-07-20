IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialTradePartnerTemp_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialTradePartnerTemp_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_MaterialTradePartnerTemp_DELETE]
	@MaterialID UNIQUEIDENTIFIER,
	@TradePartnerRelationshipLevelID UNIQUEIDENTIFIER
AS
BEGIN

	DELETE FROM tmpMaterialTradePartner WHERE MaterialID = @MaterialID ANd TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06076', GetDate())
GO
