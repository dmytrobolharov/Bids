IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_pBOLTemplate_OpAndMacro]'))
DROP VIEW [dbo].[vw_pBOLTemplate_OpAndMacro]
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[vw_pBOLTemplate_OpAndMacro]
AS
SELECT     dbo.pBOLTemplateEntries.TemplateEntryId, dbo.pBOLTemplateEntries.TemplateId, dbo.pBOLTemplateEntries.OperationId, dbo.pBOLTemplateEntries.MacroId, 
                      dbo.pBOLTemplateEntries.CUser, dbo.pBOLTemplateEntries.CDate, dbo.pBOLTemplateEntries.MUser, dbo.pBOLTemplateEntries.MDate, 
                      dbo.pBOLTemplateEntries.Active, dbo.pBOLTemplateEntries.Sort, dbo.pBOLMacro.MacroCode, dbo.pBOLMacro.MacroName, dbo.pBOLOperations.OperationCode, 
                      dbo.pBOLOperations.OperationName, dbo.pBOLOperations.BaseRateId, dbo.pBOLOperations.SAM, dbo.pBOLOperations.MachineId, 
                      ISNULL(dbo.pBOLOperations.OperationCode, dbo.pBOLMacro.MacroCode) AS Code, ISNULL(dbo.pBOLOperations.OperationName, dbo.pBOLMacro.MacroName) 
                      AS Name, ISNULL(dbo.pBOLOperations.CUser, dbo.pBOLMacro.CUser) AS OpM_CUser, ISNULL(dbo.pBOLOperations.CDate, dbo.pBOLMacro.CDate) AS OpM_CDate, 
                      ISNULL(dbo.pBOLOperations.MUser, dbo.pBOLMacro.MUser) AS OpM_MUser, ISNULL(dbo.pBOLOperations.MDate, dbo.pBOLMacro.MDate) AS OpM_MDate, 
                      ISNULL(dbo.vw_pBOLMacro_Select.Image, dbo.vw_pBOLOperations_Select.Image) AS Image
FROM         dbo.vw_pBOLOperations_Select INNER JOIN
                      dbo.pBOLOperations ON dbo.vw_pBOLOperations_Select.OperationId = dbo.pBOLOperations.OperationId RIGHT OUTER JOIN
                      dbo.vw_pBOLMacro_Select INNER JOIN
                      dbo.pBOLMacro ON dbo.vw_pBOLMacro_Select.MacroId = dbo.pBOLMacro.MacroId RIGHT OUTER JOIN
                      dbo.pBOLTemplateEntries ON dbo.pBOLMacro.MacroId = dbo.pBOLTemplateEntries.MacroId ON 
                      dbo.pBOLOperations.OperationId = dbo.pBOLTemplateEntries.OperationId

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01738'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01738', GetDate())
END	
GO