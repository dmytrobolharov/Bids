/****** Object:  StoredProcedure [dbo].[spx_VendorTradePartnerEquipment_Add]    Script Date: 09/18/2012 11:10:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_VendorTradePartnerEquipment_Add]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_VendorTradePartnerEquipment_Add]
GO

/****** Object:  StoredProcedure [dbo].[spx_VendorTradePartnerEquipment_Add]    Script Date: 09/18/2012 11:10:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spx_VendorTradePartnerEquipment_Add]
(
@MachineId uniqueidentifier,
@TradePartnerId uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
as

IF (SELECT COUNT(MachineId) FROM uTradePartnerEquipment WITH (NOLOCK) 
WHERE MachineId = @MachineId AND TradePartnerId = @TradePartnerId ) = 0
	BEGIN
		 INSERT INTO uTradePartnerEquipment
        		 (MachineId, TradePartnerId, Active, CUser, CDate, MUser, MDate)
		VALUES (@MachineId, @TradePartnerId, 1,  @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)
	END

GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03897', GetDate())
GO
