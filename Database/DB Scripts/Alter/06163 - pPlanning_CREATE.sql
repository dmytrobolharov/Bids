IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanning_PlanningID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanning] DROP CONSTRAINT [DF_pPlanning_PlanningID]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanning]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanning]
GO

CREATE TABLE [dbo].[pPlanning](
	[PlanningID] [uniqueidentifier] NOT NULL,
	[PlanningName] [nvarchar](200) NULL,
	[IntroSeasonYearID] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
	[CustomField1] [nvarchar](200) NULL,
	[CustomField2] [nvarchar](200) NULL,
	[CustomField3] [nvarchar](200) NULL,
	[CustomField4] [decimal](18, 5) NULL,
	[CustomField5] [datetime] NULL,
 CONSTRAINT [PK_pPlanning] PRIMARY KEY CLUSTERED 
(
	[PlanningID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pPlanning] ADD  CONSTRAINT [DF_pPlanning_PlanningID]  DEFAULT (newid()) FOR [PlanningID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06163', GetDate())
GO
