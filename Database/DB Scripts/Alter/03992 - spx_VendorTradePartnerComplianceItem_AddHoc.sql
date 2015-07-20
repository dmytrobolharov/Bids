/****** Object:  StoredProcedure [dbo].[spx_VendorTradePartnerComplianceItem_AddHoc]    Script Date: 09/25/2012 15:47:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_VendorTradePartnerComplianceItem_AddHoc]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_VendorTradePartnerComplianceItem_AddHoc]
GO

/****** Object:  StoredProcedure [dbo].[spx_VendorTradePartnerComplianceItem_AddHoc]    Script Date: 09/25/2012 15:47:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_VendorTradePartnerComplianceItem_AddHoc]
(
@TradePartnerComplianceId uniqueidentifier,
@TradePartnerId uniqueidentifier,
@TradePartnercnt int,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
as

begin

declare @AuditStandardId uniqueidentifier
declare @icnt int
declare @Sort int 
set @icnt=0
set @Sort=0

select @AuditStandardId= AuditStandardId from  uTradePartnerCompliance 
where TradePartnerComplianceId=@TradePartnerComplianceId and 
TradePartnerId=@TradePartnerId

select @Sort = max(Sort) from  uTradePartnerComplianceItem 
where TradePartnerComplianceId=@TradePartnerComplianceId and 
TradePartnerId=@TradePartnerId

set @Sort=@Sort+1

while @icnt<@TradePartnercnt
	begin
		INSERT INTO uTradePartnerComplianceItem(
			[TradePartnerComplianceId]
		   ,[TradePartnerId]
		   ,[AuditStandardId]
		   ,[AuditStandardItemId]  
		   ,[StatusId]           
		   ,[Active]
		   ,[Sort]
		   ,[CDate]
		   ,[MDate]
		   ,[CUser]
		   ,[MUser]
		   ) values
		   (@TradePartnerComplianceId,@TradePartnerId, @AuditStandardId,
			'00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', 
			1,@Sort, @CreatedDate, @CreatedDate, @CreatedBy, @CreatedBy)
		set @icnt = @icnt+1
		set @Sort=@Sort+1
	end
end
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03992', GetDate())
GO

