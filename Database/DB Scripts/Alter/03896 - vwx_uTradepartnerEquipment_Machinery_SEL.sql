
/****** Object:  View [dbo].[vwx_uTradepartnerEquipment_Machinery_SEL]    Script Date: 09/18/2012 11:02:15 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_uTradepartnerEquipment_Machinery_SEL]'))
DROP VIEW [dbo].[vwx_uTradepartnerEquipment_Machinery_SEL]
GO

/****** Object:  View [dbo].[vwx_uTradepartnerEquipment_Machinery_SEL]    Script Date: 09/18/2012 11:02:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_uTradepartnerEquipment_Machinery_SEL]
AS
SELECT pNBOLMachinery.MachineID, pNBOLMachinery.MachineCode, 
                      pNBOLMachinery.MachineName, pNBOLMachinery.MachineDesc, pNBOLMachinery.ImageID, pNBOLMachineClass.MachineClassCode, 
                      pNBOLMachineClass.MachineClassName, pNBOLMachineType.MachineTypeCode, pNBOLMachineType.MachineTypeName, pNBOLMachinery.CustomField1, 
                      pNBOLMachinery.Active, pNBOLMachinery.MachineClassID, pNBOLMachinery.MachineTypeID,pNBOLMachinery.MUser, pNBOLMachinery.MDate
FROM      pNBOLMachinery INNER JOIN
                      pNBOLMachineClass ON pNBOLMachinery.MachineClassID = pNBOLMachineClass.MachineClassID INNER JOIN
                      pNBOLMachineType ON pNBOLMachinery.MachineTypeID = pNBOLMachineType.MachineTypeID
WHERE     (pNBOLMachinery.Active = 1)

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03896', GetDate())
GO
