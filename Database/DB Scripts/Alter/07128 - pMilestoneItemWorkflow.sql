IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMilestoneItemWorkflow]') AND type in (N'U'))
DROP TABLE [dbo].[pMilestoneItemWorkflow]
GO

CREATE TABLE [dbo].[pMilestoneItemWorkflow](
	[MilestoneItemID] [uniqueidentifier] NOT NULL,
	[WorkflowID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_pMilestoneItemWorkflow] PRIMARY KEY CLUSTERED 
(
	[MilestoneItemID] ASC,
	[WorkflowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07128', GetDate())
GO
