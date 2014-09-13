IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pMilestoneItem_MilestoneItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pMilestoneItem] DROP CONSTRAINT [DF_pMilestoneItem_MilestoneItemID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMilestoneItem]') AND type in (N'U'))
DROP TABLE [dbo].[pMilestoneItem]
GO

CREATE TABLE [dbo].[pMilestoneItem](
	[MilestoneItemID] [uniqueidentifier] NOT NULL,
	[TaskID] [uniqueidentifier] NULL,
	[MilestoneID] [uniqueidentifier] NULL,
	[MilestoneItemName] [nvarchar](100) NULL,
	[MilestoneItemDescription] [nvarchar](400) NULL,
	[DependencyID] [uniqueidentifier] NULL,
	[DependentWorkflowTypeID] [uniqueidentifier] NULL,
	[Duration] [int] NULL,
	[AlertDays] [int] NULL,
	[Sort] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pMilestoneItem] PRIMARY KEY CLUSTERED 
(
	[MilestoneItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pMilestoneItem] ADD  CONSTRAINT [DF_pMilestoneItem_MilestoneItemID]  DEFAULT (newid()) FOR [MilestoneItemID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07125', GetDate())
GO
