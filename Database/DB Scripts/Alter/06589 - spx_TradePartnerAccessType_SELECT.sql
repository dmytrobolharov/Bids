IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TradePartnerAccessType_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TradePartnerAccessType_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_TradePartnerAccessType_SELECT]
AS
BEGIN
	SELECT PartnerAccessTypeID, PartnerAccessTypeDesr FROM pTradePartnerAccessType WHERE Active = 1 ORDER BY pTradePartnerAccessType.PartnerAccessTypeOrder
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06589', GetDate())
GO
