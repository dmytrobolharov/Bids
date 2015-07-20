

/****** Object:  StoredProcedure [dbo].[spx_Sourcing_AgentVendor_INSERT]    Script Date: 10/12/2012 15:47:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_AgentVendor_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_AgentVendor_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Sourcing_AgentVendor_INSERT]    Script Date: 10/12/2012 15:47:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



create PROCEDURE [dbo].[spx_Sourcing_AgentVendor_INSERT]
	@SourcingHeaderID UNIQUEIDENTIFIER,
	@TradePartnerID UNIQUEIDENTIFIER,	
	@TradePartnerVendorID UNIQUEIDENTIFIER 	
AS
BEGIN
	
	if NOT EXISTS (SELECT * FROM pSourcingAgentVendor WHERE SourcingHeaderID = @SourcingHeaderID AND TradePartnerVendorID = @TradePartnerVendorID)
	begin
		INSERT INTO pSourcingAgentVendor(SourcingHeaderID, TradePartnerID, TradePartnerVendorID)
		VALUES	(@SourcingHeaderID, @TradePartnerID, @TradePartnerVendorID)
	end
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04172', GetDate())
GO