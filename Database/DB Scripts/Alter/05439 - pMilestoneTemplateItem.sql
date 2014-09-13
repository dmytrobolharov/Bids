IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pMilestoneTemplateItem_MilestoneTemplateItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pMilestoneTemplateItem] DROP CONSTRAINT [DF_pMilestoneTemplateItem_MilestoneTemplateItemID]
END

GO

/****** Object:  Table [dbo].[pMilestoneTemplateItem]    Script Date: 03/29/2013 13:27:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMilestoneTemplateItem]') AND type in (N'U'))
DROP TABLE [dbo].[pMilestoneTemplateItem]
GO

/****** Object:  Table [dbo].[pMilestoneTemplateItem]    Script Date: 03/29/2013 13:27:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pMilestoneTemplateItem](
	[MilestoneTemplateItemID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[MilestoneTemplateID] [uniqueidentifier] NOT NULL,
	[MilestoneTemplateItemName] [nvarchar](200) NULL,
	[MilestoneTemplateItemDescription] [nvarchar](400) NULL,
	[DependentWorkflowTypeID] [uniqueidentifier] NULL,
	[DependentWorkflowStatusID] [int] NULL,
	[Days] [int] NULL,
	[SortOrder] [varchar](5) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pMilestoneTemplateItem] PRIMARY KEY CLUSTERED 
(
	[MilestoneTemplateItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pMilestoneTemplateItem] ADD  CONSTRAINT [DF_pMilestoneTemplateItem_MilestoneTemplateItemID]  DEFAULT (newid()) FOR [MilestoneTemplateItemID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05439', GetDate())
GO
