IF OBJECT_ID(N'[dbo].[vw_pBOLTemplates_Select]') IS NOT NULL
 DROP VIEW [dbo].[vw_pBOLTemplates_Select]
GO

CREATE VIEW [dbo].[vw_pBOLTemplates_Select]
AS
SELECT TemplateId, TemplateCode, TemplateName, Comments, Approved, CUser, CDate, MUser, MDate, Active, CategoryId, 
       dbo.fnx_GetStreamingTypedImageHTML('BOLT', Image, 50, '') AS Image
FROM dbo.pBOLTemplates


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10308', GetUTCDate())
GO
