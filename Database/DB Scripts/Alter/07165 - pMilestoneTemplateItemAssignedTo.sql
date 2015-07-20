IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMilestoneTemplateItemAssignedTo]') AND type in (N'U'))
DROP TABLE [dbo].[pMilestoneTemplateItemAssignedTo]
GO

CREATE TABLE [dbo].[pMilestoneTemplateItemAssignedTo](
	[MilestoneTemplateItemID] [uniqueidentifier] NOT NULL,
	[AssignedToID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_pMilestoneTemplateItemAssignedTo] PRIMARY KEY CLUSTERED 
(
	[MilestoneTemplateItemID] ASC,
	[AssignedToID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07165', GetDate())
GO
