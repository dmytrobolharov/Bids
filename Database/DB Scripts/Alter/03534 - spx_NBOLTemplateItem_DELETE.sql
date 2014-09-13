IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NBOLTemplateItem_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NBOLTemplateItem_DELETE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_NBOLTemplateItem_DELETE]
	@TemplateItemID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @MacroID UNIQUEIDENTIFIER
    SELECT @MacroID = MacroID FROM pNBOLTemplateItem WHERE TemplateItemID = @TemplateItemID
    
    -- remove macro operations
    IF @MacroID IS NOT NULL
		DELETE FROM pNBOLTemplateItem WHERE ParentID = @TemplateItemID
		
	DELETE FROM pNBOLTemplateItem WHERE TemplateItemID = @TemplateItemID
END

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03534', GetDate())
GO