IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_NBOL_TemplateItem_SEL]'))
DROP VIEW [dbo].[vwx_NBOL_TemplateItem_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[vwx_NBOL_TemplateItem_SEL]
AS
SELECT     TemplateItemID, TemplateID, MacroID, OperationID, ImageID, Code, MachineID, Name, OperationTypeID,  
			CASE WHEN OperationID IS NOT NULL THEN SAM
			ELSE (SELECT SUM(ti.SAM) FROM pNBOLTemplateItem ti WHERE ti.ParentID = dbo.pNBOLTemplateItem.TemplateItemID)
			END SAM, 
			CASE WHEN OperationID IS NOT NULL THEN BaseRate
			ELSE (SELECT SUM(ti.BaseRate) FROM pNBOLTemplateItem ti WHERE ti.ParentID = dbo.pNBOLTemplateItem.TemplateItemID)
			END BaseRate, 
			ParentID, Sort, Sort2, CUser, CDate, MUser, 
            MDate, Active, '<img src=''../System/Control/ImageStream.ashx?IT=' + CASE WHEN MacroID IS NULL THEN 'BOLOP' ELSE 'BOLMOP' END + '&S=40&ID=' + CAST(ISNULL(ImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS [Image]
FROM       dbo.pNBOLTemplateItem
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04602', GetDate())
GO
