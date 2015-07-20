/****** Object:  Table [dbo].[pMilestoneTemplateItemWorkflow]    Script Date: 03/29/2013 16:12:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMilestoneTemplateItemWorkflow]') AND type in (N'U'))
DROP TABLE [dbo].[pMilestoneTemplateItemWorkflow]
GO

CREATE TABLE [dbo].[pMilestoneTemplateItemWorkflow](
	[MilestoneTemplateItemID] [uniqueidentifier] NOT NULL,
	[WorkflowID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_pMilestoneTemplateItemWorkflows] PRIMARY KEY CLUSTERED 
(
	[MilestoneTemplateItemID] ASC,
	[WorkflowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05441', GetDate())
GO
