IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMilestoneItemWorkflowStatus]') AND type in (N'U'))
DROP TABLE [dbo].[pMilestoneItemWorkflowStatus]
GO

CREATE TABLE [dbo].[pMilestoneItemWorkflowStatus](
	[MilestoneItemID] [uniqueidentifier] NOT NULL,
	[WorkflowStatusID] [int] NOT NULL,
 CONSTRAINT [PK_pMilestoneItemWorkflowStatus] PRIMARY KEY CLUSTERED 
(
	[MilestoneItemID] ASC,
	[WorkflowStatusID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07129', GetDate())
GO
