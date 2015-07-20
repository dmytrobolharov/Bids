/****** Object:  StoredProcedure [dbo].[spx_VendorTradePartnerEquipment_Del]    Script Date: 09/18/2012 11:11:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_VendorTradePartnerEquipment_Del]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_VendorTradePartnerEquipment_Del]
GO

/****** Object:  StoredProcedure [dbo].[spx_VendorTradePartnerEquipment_Del]    Script Date: 09/18/2012 11:11:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spx_VendorTradePartnerEquipment_Del]
	@TradePartnerEquipmentId UNIQUEIDENTIFIER
AS
BEGIN		
	DELETE FROM uTradePartnerEquipment WHERE TradePartnerEquipmentId = @TradePartnerEquipmentId
END


GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03898', GetDate())
GO
