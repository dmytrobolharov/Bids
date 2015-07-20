IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_pBOLTemplates_Select]'))
DROP VIEW [dbo].[vw_pBOLTemplates_Select]
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[vw_pBOLTemplates_Select]
AS
SELECT     TemplateId, TemplateCode, TemplateName, Comments, Approved, CUser, CDate, MUser, MDate, Active, CategoryId, 
                      '<img src=''../System/Control/ImageStream.ashx?IT=BOLT&S=50&ID=' + CAST(ISNULL(Image, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
                      + ''' />' AS Image
FROM         dbo.pBOLTemplates

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01739'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01739', GetDate())
END	
GO