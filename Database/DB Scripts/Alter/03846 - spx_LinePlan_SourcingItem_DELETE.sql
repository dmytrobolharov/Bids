IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlan_SourcingItem_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlan_SourcingItem_DELETE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_LinePlan_SourcingItem_DELETE] (
@TradePartnerVendorID UNIQUEIDENTIFIER 
)
AS 

DELETE FROM pLinePlanTradePartnerItem WHERE TradePartnerVendorID = @TradePartnerVendorID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03846', GetDate())
GO
