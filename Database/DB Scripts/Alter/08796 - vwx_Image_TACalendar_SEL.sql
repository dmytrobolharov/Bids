IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Image_TACalendar_SEL]'))
DROP VIEW [dbo].[vwx_Image_TACalendar_SEL]
GO

CREATE VIEW [dbo].[vwx_Image_TACalendar_SEL]
AS
SELECT DISTINCT dbo.pTACalTemplate.TACalTemplateId, dbo.pTACalTemplate.TACalTemplateName, dbo.pImage.ImageID FROM         
dbo.pImage LEFT OUTER JOIN
dbo.pTACalReference ON dbo.pImage.ImageId = dbo.pTACalReference.ReferenceId LEFT OUTER JOIN
dbo.pTACalTemplate ON dbo.pTACalReference.TACalTemplateId = dbo.pTACalTemplate.TACalTemplateId

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08796', GetDate())
GO
