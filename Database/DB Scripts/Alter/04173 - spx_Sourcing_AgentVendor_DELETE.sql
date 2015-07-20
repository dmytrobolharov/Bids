
/****** Object:  StoredProcedure [dbo].[spx_Sourcing_AgentVendor_DELETE]    Script Date: 10/12/2012 15:46:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_AgentVendor_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_AgentVendor_DELETE]
GO


/****** Object:  StoredProcedure [dbo].[spx_Sourcing_AgentVendor_DELETE]    Script Date: 10/12/2012 15:46:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



create PROCEDURE [dbo].[spx_Sourcing_AgentVendor_DELETE]
	@SourcingTradePartnerID UNIQUEIDENTIFIER	
AS
BEGIN
	
	DELETE FROM pSourcingAgentVendor WHERE SourcingTradePartnerID = @SourcingTradePartnerID	
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04173', GetDate())
GO
