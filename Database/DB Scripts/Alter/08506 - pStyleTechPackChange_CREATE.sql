IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleTechPackChange_StyleTechPackChangeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleTechPackChange] DROP CONSTRAINT [DF_pStyleTechPackChange_StyleTechPackChangeID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleTechPackChange_StyleTechPackStatus]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleTechPackChange] DROP CONSTRAINT [DF_pStyleTechPackChange_StyleTechPackStatus]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleTechPackChange_ActiveID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleTechPackChange] DROP CONSTRAINT [DF_pStyleTechPackChange_ActiveID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleTechPackChange_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleTechPackChange] DROP CONSTRAINT [DF_pStyleTechPackChange_Active]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleTechPackChange_RepRowGuidColID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleTechPackChange] DROP CONSTRAINT [DF_pStyleTechPackChange_RepRowGuidColID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleTechPackChange]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleTechPackChange]
GO

CREATE TABLE [dbo].[pStyleTechPackChange](
	[StyleTechPackChangeID] [uniqueidentifier] NOT NULL,
	[StyleTechPackChangeNo] [int] IDENTITY(1,1) NOT NULL,
	[StyleTechPackStatus] [bit] NULL,
	[StyleTechPackWorkflowID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleSeasonYearID] [uniqueidentifier] NULL,
	[StyleTechPackChangeNotifyTo] [nvarchar](4000) NULL,
	[StyleTechPackChangeType] [nvarchar](100) NULL,
	[StyleTechPackChangeDescription] [nvarchar](4000) NULL,
	[StyleTechPackChangeBy] [nvarchar](100) NULL,
	[StyleTechPackChangeDate] [datetime] NULL,
	[ActiveID] [uniqueidentifier] NOT NULL,
	[Active] [bit] NOT NULL,
	[RepRowGuidColID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_pStyleTechPackChange] PRIMARY KEY CLUSTERED 
(
	[StyleTechPackChangeID] ASC,
	[StyleTechPackChangeNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleTechPackChange] ADD  CONSTRAINT [DF_pStyleTechPackChange_StyleTechPackChangeID]  DEFAULT (newid()) FOR [StyleTechPackChangeID]
GO

ALTER TABLE [dbo].[pStyleTechPackChange] ADD  CONSTRAINT [DF_pStyleTechPackChange_StyleTechPackStatus]  DEFAULT ((0)) FOR [StyleTechPackStatus]
GO

ALTER TABLE [dbo].[pStyleTechPackChange] ADD  CONSTRAINT [DF_pStyleTechPackChange_ActiveID]  DEFAULT ('{00000000-0000-0000-0000-000000000000}') FOR [ActiveID]
GO

ALTER TABLE [dbo].[pStyleTechPackChange] ADD  CONSTRAINT [DF_pStyleTechPackChange_Active]  DEFAULT ((1)) FOR [Active]
GO

ALTER TABLE [dbo].[pStyleTechPackChange] ADD  CONSTRAINT [DF_pStyleTechPackChange_RepRowGuidColID]  DEFAULT (newid()) FOR [RepRowGuidColID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08506', GetDate())
GO
