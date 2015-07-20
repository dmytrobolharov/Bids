IF OBJECT_ID(N'[dbo].[vw_pBOLMacro_Operations]') IS NOT NULL
 DROP VIEW [dbo].[vw_pBOLMacro_Operations]
GO

CREATE VIEW [dbo].[vw_pBOLMacro_Operations]
AS
SELECT dbo.pBOLOpToMacro.OpToMacroId, dbo.pBOLOpToMacro.MacroId, dbo.pBOLOperations.OperationCode, dbo.pBOLOperations.OperationName, 
       dbo.pBOLOperations.CUser AS OpCUser, dbo.pBOLOperations.CDate AS OpCDate, dbo.pBOLOperations.MUser AS OpMUser, 
       dbo.pBOLOperations.MDate AS OpMDate, dbo.pBOLOperations.Active AS OpActive, dbo.pBOLOperations.CategoryId, dbo.pBOLOpToMacro.OperationId, 
       dbo.pBOLOperations.Image, dbo.pBOLOperations.MachineId, dbo.pBOLOperations.BaseRateId, dbo.pBOLOperations.SAM, dbo.pBOLOpToMacro.CUser, 
       dbo.pBOLOpToMacro.CDate, dbo.pBOLOpToMacro.MUser, dbo.pBOLOpToMacro.MDate, dbo.pBOLOpToMacro.Active, 
       dbo.fnx_GetStreamingTypedImageHTML('BOLOP', dbo.pBOLOperations.Image, 50, '') AS OperationImage, dbo.pBOLOpToMacro.Sort
FROM dbo.pBOLOpToMacro 
INNER JOIN dbo.pBOLOperations ON dbo.pBOLOpToMacro.OperationId = dbo.pBOLOperations.OperationId


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10305', GetUTCDate())
GO
