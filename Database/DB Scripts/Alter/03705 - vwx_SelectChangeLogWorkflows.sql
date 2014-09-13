/****** Object:  View [dbo].[vwx_SelectChangeLogWorkflows]    Script Date: 07/20/2012 17:46:16 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SelectChangeLogWorkflows]'))
DROP VIEW [dbo].[vwx_SelectChangeLogWorkflows]
GO

/****** Object:  View [dbo].[vwx_SelectChangeLogWorkflows]    Script Date: 07/20/2012 17:46:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_SelectChangeLogWorkflows]
AS
SELECT DISTINCT dbo.pStyleWorkflowToChangeTable.WorkflowID, dbo.pWorkflow.Workflow
FROM         dbo.pStyleWorkflowToChangeTable INNER JOIN
                      dbo.pWorkflow ON dbo.pStyleWorkflowToChangeTable.WorkflowID = dbo.pWorkflow.WorkflowID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03705', GetDate())
GO