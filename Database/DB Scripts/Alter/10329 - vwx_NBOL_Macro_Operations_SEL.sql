IF OBJECT_ID(N'[dbo].[vwx_NBOL_Macro_Operations_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_NBOL_Macro_Operations_SEL]
GO

CREATE VIEW [dbo].[vwx_NBOL_Macro_Operations_SEL]
AS
SELECT nbo.OperationCode, nbo.OperationName, nbom.MacroID, nbom.OperationID, nbom.OpToMacroID, 
       nbom.CUser, nbom.CDate, nbom.MUser, nbom.MDate, nbom.Active, nbom.Sort, nbo.MachineID, 
	   nbo.ImageID, nbo.Category, nbo.CUser AS OpCUser, nbo.CDate AS OpCDate, nbo.MUser AS OpMUser, 
       nbo.MDate AS OpMDate, nbo.Active AS OpActive, 
       dbo.fnx_GetStreamingTypedImageHTML('BOLOP', nbo.ImageID, 50, '') AS OperationImage
FROM dbo.pNBOLOpToMacro nbom
INNER JOIN dbo.pNBOLOperation nbo ON nbom.OperationID = nbo.OperationID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10329', GetUTCDate())
GO
