IF OBJECT_ID(N'[dbo].[vwx_NBOL_Template_OpAndMacro_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_NBOL_Template_OpAndMacro_SEL]
GO

CREATE VIEW [dbo].[vwx_NBOL_Template_OpAndMacro_SEL]
AS
SELECT ti.TemplateItemID, ti.TemplateID, ti.MacroID, ti.OperationID, ti.Code, ti.Name, 
	   ti.MachineID, ti.OperationTypeID, ti.BaseRate, ti.SAM, ti.ParentID, ti.Sort, ti.Sort2, 
       ti.CUser, ti.CDate, ti.MUser, ti.MDate, ti.Active,
       CASE WHEN ti.MacroID IS NOT NULL 
	    THEN dbo.fnx_GetStreamingTypedImageHTML('BOLMOP', m.ImageID, 50, '')
		ELSE dbo.fnx_GetStreamingTypedImageHTML('BOLOP', o.ImageID, 50, '')
	   END AS [Image]
FROM dbo.pNBOLTemplateItem ti 
LEFT JOIN dbo.pNBOLOperation o ON ti.OperationID = o.OperationID 
LEFT JOIN dbo.pNBOLMacro m ON ti.MacroID = m.MacroID
WHERE ti.ParentID IS NULL

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10332', GetUTCDate())
GO
