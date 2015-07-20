/****** Object:  View [dbo].[vwx_VendorEquipment_SEL]    Script Date: 09/27/2012 16:28:20 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_VendorEquipment_SEL]'))
DROP VIEW [dbo].[vwx_VendorEquipment_SEL]
GO

/****** Object:  View [dbo].[vwx_VendorEquipment_SEL]    Script Date: 09/27/2012 16:28:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[vwx_VendorEquipment_SEL]
AS
SELECT     uTradePartnerEquipment.TradePartnerEquipmentId as TradePartnerEquipmentId, uTradePartnerEquipment.TradePartnerId, uTradePartnerEquipment.MachineId as MachineId, 
uTradePartnerEquipment.MachineCode, uTradePartnerEquipment.MachineName, uTradePartnerEquipment.MachineDesc, uTradePartnerEquipment.ImageID ,  
uTradePartnerEquipment.MachineClassID, uTradePartnerEquipment.MachineTypeID,
pNBOLMachineClass.MachineClassName,  pNBOLMachineType.MachineTypeName,
uTradePartnerEquipment.CustomField1, uTradePartnerEquipment.Active, uTradePartnerEquipment.Muser, uTradePartnerEquipment.Mdate
FROM  uTradePartnerEquipment 
Left JOIN
pNBOLMachinery ON pNBOLMachinery.MachineID = uTradePartnerEquipment.MachineId left JOIN
pNBOLMachineClass ON uTradePartnerEquipment.MachineClassID = pNBOLMachineClass.MachineClassID left JOIN
pNBOLMachineType ON uTradePartnerEquipment.MachineTypeID = pNBOLMachineType.MachineTypeID
UNION 
SELECT     '00000000-0000-0000-0000-000000000000' as TradePartnerEquipmentId, TradePartnerId,  '00000000-0000-0000-0000-000000000000' as MachineId, 
'' as MachineCode,  '' as MachineName, '' as MachineDesc, '00000000-0000-0000-0000-000000000000' as ImageID ,  
'00000000-0000-0000-0000-000000000000' as MachineClassID, '00000000-0000-0000-0000-000000000000' as MachineTypeID,
'' as MachineClassName, '' as MachineTypeName,
'' as CustomField1, 1, '' as Muser, null as Mdate
FROM  uTradePartnerEquipment 

GO
 
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04012', GetDate())
GO


