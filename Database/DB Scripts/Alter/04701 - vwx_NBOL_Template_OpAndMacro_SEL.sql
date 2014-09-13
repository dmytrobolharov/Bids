IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_NBOL_Template_OpAndMacro_SEL]'))
DROP VIEW [dbo].[vwx_NBOL_Template_OpAndMacro_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vwx_NBOL_Template_OpAndMacro_SEL]
AS
SELECT     ti.TemplateItemID, ti.TemplateID, ti.MacroID, ti.OperationID, ti.Code, ti.Name, 
		ti.MachineID, ti.OperationTypeID, ti.BaseRate, ti.SAM, ti.ParentID, ti.Sort, ti.Sort2, 
		ti.CUser, ti.CDate, ti.MUser, ti.MDate, ti.Active,
		CASE WHEN ti.MacroID IS NOT NULL THEN
			'<img src=''../System/Control/ImageStream.ashx?IT=BOLMOP&S=50&ID=' + CAST(ISNULL(dbo.pNBOLMacro.ImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' 
			ELSE '<img src=''../System/Control/ImageStream.ashx?IT=BOLOP&S=50&ID=' + CAST(ISNULL(dbo.pNBOLOperation.ImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' 
		END as [Image]
FROM  dbo.pNBOLTemplateItem ti LEFT JOIN
		dbo.pNBOLOperation ON ti.OperationID = dbo.pNBOLOperation.OperationID LEFT JOIN
		dbo.pNBOLMacro ON ti.MacroID = dbo.pNBOLMacro.MacroID
WHERE ti.ParentID IS NULL
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04701', GetDate())
GO
