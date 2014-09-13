IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TACalTemplate_DropDownDivisions_SEL]'))
DROP VIEW [dbo].[vwx_TACalTemplate_DropDownDivisions_SEL]
GO

CREATE VIEW [dbo].[vwx_TACalTemplate_DropDownDivisions_SEL]
AS

SELECT CustomID AS DivisionID, Custom AS DivisionName, cal.TACalTemplateID, 
	CASE WHEN cald.TACalTemplateDivisionID IS NOT NULL THEN 'True' ELSE 'False' END AS IsChecked
FROM iCustom1 d
CROSS JOIN pTACalTemplate cal
LEFT JOIN pTACalTemplateDivision cald ON d.CustomID = cald.DivisionID 
	AND cal.TACalTemplateId = cald.TACalTemplateID
WHERE d.Active = 1


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08770', GetDate())
GO
