IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'DF_pTechPackCoverpage_CustomID') AND type = 'D')
ALTER TABLE [dbo].[pTechPackCoverpage] DROP CONSTRAINT [DF_pTechPackCoverpage_CustomID]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.pTechPackCoverpage') AND type in (N'U'))
DROP TABLE [dbo].[pTechPackCoverpage]
GO

CREATE TABLE [dbo].[pTechPackCoverpage](
	[CustomID] [uniqueidentifier] NOT NULL,
	[Custom] [nvarchar](100) NULL,
	[CustomKey] [nvarchar](200) NULL,
	[CustomSort] [nvarchar](5) NULL,
	[Active] [int] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pTechPackCoverpage] ADD  CONSTRAINT [DF_pTechPackCoverpage_CustomID]  DEFAULT (newid()) FOR [CustomID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08875', GetDate())
GO


