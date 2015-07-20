/****** Object:  StoredProcedure [dbo].[spx_ImageWorkflowTemplateEntry_DELETE]    Script Date: 05/29/2012 17:47:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageWorkflowTemplateEntry_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ImageWorkflowTemplateEntry_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_ImageWorkflowTemplateEntry_DELETE]    Script Date: 05/29/2012 17:47:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ImageWorkflowTemplateEntry_DELETE]
	@ImageWorkflowTemplateItemID UNIQUEIDENTIFIER,
	@ImageWorkflowTemplateID UNIQUEIDENTIFIER	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DELETE FROM pImageWorkflowTemplateEntry WHERE ImageWorkflowTemplateID = @ImageWorkflowTemplateID AND ImageWorkflowtemplateItemID = @ImageWorkflowTemplateItemID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03571', GetDate())
GO 