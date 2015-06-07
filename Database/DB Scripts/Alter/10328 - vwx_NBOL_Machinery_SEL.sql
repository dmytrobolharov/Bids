IF OBJECT_ID(N'[dbo].[vwx_NBOL_Machinery_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_NBOL_Machinery_SEL]
GO

CREATE VIEW [dbo].[vwx_NBOL_Machinery_SEL]
AS
SELECT MachineCode, MachineName, MachineDesc, MachineTypeID, CustomField1, CustomField2, CustomField3, CustomField4, 
       CustomField5, CUser, CDate, MUser, MDate, Active, MachineID, MachineClassID, 
	   dbo.fnx_GetStreamingTypedImageHTML('BOLM', ImageID, 50, '') AS Image
FROM dbo.pNBOLMachinery


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10328', GetUTCDate())
GO
