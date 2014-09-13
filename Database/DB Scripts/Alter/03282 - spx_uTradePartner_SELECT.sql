IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_uTradePartner_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_uTradePartner_SELECT]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spx_uTradePartner_SELECT](@TradePartnerID uniqueidentifier)
AS 
SELECT * FROM  dbo.uTradePartner 
WHERE     (TradePartnerID = @TradePartnerID)

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03282'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03282', GetDate())

END
GO