IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_NBOL_TemplateItem_SEL]'))
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
            ti.MDate, ti.Active, '<img src=''../System/Control/ImageStream.ashx?IT=' + CASE WHEN ti.MacroID IS NULL THEN 'BOLOP' ELSE 'BOLMOP' END + '&S=40&ID=' + CAST(ISNULL(CASE WHEN ti.MacroID IS NULL THEN o.ImageID ELSE m.ImageID END, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS [Image],
            ti.CurrencyType
FROM       dbo.pNBOLTemplateItem ti
LEFT JOIN dbo.pNBOLOperation o ON o.OperationID = ti.OperationID
LEFT JOIN dbo.pNBOLMacro m ON m.MacroID = ti.MacroID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06994', GetDate())
GO
