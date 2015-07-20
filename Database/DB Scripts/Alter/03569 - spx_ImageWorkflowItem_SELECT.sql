/****** Object:  StoredProcedure [dbo].[spx_ImageWorkflowItem_SELECT]    Script Date: 05/29/2012 17:50:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageWorkflowItem_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ImageWorkflowItem_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ImageWorkflowItem_SELECT]    Script Date: 05/29/2012 17:50:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ImageWorkflowItem_SELECT]
	@ImageID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT * FROM pImage i
	LEFT JOIN pImageWorkflowTemplate wt ON wt.ImageWorkflowTemplateID = i.ImageWorkflowTemplateID
	INNER JOIN pImageWorkflowTemplateEntry we ON we.ImageWorkflowTemplateID = wt.ImageWorkflowTemplateID
	LEFT JOIN pImageWorkflowTemplateItem wi ON wi.ImageWorkflowTemplateItemID = we.ImageWorkflowTemplateItemID
	WHERE i.ImageID = @ImageID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03569', GetDate())
GO 