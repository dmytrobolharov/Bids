IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_NBOL_Macro_SEL]'))
DROP VIEW [dbo].[vwx_NBOL_Macro_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_NBOL_Macro_SEL]
AS
SELECT     MacroID, MacroCode, MacroName, ImageID, Comments, CDate, CUser, MUser, MDate, Active, CustomField1, CustomField2, CustomField3, CustomField4, 
                      CustomField5, '<img src=''../System/Control/ImageStream.ashx?IT=BOLMOP&S=50&ID=' + CAST(ISNULL(ImageID, '00000000-0000-0000-0000-000000000000') 
                      AS NVARCHAR(50)) + ''' />' AS Image
FROM         dbo.pNBOLMacro

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03523', GetDate())
GO