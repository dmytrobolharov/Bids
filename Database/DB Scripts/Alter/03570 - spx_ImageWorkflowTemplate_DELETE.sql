/****** Object:  StoredProcedure [dbo].[spx_ImageWorkflowTemplate_DELETE]    Script Date: 05/29/2012 17:47:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageWorkflowTemplate_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ImageWorkflowTemplate_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_ImageWorkflowTemplate_DELETE]    Script Date: 05/29/2012 17:47:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ImageWorkflowTemplate_DELETE]
	@ImageWorkflowTemplateID UNIQUEIDENTIFIER
AS
BEGIN
	DELETE FROM pImageWorkflowTemplateEntry WHERE ImageWorkflowTemplateID = @ImageWorkflowTemplateID
	DELETE FROM pImageWorkflowTemplate WHERE ImageWorkflowTemplateID = @ImageWorkflowTemplateID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03570', GetDate())
GO 