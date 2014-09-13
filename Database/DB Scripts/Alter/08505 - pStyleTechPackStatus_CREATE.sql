IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleTechPackStatus_StyleTechPackStatusID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleTechPackStatus] DROP CONSTRAINT [DF_pStyleTechPackStatus_StyleTechPackStatusID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleTechPackStatus]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleTechPackStatus]
GO

CREATE TABLE [dbo].[pStyleTechPackStatus](
	[StyleTechPackStatusID] [uniqueidentifier] NOT NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleSeasonYearID] [uniqueidentifier] NULL,
	[WorkStatus] [int] NULL,
	[WorkAssignedTo] [int] NULL,
	[WorkStart] [datetime] NULL,
	[WorkDue] [datetime] NULL,
	[ActualStart] [datetime] NULL,
	[ActualEnd] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pStyleTechPackStatus] PRIMARY KEY CLUSTERED 
(
	[StyleTechPackStatusID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleTechPackStatus] ADD  CONSTRAINT [DF_pStyleTechPackStatus_StyleTechPackStatusID]  DEFAULT (newid()) FOR [StyleTechPackStatusID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08505', GetDate())
GO
