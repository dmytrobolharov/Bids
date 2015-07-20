IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_pBOLMacro_Operations]'))
DROP VIEW [dbo].[vw_pBOLMacro_Operations]
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[vw_pBOLMacro_Operations]
AS
SELECT     dbo.pBOLOpToMacro.OpToMacroId, dbo.pBOLOpToMacro.MacroId, dbo.pBOLOperations.OperationCode, dbo.pBOLOperations.OperationName, 
                      dbo.pBOLOperations.CUser, dbo.pBOLOperations.CDate, dbo.pBOLOperations.MUser, dbo.pBOLOperations.MDate, dbo.pBOLOperations.Active, 
                      dbo.pBOLOperations.CategoryId, dbo.pBOLOpToMacro.OperationId, dbo.pBOLOperations.Image, dbo.pBOLOperations.MachineId, dbo.pBOLOperations.BaseRateId, 
                      dbo.pBOLOperations.SAM, dbo.pBOLOpToMacro.CUser AS OpToMacro_CUser, dbo.pBOLOpToMacro.CDate AS OpToMacro_CDate, 
                      dbo.pBOLOpToMacro.MUser AS OpToMacro_MUser, dbo.pBOLOpToMacro.MDate AS OpToMacro_MDate, 
                      '<img src=''../System/Control/ImageStream.ashx?IT=BOLOP&S=50&ID=' + CAST(ISNULL(dbo.pBOLOperations.Image, '00000000-0000-0000-0000-000000000000') 
                      AS NVARCHAR(50)) + ''' />' AS OperationImage, dbo.pBOLOpToMacro.Sort
FROM         dbo.pBOLOpToMacro INNER JOIN
                      dbo.pBOLOperations ON dbo.pBOLOpToMacro.OperationId = dbo.pBOLOperations.OperationId

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01735'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01735', GetDate())
END	
GO