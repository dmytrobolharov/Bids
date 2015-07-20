
/****** Object:  StoredProcedure [dbo].[spx_VendorTradePartnerEquipment_Add]    Script Date: 09/27/2012 18:44:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_VendorTradePartnerEquipment_Add]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_VendorTradePartnerEquipment_Add]
GO

/****** Object:  StoredProcedure [dbo].[spx_VendorTradePartnerEquipment_Add]    Script Date: 09/27/2012 18:44:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_VendorTradePartnerEquipment_Add]
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
        		 (MachineId, TradePartnerId, MachineCode, MachineName, MachineDesc, MachineClassID, MachineTypeID,     
        		 ImageId, Active, Sort, IsLinked, CUser, CDate, MUser, MDate)        		 
        		 select @MachineId, @TradePartnerId, MachineCode, MachineName, MachineDesc, pNBOLMachinery.MachineClassID, pNBOLMachinery.MachineTypeID,
        		 ImageId, 1, 0, 1, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate
        		 from pNBOLMachinery inner join pNBOLMachineClass 
        		 ON pNBOLMachinery.MachineClassID = pNBOLMachineClass.MachineClassID 
        		 inner JOIN   pNBOLMachineType ON pNBOLMachinery.MachineTypeID = pNBOLMachineType.MachineTypeID
        		 where pNBOLMachinery.MachineId=@MachineId		
	END


GO


GO
 
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04014', GetDate())
GO