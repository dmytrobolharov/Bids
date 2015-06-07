IF OBJECT_ID(N'[dbo].[vwx_NBOL_TemplateItem_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_NBOL_TemplateItem_SEL]
GO

CREATE VIEW [dbo].[vwx_NBOL_TemplateItem_SEL]
AS
SELECT     TemplateItemID, TemplateID, ti.MacroID, ti.OperationID, 
			CASE WHEN ti.MacroID IS NULL THEN o.ImageID ELSE m.ImageID END as ImageID,
			Code, ti.MachineID, Name, ti.OperationTypeID,  
			CASE WHEN ti.MacroID IS NOT NULL THEN (SELECT SUM(ti.SAM) FROM pNBOLTemplateItem ti WHERE ti.ParentID = ti.TemplateItemID)
			ELSE SAM
			END as SAM, 
			CASE WHEN ti.MacroID IS NOT NULL THEN (SELECT SUM(ti.BaseRate) FROM pNBOLTemplateItem ti WHERE ti.ParentID = ti.TemplateItemID) 
			ELSE BaseRate
			END BaseRate, 
			ParentID, Sort, Sort2, ti.CUser, ti.CDate, ti.MUser, 
            ti.MDate, ti.Active, 
			dbo.fnx_GetStreamingTypedImageHTML(CASE WHEN ti.MacroID IS NULL THEN 'BOLOP' ELSE 'BOLMOP' END, 
			                                   CASE WHEN ti.MacroID IS NULL THEN o.ImageID ELSE m.ImageID END, 40, '') AS [Image],
            ti.CurrencyType
FROM       dbo.pNBOLTemplateItem ti
LEFT JOIN dbo.pNBOLOperation o ON o.OperationID = ti.OperationID
LEFT JOIN dbo.pNBOLMacro m ON m.MacroID = ti.MacroID


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10334', GetUTCDate())
GO
