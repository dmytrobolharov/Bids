/****** Object:  StoredProcedure [dbo].[spx_VendorTradePartnerComplianceItem_Add]    Script Date: 09/25/2012 15:41:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_VendorTradePartnerComplianceItem_Add]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_VendorTradePartnerComplianceItem_Add]
GO

/****** Object:  StoredProcedure [dbo].[spx_VendorTradePartnerComplianceItem_Add]    Script Date: 09/25/2012 15:41:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_VendorTradePartnerComplianceItem_Add]
(
@TradePartnerComplianceId uniqueidentifier,
@TradePartnerId uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
as

begin
		 INSERT INTO uTradePartnerComplianceItem(
			[TradePartnerComplianceId]
           ,[TradePartnerId]
           ,[AuditStandardId]
           ,[AuditStandardItemId]
           ,[ItemDesc]
           ,[StatusId]           
           ,[Active]
           ,[Sort]
           ,[CDate]
		   ,[MDate]
		   ,[CUser]
		   ,[MUser])
SELECT  uTradePartnerCompliance.TradePartnerComplianceId, uTradePartnerCompliance.TradePartnerId, uTradePartnerCompliance.AuditStandardId, 
                      uTradePartnerComplianceAuditStandardItem.AuditStandardItemId, uTradePartnerComplianceAuditStandardItem.AuditStandardItemName, 
                      '00000000-0000-0000-0000-000000000001',1,uTradePartnerComplianceAuditStandardItem.sort,
                      @CreatedDate, @CreatedDate, @CreatedBy, @CreatedBy
FROM    uTradePartnerCompliance INNER JOIN
                      uTradePartnerComplianceAuditStandardItem ON uTradePartnerCompliance.AuditStandardId = uTradePartnerComplianceAuditStandardItem.AuditStandardId
                      where uTradePartnerCompliance.TradePartnerComplianceId=@TradePartnerComplianceId and uTradePartnerCompliance.TradePartnerId=@TradePartnerId
                      
                      END
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03988', GetDate())
GO