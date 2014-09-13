/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowForChangeTable_SELECT]    Script Date: 07/30/2012 13:43:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowForChangeTable_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowForChangeTable_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflowForChangeTable_SELECT]    Script Date: 07/30/2012 13:43:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spx_StyleWorkflowForChangeTable_SELECT]
	@ChangeTableID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT w.Workflow FROM pStyleWorkflowToChangeTable p 
    LEFT JOIN pWorkflow w ON p.WorkflowID = w.WorkflowID 
    WHERE ChangeTableID = @ChangeTableID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03735', GetDate())
GO