/****** Object:  StoredProcedure [dbo].[spx_MaterialTradePartner_ShareStatus_SELECT]    Script Date: 01/23/2013 16:10:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialTradePartner_ShareStatus_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialTradePartner_ShareStatus_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialTradePartner_ShareStatus_SELECT]    Script Date: 01/23/2013 16:10:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_MaterialTradePartner_ShareStatus_SELECT]
	@TradePartnerID UNIQUEIDENTIFIER,
	@MaterialTradePartnerID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT COUNT(*)
    FROM pMaterialTradePartnerShare
    WHERE TradePartnerID = @TradePartnerID
    AND MaterialTradePartnerID = @MaterialTradePartnerID
    
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04861', GetDate())
GO
