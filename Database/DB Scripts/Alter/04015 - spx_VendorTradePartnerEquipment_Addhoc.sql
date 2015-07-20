
/****** Object:  StoredProcedure [dbo].[spx_VendorTradePartnerEquipment_Addhoc]    Script Date: 09/27/2012 18:46:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_VendorTradePartnerEquipment_Addhoc]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_VendorTradePartnerEquipment_Addhoc]
GO


/****** Object:  StoredProcedure [dbo].[spx_VendorTradePartnerEquipment_Addhoc]    Script Date: 09/27/2012 18:46:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_VendorTradePartnerEquipment_Addhoc]
(@TradePartnerId uniqueidentifier,
@MachineClassId uniqueidentifier,
@MachineCode nvarchar(200),
@CUser nvarchar(200),
@CDate datetime
)
as


	BEGIN
		 INSERT INTO uTradePartnerEquipment
        		 (MachineId, TradePartnerId, MachineClassID, MachineTypeID,
        		 ImageId, Active, Sort, IsLinked, MachineCode, CUser, CDate, MUser, MDate)        		 
        		 values('00000000-0000-0000-0000-000000000000', @TradePartnerId, 
        		 @MachineClassId, '00000000-0000-0000-0000-000000000000',
        		 '00000000-0000-0000-0000-000000000000', 1, 0, 0, @MachineCode,
        		 @CUser, @CDate, @CUser, @CDate)
        		 
        		 	
	END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04015', GetDate())
GO
