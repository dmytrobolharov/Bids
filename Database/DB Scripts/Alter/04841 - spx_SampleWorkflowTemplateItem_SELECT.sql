IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowTemplateItem_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowTemplateItem_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_SampleWorkflowTemplateItem_SELECT](
	@SampleWorkflowTempID uniqueidentifier
)
AS 

SELECT     dbo.pSampleWorkflowItemTemplate.SampleWorkflowTempItemID, dbo.pSampleWorkflowItemTemplate.SampleWorkflowID, 
                      dbo.pSampleWorkflowItemTemplate.SampleWorkflowAssignedTo, dbo.pSampleWorkflowItemTemplate.SampleWorkflowDays, 
                      dbo.pSampleWorkflowItemTemplate.SampleWorkflowAlerts, dbo.pSampleWorkflowItemTemplate.Active, 
                      dbo.pSampleWorkflowItemTemplate.SampleWorkflowSort, dbo.pSampleWorkflowItemTemplate.SampleWorkflowTempID, 
                      dbo.pSampleWorkflow.SampleWorkflow, dbo.pSampleWorkflow.GroupName, dbo.pSampleWorkflowItemTemplate.SampleWorkflowRDays,
						dbo.pSampleWorkflowItemTemplate.SampleWorkflowFinalDate, 
						dbo.pSampleWorkflowItemTemplate.SampleWorkflowPartnerTypeID
FROM         dbo.pSampleWorkflowItemTemplate WITH (NOLOCK) INNER JOIN
                      dbo.pSampleWorkflow WITH (NOLOCK) ON dbo.pSampleWorkflowItemTemplate.SampleWorkflowID = dbo.pSampleWorkflow.SampleWorkflowID
WHERE     (dbo.pSampleWorkflowItemTemplate.SampleWorkflowTempID = @SampleWorkflowTempID)
ORDER BY dbo.pSampleWorkflowItemTemplate.SampleWorkflowSort


set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04841', GetDate())
GO
