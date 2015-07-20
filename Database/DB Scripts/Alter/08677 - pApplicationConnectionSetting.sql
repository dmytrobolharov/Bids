IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pApplicationSetting_ApplicationSettingID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pApplicationConnectionSetting] DROP CONSTRAINT [DF_pApplicationSetting_ApplicationSettingID]
END

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pApplicationConnectionSetting]') AND type in (N'U'))
DROP TABLE [dbo].[pApplicationConnectionSetting]
GO

CREATE TABLE [dbo].[pApplicationConnectionSetting](
	[ApplicationConnectionSettingID] [uniqueidentifier] NOT NULL,
	[ApplicationConnectionName] [nvarchar](200) NOT NULL,
	[ApplicationConnectionSort] [int] NULL,
	[ApplicationConnectionXML] [nvarchar] (200) NOT NULL,
	[ApplicationConnectionXMLEdit] [nvarchar] (200) NOT NULL,
	[A] [nvarchar](200) NULL,
	[B] [nvarchar](200) NULL,
	[C] [nvarchar](200) NULL,
	[D] [nvarchar](200) NULL,
	[E] [nvarchar](200) NULL,
	[F] [nvarchar](200) NULL,
	[G] [nvarchar](200) NULL,
	[H] [nvarchar](200) NULL,
	[I] [nvarchar](200) NULL,
	[J] [nvarchar](200) NULL,
	[K] [nvarchar](200) NULL,
	[L] [nvarchar](200) NULL,
	[M] [nvarchar](200) NULL,
	[N] [nvarchar](200) NULL,
	[O] [nvarchar](200) NULL,
	[P] [nvarchar](200) NULL,
	[Q] [nvarchar](200) NULL,
	[R] [nvarchar](200) NULL,
	[S] [nvarchar](200) NULL,
	[T] [nvarchar](200) NULL,
	[U] [nvarchar](200) NULL,
	[V] [nvarchar](200) NULL,
	[W] [nvarchar](200) NULL,
	[X] [nvarchar](200) NULL,
	[Y] [nvarchar](200) NULL,
	[Z] [nvarchar](200) NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pApplicationConnectionSetting] ADD  CONSTRAINT [DF_pApplicationSetting_ApplicationSettingID]  DEFAULT (newid()) FOR [ApplicationConnectionSettingID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08677', GetDate())
GO