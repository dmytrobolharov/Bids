IF OBJECT_ID(N'[dbo].[vwx_NBOL_Template_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_NBOL_Template_SEL]
GO

CREATE VIEW [dbo].[vwx_NBOL_Template_SEL]
AS
SELECT TemplateID, TemplateCode, TemplateName, ImageID, Comments, CUser, CDate, MUser, MDate, Active, 
       dbo.fnx_GetStreamingTypedImageHTML('BOLT', ImageID, 50, '') AS Image
FROM dbo.pNBOLTemplate


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10333', GetUTCDate())
GO
