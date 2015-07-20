IF OBJECT_ID(N'[dbo].[vw_pBOLMacro_Select]') IS NOT NULL
 DROP VIEW [dbo].[vw_pBOLMacro_Select]
GO

CREATE VIEW [dbo].[vw_pBOLMacro_Select]
AS
SELECT MacroId, MacroName, MacroCode, Comments, Approved, CDate, CUser, MUser, MDate, Active, CategoryId, 
       dbo.fnx_GetStreamingTypedImageHTML('BOLOP', Image, 50, '') AS Image
FROM dbo.pBOLMacro


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10306', GetUTCDate())
GO
