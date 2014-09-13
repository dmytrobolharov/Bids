IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTechPackWorkflowItem]') AND type in (N'U'))
DROP TABLE [dbo].[pTechPackWorkflowItem]
GO

CREATE TABLE [dbo].[pTechPackWorkflowItem](
	[TechPackID] [uniqueidentifier] NOT NULL,
	[WorkflowItemID] [uniqueidentifier] NOT NULL,
	[WorkflowID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_pTechPackWorkflowItem] PRIMARY KEY CLUSTERED 
(
	[TechPackID] ASC,
	[WorkflowItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06782', GetDate())
GO
