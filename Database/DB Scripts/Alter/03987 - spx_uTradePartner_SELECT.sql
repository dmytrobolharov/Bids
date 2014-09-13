
/****** Object:  StoredProcedure [dbo].[spx_uTradePartner_SELECT]    Script Date: 09/25/2012 15:40:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_uTradePartner_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_uTradePartner_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_uTradePartner_SELECT]    Script Date: 09/25/2012 15:40:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[spx_uTradePartner_SELECT](@TradePartnerID uniqueidentifier)
AS 
SELECT * FROM  dbo.uTradePartner 
WHERE     (TradePartnerID = @TradePartnerID)


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03987', GetDate())
GO