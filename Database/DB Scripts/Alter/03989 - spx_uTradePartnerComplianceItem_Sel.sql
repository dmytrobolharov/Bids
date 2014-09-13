
/****** Object:  StoredProcedure [dbo].[spx_uTradePartnerComplianceItem_Sel]    Script Date: 09/25/2012 15:43:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_uTradePartnerComplianceItem_Sel]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_uTradePartnerComplianceItem_Sel]
GO


/****** Object:  StoredProcedure [dbo].[spx_uTradePartnerComplianceItem_Sel]    Script Date: 09/25/2012 15:43:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_uTradePartnerComplianceItem_Sel] 
(   
	@TradePartnerId uniqueidentifier,
	@TradePartnerComplianceID uniqueidentifier
)
AS

BEGIN

SELECT  uTradePartnerComplianceItem.*
FROM   uTradePartnerComplianceItem LEFT JOIN
uTradePartnerComplianceStatus ON uTradePartnerComplianceItem.StatusId = uTradePartnerComplianceStatus.StatusId
WHERE  uTradePartnerComplianceItem.TradePartnerID = @TradePartnerId and uTradePartnerComplianceItem.TradePartnerComplianceID  = @TradePartnerComplianceID  
order by uTradePartnerComplianceItem.sort  ,  uTradePartnerComplianceItem.ItemDesc 
END




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03989', GetDate())
GO