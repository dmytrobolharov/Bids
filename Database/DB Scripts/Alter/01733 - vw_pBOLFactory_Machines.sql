IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_pBOLFactory_Machines]'))
DROP VIEW [dbo].[vw_pBOLFactory_Machines]
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [dbo].[vw_pBOLFactory_Machines]
AS
SELECT     dbo.pBOLFactoryMachines.FactoryMachinesId, dbo.pBOLFactoryMachines.FactoryId, dbo.pBOLFactoryMachines.MachineId, dbo.pBOLFactoryMachines.CUser, 
                      dbo.pBOLFactoryMachines.CDate, dbo.pBOLFactoryMachines.MUser, dbo.pBOLFactoryMachines.MDate, dbo.pBOLFactoryMachines.Active, 
                      dbo.pBOLMachines.MachineCode, dbo.pBOLMachines.MachineName, 
                      '<img src=''../System/Control/ImageStream.ashx?IT=BOLM&S=50&ID=' + CAST(ISNULL(dbo.pBOLMachines.Image, '00000000-0000-0000-0000-000000000000') 
                      AS NVARCHAR(50)) + ''' />' AS Image
FROM         dbo.pBOLFactoryMachines INNER JOIN
                      dbo.pBOLMachines ON dbo.pBOLFactoryMachines.MachineId = dbo.pBOLMachines.MachineId

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01733'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01733', GetDate())
END	
GO