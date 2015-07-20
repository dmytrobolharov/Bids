/****** Object:  StoredProcedure [dbo].[spx_VendorTradePartnerCompliance_Update]    Script Date: 09/25/2012 15:48:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_VendorTradePartnerCompliance_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_VendorTradePartnerCompliance_Update]
GO

/****** Object:  StoredProcedure [dbo].[spx_VendorTradePartnerCompliance_Update]    Script Date: 09/25/2012 15:48:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_VendorTradePartnerCompliance_Update]
(
@TradePartnerComplianceId uniqueidentifier,
@TradePartnerId uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
as

declare @RecurrenceDays int
declare @AlertDays int
declare @ActualDate datetime
declare @ScheduleDate datetime
declare @AlertDate datetime

select @RecurrenceDays=COALESCE(RecurrenceDays,0),  @AlertDays=COALESCE(AlertDays,0) , @ActualDate=ActualDate
from uTradePartnerCompliance where TradePartnerComplianceId=@TradePartnerComplianceId and
TradePartnerId=@TradePartnerId

if @RecurrenceDays>0
	begin
		if @ActualDate<>''
			begin
				set @ScheduleDate=dateadd(day,@RecurrenceDays,@ActualDate)
				if @AlertDays>0 
					begin
						set @AlertDate=dateadd(day,-(@AlertDays),@ScheduleDate)
					end
				else
					begin
						set @AlertDate=null
					end
				update uTradePartnerCompliance set ScheduleDate=@ScheduleDate, AlertDate=@AlertDate
				where TradePartnerComplianceId=@TradePartnerComplianceId and
				TradePartnerId=@TradePartnerId
			end	
		else
			begin
				update uTradePartnerCompliance set ScheduleDate=null, AlertDate=null
				where TradePartnerComplianceId=@TradePartnerComplianceId and
				TradePartnerId=@TradePartnerId
			end
	end



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03993', GetDate())
GO
