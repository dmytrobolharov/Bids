IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_NBOL_Template_SEL]'))
DROP VIEW [dbo].[vwx_NBOL_Template_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_NBOL_Template_SEL]
AS
SELECT     TemplateID, TemplateCode, TemplateName, ImageID, Comments, CUser, CDate, MUser, MDate, Active, 
                      '<img src=''../System/Control/ImageStream.ashx?IT=BOLT&S=50&ID=' + CAST(ISNULL(ImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
                      + ''' />' AS Image
FROM         dbo.pNBOLTemplate

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03525', GetDate())
GO