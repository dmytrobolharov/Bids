IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pMilestone_MilestoneID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pMilestone] DROP CONSTRAINT [DF_pMilestone_MilestoneID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMilestone]') AND type in (N'U'))
DROP TABLE [dbo].[pMilestone]
GO

CREATE TABLE [dbo].[pMilestone](
	[MilestoneID] [uniqueidentifier] NOT NULL,
	[MilestoneName] [nvarchar](100) NULL,
	[MilestoneDescription] [nvarchar](400) NULL,
	[Duration] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pMilestone] PRIMARY KEY CLUSTERED 
(
	[MilestoneID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pMilestone] ADD  CONSTRAINT [DF_pMilestone_MilestoneID]  DEFAULT (newid()) FOR [MilestoneID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07123', GetDate())
GO
