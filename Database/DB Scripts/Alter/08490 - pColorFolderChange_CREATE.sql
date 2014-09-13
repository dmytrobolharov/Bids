IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pColorFolderChange_ColorFolderChangeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pColorFolderChange] DROP CONSTRAINT [DF_pColorFolderChange_ColorFolderChangeID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pColorFolderChange_ColorFolderStatus]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pColorFolderChange] DROP CONSTRAINT [DF_pColorFolderChange_ColorFolderStatus]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pColorFolderChange_ActiveID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pColorFolderChange] DROP CONSTRAINT [DF_pColorFolderChange_ActiveID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pColorFolderChange_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pColorFolderChange] DROP CONSTRAINT [DF_pColorFolderChange_Active]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pColorFolderChange_RepRowGuidColID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pColorFolderChange] DROP CONSTRAINT [DF_pColorFolderChange_RepRowGuidColID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pColorFolderChange]') AND type in (N'U'))
DROP TABLE [dbo].[pColorFolderChange]
GO

CREATE TABLE [dbo].[pColorFolderChange](
	[ColorFolderChangeID] [uniqueidentifier] NOT NULL,
	[ColorFolderChangeNo] [int] IDENTITY(1,1) NOT NULL,
	[ColorFolderStatus] [bit] NULL,
	[ColorFolderWorkflowID] [uniqueidentifier] NULL,
	[ColorFolderID] [uniqueidentifier] NULL,
	[ColorFolderChangeNotifyTo] [nvarchar](4000) NULL,
	[ColorFolderChangeType] [nvarchar](100) NULL,
	[ColorFolderChangeDescription] [nvarchar](4000) NULL,
	[ColorFolderChangeBy] [nvarchar](100) NULL,
	[ColorFolderChangeDate] [datetime] NULL,
	[ActiveID] [uniqueidentifier] NOT NULL,
	[Active] [bit] NOT NULL,
	[RepRowGuidColID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_pColorFolderChange] PRIMARY KEY CLUSTERED 
(
	[ColorFolderChangeID] ASC,
	[ColorFolderChangeNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pColorFolderChange] ADD  CONSTRAINT [DF_pColorFolderChange_ColorFolderChangeID]  DEFAULT (newid()) FOR [ColorFolderChangeID]
GO

ALTER TABLE [dbo].[pColorFolderChange] ADD  CONSTRAINT [DF_pColorFolderChange_ColorFolderStatus]  DEFAULT ((0)) FOR [ColorFolderStatus]
GO

ALTER TABLE [dbo].[pColorFolderChange] ADD  CONSTRAINT [DF_pColorFolderChange_ActiveID]  DEFAULT ('{00000000-0000-0000-0000-000000000000}') FOR [ActiveID]
GO

ALTER TABLE [dbo].[pColorFolderChange] ADD  CONSTRAINT [DF_pColorFolderChange_Active]  DEFAULT ((1)) FOR [Active]
GO

ALTER TABLE [dbo].[pColorFolderChange] ADD  CONSTRAINT [DF_pColorFolderChange_RepRowGuidColID]  DEFAULT (newid()) FOR [RepRowGuidColID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08490', GetDate())
GO
