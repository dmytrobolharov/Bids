IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pImageChange_ImageChangeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pImageChange] DROP CONSTRAINT [DF_pImageChange_ImageChangeID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pImageChange_ImageStatus]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pImageChange] DROP CONSTRAINT [DF_pImageChange_ImageStatus]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pImageChange_ActiveID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pImageChange] DROP CONSTRAINT [DF_pImageChange_ActiveID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pImageChange_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pImageChange] DROP CONSTRAINT [DF_pImageChange_Active]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pImageChange_RepRowGuidColID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pImageChange] DROP CONSTRAINT [DF_pImageChange_RepRowGuidColID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pImageChange]') AND type in (N'U'))
DROP TABLE [dbo].[pImageChange]
GO

CREATE TABLE [dbo].[pImageChange](
	[ImageChangeID] [uniqueidentifier] NOT NULL,
	[ImageChangeNo] [int] IDENTITY(1,1) NOT NULL,
	[ImageStatus] [bit] NULL,
	[ImageWorkflowTemplateItemID] [uniqueidentifier] NULL,
	[ImageID] [uniqueidentifier] NULL,
	[ImageChangeNotifyTo] [nvarchar](4000) NULL,
	[ImageChangeType] [nvarchar](100) NULL,
	[ImageChangeDescription] [nvarchar](4000) NULL,
	[ImageChangeBy] [nvarchar](100) NULL,
	[ImageChangeDate] [datetime] NULL,
	[ActiveID] [uniqueidentifier] NOT NULL,
	[Active] [bit] NOT NULL,
	[RepRowGuidColID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK_pImageChange] PRIMARY KEY CLUSTERED 
(
	[ImageChangeID] ASC,
	[ImageChangeNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pImageChange] ADD  CONSTRAINT [DF_pImageChange_ImageChangeID]  DEFAULT (newid()) FOR [ImageChangeID]
GO

ALTER TABLE [dbo].[pImageChange] ADD  CONSTRAINT [DF_pImageChange_ImageStatus]  DEFAULT ((0)) FOR [ImageStatus]
GO

ALTER TABLE [dbo].[pImageChange] ADD  CONSTRAINT [DF_pImageChange_ActiveID]  DEFAULT ('{00000000-0000-0000-0000-000000000000}') FOR [ActiveID]
GO

ALTER TABLE [dbo].[pImageChange] ADD  CONSTRAINT [DF_pImageChange_Active]  DEFAULT ((1)) FOR [Active]
GO

ALTER TABLE [dbo].[pImageChange] ADD  CONSTRAINT [DF_pImageChange_RepRowGuidColID]  DEFAULT (newid()) FOR [RepRowGuidColID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08434', GetDate())
GO
