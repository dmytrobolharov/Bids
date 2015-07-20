/****** Object:  View [dbo].[vwx_VendorEquipment_SEL]    Script Date: 09/18/2012 11:00:48 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_VendorEquipment_SEL]'))
DROP VIEW [dbo].[vwx_VendorEquipment_SEL]
GO

/****** Object:  View [dbo].[vwx_VendorEquipment_SEL]    Script Date: 09/18/2012 11:00:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_VendorEquipment_SEL]
AS
SELECT     uTradePartnerEquipment.TradePartnerEquipmentId, uTradePartnerEquipment.TradePartnerId, uTradePartnerEquipment.MachineId, pNBOLMachinery.MachineCode, 
                      pNBOLMachinery.MachineName, pNBOLMachinery.MachineDesc, pNBOLMachinery.ImageID , pNBOLMachineClass.MachineClassCode, 
                      pNBOLMachineClass.MachineClassName, pNBOLMachineType.MachineTypeCode, pNBOLMachineType.MachineTypeName, uTradePartnerEquipment.CustomField1, 
                      pNBOLMachinery.Active, pNBOLMachinery.MachineClassID, pNBOLMachinery.MachineTypeID,
                      uTradePartnerEquipment.Muser, uTradePartnerEquipment.Mdate
FROM         uTradePartnerEquipment INNER JOIN
                      pNBOLMachinery ON pNBOLMachinery.MachineID = uTradePartnerEquipment.MachineId INNER JOIN
                      pNBOLMachineClass ON pNBOLMachineClass.MachineClassID = pNBOLMachinery.MachineClassID INNER JOIN
                      pNBOLMachineType ON pNBOLMachinery.MachineTypeID = pNBOLMachineType.MachineTypeID
WHERE     (pNBOLMachinery.Active = 1)


Go


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03899', GetDate())
GO
