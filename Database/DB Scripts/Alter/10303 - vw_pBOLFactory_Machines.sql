IF OBJECT_ID(N'[dbo].[vw_pBOLFactory_Machines]') IS NOT NULL
 DROP VIEW [dbo].[vw_pBOLFactory_Machines]
GO

CREATE VIEW [dbo].[vw_pBOLFactory_Machines]
AS
SELECT dbo.pBOLFactoryMachines.FactoryMachinesId, dbo.pBOLFactoryMachines.FactoryId, dbo.pBOLFactoryMachines.MachineId, dbo.pBOLFactoryMachines.CUser, 
                      dbo.pBOLFactoryMachines.CDate, dbo.pBOLFactoryMachines.MUser, dbo.pBOLFactoryMachines.MDate, dbo.pBOLFactoryMachines.Active AS IsActive, 
                      dbo.pBOLMachines.MachineCode, dbo.pBOLMachines.MachineName, 
                      dbo.fnx_GetStreamingTypedImageHTML('BOLM', dbo.pBOLMachines.Image, 50, '') AS Image, 
					  dbo.pBOLFactoryMachines.TradePartnerVendorID
FROM dbo.pBOLFactoryMachines 
INNER JOIN dbo.pBOLMachines ON dbo.pBOLFactoryMachines.MachineId = dbo.pBOLMachines.MachineId


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10303', GetUTCDate())
GO
