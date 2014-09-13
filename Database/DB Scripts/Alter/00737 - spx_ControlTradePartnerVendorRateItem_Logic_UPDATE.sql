IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ControlTradePartnerVendorRateItem_Logic_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_ControlTradePartnerVendorRateItem_Logic_UPDATE]
GO


CREATE PROCEDURE dbo.spx_ControlTradePartnerVendorRateItem_Logic_UPDATE (
@TradePartnerVendorRateItemID UNIQUEIDENTIFIER,
@MUser NVARCHAR(200),
@MDate DATETIME
)
AS 


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '737', GetDate())
GO

