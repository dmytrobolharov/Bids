IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_NBOL_Template_OpAndMacro_SEL]'))
DROP VIEW [dbo].[vwx_NBOL_Template_OpAndMacro_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_NBOL_Template_OpAndMacro_SEL]
AS
SELECT     TemplateItemID, TemplateID, MacroID, OperationID, ImageID, Code, Name, MachineID, OperationTypeID, BaseRate, SAM, ParentID, Sort, Sort2, CUser, CDate, MUser, 
                      MDate, Active
FROM         dbo.pNBOLTemplateItem
WHERE     (ParentID IS NULL)

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03526', GetDate())
GO