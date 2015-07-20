IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TradePartnerListHistory_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TradePartnerListHistory_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_TradePartnerListHistory_SELECT](
	@TeamID UNIQUEIDENTIFIER
)
AS 

	SELECT a.TradePartnerID, b.TradePartnerName, b.TradePartnerCode FROM pPartnerListHistory a
				INNER JOIN uTradePartner b on a.TradePartnerID = b.TradePartnerID
	WHERE a.TeamID = @TeamId
	ORDER BY a.CDate DESC
	
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04462', GetDate())
GO
