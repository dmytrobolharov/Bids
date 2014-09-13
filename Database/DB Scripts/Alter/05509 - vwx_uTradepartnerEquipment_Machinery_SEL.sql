/****** Object:  View [dbo].[vwx_uTradepartnerEquipment_Machinery_SEL]    Script Date: 04/09/2013 10:29:23 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_uTradepartnerEquipment_Machinery_SEL]'))
DROP VIEW [dbo].[vwx_uTradepartnerEquipment_Machinery_SEL]
GO

/****** Object:  View [dbo].[vwx_uTradepartnerEquipment_Machinery_SEL]    Script Date: 04/09/2013 10:29:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_uTradepartnerEquipment_Machinery_SEL]
AS
SELECT     dbo.pNBOLMachinery.MachineID, dbo.pNBOLMachinery.MachineCode, dbo.pNBOLMachinery.MachineName, dbo.pNBOLMachinery.MachineDesc, 
                      dbo.pNBOLMachinery.ImageID, dbo.pNBOLMachineClass.MachineClassCode, dbo.pNBOLMachineClass.MachineClassName, 
                      dbo.pNBOLMachineType.MachineTypeCode, dbo.pNBOLMachineType.MachineTypeName, dbo.pNBOLMachinery.CustomField1, dbo.pNBOLMachinery.Active, 
                      dbo.pNBOLMachinery.MachineClassID, dbo.pNBOLMachinery.MachineTypeID, dbo.pNBOLMachinery.MUser, dbo.pNBOLMachinery.MDate
FROM         dbo.pNBOLMachinery INNER JOIN
                      dbo.pNBOLMachineClass ON dbo.pNBOLMachinery.MachineClassID = dbo.pNBOLMachineClass.MachineClassID INNER JOIN
                      dbo.pNBOLMachineType ON dbo.pNBOLMachinery.MachineTypeID = dbo.pNBOLMachineType.MachineTypeID
WHERE     (dbo.pNBOLMachinery.Active = 1) AND (dbo.pNBOLMachineClass.Active = 1)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '05509', GetDate())
GO
