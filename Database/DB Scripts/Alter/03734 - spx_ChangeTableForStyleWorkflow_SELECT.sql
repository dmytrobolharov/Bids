/****** Object:  StoredProcedure [dbo].[spx_ChangeTableForStyleWorkflow_SELECT]    Script Date: 07/30/2012 13:21:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeTableForStyleWorkflow_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ChangeTableForStyleWorkflow_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeTableForStyleWorkflow_SELECT]    Script Date: 07/30/2012 13:21:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ChangeTableForStyleWorkflow_SELECT] 
	@WorkflowID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT ChangeTableID FROM pStyleWorkflowToChangeTable WHERE WorkflowID = @WorkflowID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03734', GetDate())
GO