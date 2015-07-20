/****** Object:  StoredProcedure [dbo].[spx_ImageWorkflowTemplateEntry_SELECT]    Script Date: 05/29/2012 17:48:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageWorkflowTemplateEntry_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ImageWorkflowTemplateEntry_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ImageWorkflowTemplateEntry_SELECT]    Script Date: 05/29/2012 17:48:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ImageWorkflowTemplateEntry_SELECT]
	@ImageWorkflowTemplateID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * FROM pImageWorkflowTemplateEntry e
    INNER JOIN pImageWorkflowTemplateItem i ON e.ImageWorkflowTemplateItemID = i.ImageWorkflowTemplateItemID
    WHERE e.ImageWorkFlowTemplateID = @ImageWorkflowTemplateID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03573', GetDate())
GO 