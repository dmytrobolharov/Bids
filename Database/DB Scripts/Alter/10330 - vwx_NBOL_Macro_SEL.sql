IF OBJECT_ID(N'[dbo].[vwx_NBOL_Macro_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_NBOL_Macro_SEL]
GO

CREATE VIEW [dbo].[vwx_NBOL_Macro_SEL]
AS
SELECT MacroID, MacroCode, MacroName, ImageID, Comments, CDate, CUser, MUser, MDate, Active, 
       CustomField1, CustomField2, CustomField3, CustomField4, CustomField5, 
	   dbo.fnx_GetStreamingTypedImageHTML('BOLMOP', ImageID, 50, '') AS Image
FROM dbo.pNBOLMacro


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10330', GetUTCDate())
GO
