/****** Object:  Table [dbo].[pMilestoneTemplateItemWorkflowStatus]    Script Date: 04/04/2013 11:05:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMilestoneTemplateItemWorkflowStatus]') AND type in (N'U'))
DROP TABLE [dbo].[pMilestoneTemplateItemWorkflowStatus]
GO

CREATE TABLE [dbo].[pMilestoneTemplateItemWorkflowStatus](
	[MilestoneTemplateitemID] [uniqueidentifier] NOT NULL,
	[WorkflowStatusID] [int] NOT NULL,
 CONSTRAINT [PK_pMilestoneTemplateItemWorkflowStatusID] PRIMARY KEY CLUSTERED 
(
	[MilestoneTemplateitemID] ASC,
	[WorkflowStatusID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05486', GetDate())
GO
