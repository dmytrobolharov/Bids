IF OBJECT_ID(N'[dbo].[vw_pBOLMachines_Select]') IS NOT NULL
 DROP VIEW [dbo].[vw_pBOLMachines_Select]
GO

CREATE VIEW [dbo].[vw_pBOLMachines_Select]
AS
SELECT MachineCode, MachineName, MachineDesc, MachineTypeId, Custom1, Custom2, Custom3, Custom4, CUser, Custom5, 
       CDate, MUser, MDate, Active, MachineId, dbo.fnx_GetStreamingTypedImageHTML('BOLM', Image, 50, '') AS Image
FROM dbo.pBOLMachines


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10304', GetUTCDate())
GO
