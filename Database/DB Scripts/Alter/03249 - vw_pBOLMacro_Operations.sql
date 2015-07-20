IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_pBOLMacro_Operations]'))
DROP VIEW [dbo].[vw_pBOLMacro_Operations]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_pBOLMacro_Operations]
AS
SELECT     dbo.pBOLOpToMacro.OpToMacroId, dbo.pBOLOpToMacro.MacroId, dbo.pBOLOperations.OperationCode, dbo.pBOLOperations.OperationName, 
                      dbo.pBOLOperations.CUser AS OpCUser, dbo.pBOLOperations.CDate AS OpCDate, dbo.pBOLOperations.MUser AS OpMUser, 
                      dbo.pBOLOperations.MDate AS OpMDate, dbo.pBOLOperations.Active AS OpActive, dbo.pBOLOperations.CategoryId, dbo.pBOLOpToMacro.OperationId, 
                      dbo.pBOLOperations.Image, dbo.pBOLOperations.MachineId, dbo.pBOLOperations.BaseRateId, dbo.pBOLOperations.SAM, dbo.pBOLOpToMacro.CUser, 
                      dbo.pBOLOpToMacro.CDate, dbo.pBOLOpToMacro.MUser, dbo.pBOLOpToMacro.MDate, dbo.pBOLOpToMacro.Active, 
                      '<img src=''../System/Control/ImageStream.ashx?IT=BOLOP&S=50&ID=' + CAST(ISNULL(dbo.pBOLOperations.Image, '00000000-0000-0000-0000-000000000000') 
                      AS NVARCHAR(50)) + ''' />' AS OperationImage, dbo.pBOLOpToMacro.Sort
FROM         dbo.pBOLOpToMacro INNER JOIN
                      dbo.pBOLOperations ON dbo.pBOLOpToMacro.OperationId = dbo.pBOLOperations.OperationId

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03249'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03249', GetDate())

END
GO