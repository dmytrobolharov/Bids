IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_NBOL_Macro_Operations_SEL]'))
DROP VIEW [dbo].[vwx_NBOL_Macro_Operations_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_NBOL_Macro_Operations_SEL]
AS
SELECT     dbo.pNBOLOperation.OperationCode, dbo.pNBOLOperation.OperationName, dbo.pNBOLOpToMacro.MacroID, dbo.pNBOLOpToMacro.OperationID, 
                      dbo.pNBOLOpToMacro.OpToMacroID, dbo.pNBOLOpToMacro.CUser, dbo.pNBOLOpToMacro.CDate, dbo.pNBOLOpToMacro.MUser, dbo.pNBOLOpToMacro.MDate, 
                      dbo.pNBOLOpToMacro.Active, dbo.pNBOLOpToMacro.Sort, dbo.pNBOLOperation.MachineID, dbo.pNBOLOperation.ImageID, dbo.pNBOLOperation.Category, 
                      dbo.pNBOLOperation.CUser AS OpCUser, dbo.pNBOLOperation.CDate AS OpCDate, dbo.pNBOLOperation.MUser AS OpMUser, 
                      dbo.pNBOLOperation.MDate AS OpMDate, dbo.pNBOLOperation.Active AS OpActive, 
                      '<img src=''../System/Control/ImageStream.ashx?IT=BOLOP&S=50&ID=' + CAST(ISNULL(dbo.pNBOLOperation.ImageID, '00000000-0000-0000-0000-000000000000') 
                      AS NVARCHAR(50)) + ''' />' AS OperationImage
FROM         dbo.pNBOLOpToMacro INNER JOIN
                      dbo.pNBOLOperation ON dbo.pNBOLOpToMacro.OperationID = dbo.pNBOLOperation.OperationID

GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03524', GetDate())
GO