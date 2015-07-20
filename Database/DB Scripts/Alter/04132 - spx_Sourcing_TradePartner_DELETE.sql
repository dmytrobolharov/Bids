/****** Object:  StoredProcedure [dbo].[spx_Sourcing_TradePartner_DELETE]    Script Date: 10/07/2012 15:25:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_TradePartner_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_TradePartner_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_Sourcing_TradePartner_DELETE]    Script Date: 10/07/2012 15:25:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_Sourcing_TradePartner_DELETE]
	@SourcingTradePartnerID UNIQUEIDENTIFIER	
AS
BEGIN
	
	DELETE FROM pSourcingTradePartner WHERE SourcingTradePartnerID = @SourcingTradePartnerID	
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04132', GetDate())
GO