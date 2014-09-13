IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NBOLTemplate_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NBOLTemplate_DELETE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_NBOLTemplate_DELETE] 
	@TemplateID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DELETE FROM pNBOLTemplateItem WHERE TemplateID = @TemplateID
    DELETE FROM pNBOLTemplate WHERE TemplateID = @TemplateID
END


GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03538', GetDate())
GO