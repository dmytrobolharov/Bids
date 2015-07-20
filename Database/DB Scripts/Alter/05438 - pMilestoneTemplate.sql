IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pMilestoneTemplate_MilestoneTemplateID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pMilestoneTemplate] DROP CONSTRAINT [DF_pMilestoneTemplate_MilestoneTemplateID]
END

GO

/****** Object:  Table [dbo].[pMilestoneTemplate]    Script Date: 03/29/2013 13:26:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMilestoneTemplate]') AND type in (N'U'))
DROP TABLE [dbo].[pMilestoneTemplate]
GO

/****** Object:  Table [dbo].[pMilestoneTemplate]    Script Date: 03/29/2013 13:26:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pMilestoneTemplate](
	[MilestoneTemplateID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[MilestoneTemplateName] [nvarchar](200) NULL,
	[MilestoneTemplateDescription] [nvarchar](400) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pMilestoneTemplate] PRIMARY KEY CLUSTERED 
(
	[MilestoneTemplateID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pMilestoneTemplate] ADD  CONSTRAINT [DF_pMilestoneTemplate_MilestoneTemplateID]  DEFAULT (newid()) FOR [MilestoneTemplateID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05438', GetDate())
GO
