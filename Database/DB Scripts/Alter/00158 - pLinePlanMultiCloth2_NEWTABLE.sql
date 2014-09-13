
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLinePlanMultiCloth2BodyTemp_LinePlanMultiCloth2BodyTempID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLinePlanMultiCloth2BodyTemp] DROP CONSTRAINT [DF_pLinePlanMultiCloth2BodyTemp_LinePlanMultiCloth2BodyTempID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLinePlanMultiCloth2MaterialGroupItemTemp_LinePlanMultiCloth2MaterialGroupItemTempID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLinePlanMultiCloth2MaterialGroupItemTemp] DROP CONSTRAINT [DF_pLinePlanMultiCloth2MaterialGroupItemTemp_LinePlanMultiCloth2MaterialGroupItemTempID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLinePlanMultiCloth2MaterialGroupTemp_LinePlanMultiCloth2MaterialGroupID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLinePlanMultiCloth2MaterialGroupTemp] DROP CONSTRAINT [DF_pLinePlanMultiCloth2MaterialGroupTemp_LinePlanMultiCloth2MaterialGroupID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLinePlanMultiCloth2MaterialGroupTemp_LinePlanQueued]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLinePlanMultiCloth2MaterialGroupTemp] DROP CONSTRAINT [DF_pLinePlanMultiCloth2MaterialGroupTemp_LinePlanQueued]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLinePlanMultiCloth2ColorTemp_LinePlanMultiCloth2ColorTempID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLinePlanMultiCloth2ColorTemp] DROP CONSTRAINT [DF_pLinePlanMultiCloth2ColorTemp_LinePlanMultiCloth2ColorTempID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLinePlanMultiCloth2ColorTemp_MaterialCoreColorID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLinePlanMultiCloth2ColorTemp] DROP CONSTRAINT [DF_pLinePlanMultiCloth2ColorTemp_MaterialCoreColorID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLinePlanMultiCloth2MaterialTemp_LinePlanMultiCloth2MaterialTempID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLinePlanMultiCloth2MaterialTemp] DROP CONSTRAINT [DF_pLinePlanMultiCloth2MaterialTemp_LinePlanMultiCloth2MaterialTempID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLinePlanMultiCloth2MaterialTemp_LinePlanMultiCloth2Queued]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLinePlanMultiCloth2MaterialTemp] DROP CONSTRAINT [DF_pLinePlanMultiCloth2MaterialTemp_LinePlanMultiCloth2Queued]
END

GO

/****** Object:  Table [dbo].[pLinePlanMultiCloth2BodyTemp]    Script Date: 06/14/2010 11:06:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanMultiCloth2BodyTemp]') AND type in (N'U'))
DROP TABLE [dbo].[pLinePlanMultiCloth2BodyTemp]
GO

/****** Object:  Table [dbo].[pLinePlanMultiCloth2MaterialGroupItemTemp]    Script Date: 06/14/2010 11:06:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanMultiCloth2MaterialGroupItemTemp]') AND type in (N'U'))
DROP TABLE [dbo].[pLinePlanMultiCloth2MaterialGroupItemTemp]
GO

/****** Object:  Table [dbo].[pLinePlanMultiCloth2MaterialGroupTemp]    Script Date: 06/14/2010 11:06:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanMultiCloth2MaterialGroupTemp]') AND type in (N'U'))
DROP TABLE [dbo].[pLinePlanMultiCloth2MaterialGroupTemp]
GO

/****** Object:  Table [dbo].[pLinePlanMultiCloth2ColorTemp]    Script Date: 06/14/2010 11:06:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanMultiCloth2ColorTemp]') AND type in (N'U'))
DROP TABLE [dbo].[pLinePlanMultiCloth2ColorTemp]
GO

/****** Object:  Table [dbo].[pLinePlanMultiCloth2MaterialTemp]    Script Date: 06/14/2010 11:06:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLinePlanMultiCloth2MaterialTemp]') AND type in (N'U'))
DROP TABLE [dbo].[pLinePlanMultiCloth2MaterialTemp]
GO

/****** Object:  Table [dbo].[pLinePlanMultiCloth2BodyTemp]    Script Date: 06/14/2010 11:06:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pLinePlanMultiCloth2BodyTemp](
	[LinePlanMultiCloth2BodyTempID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[LinePlanColorGroupID] [uniqueidentifier] NULL,
	[LinePlanBodyItemID] [uniqueidentifier] NULL,
	[LinePlanRangeID] [uniqueidentifier] NULL,
	[LinePlanID] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pLinePlanMultiCloth2BodyTemp] PRIMARY KEY CLUSTERED 
(
	[LinePlanMultiCloth2BodyTempID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[pLinePlanMultiCloth2MaterialGroupItemTemp]    Script Date: 06/14/2010 11:06:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pLinePlanMultiCloth2MaterialGroupItemTemp](
	[LinePlanMultiCloth2MaterialGroupItemTempID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[LinePlanColorItemTempID] [uniqueidentifier] NULL,
	[LinePlanColorGroupID] [uniqueidentifier] NULL,
	[MaterialCoreColorItemID] [uniqueidentifier] NULL,
	[MaterialCoreColorID] [uniqueidentifier] NULL,
	[MaterialCoreItemID] [uniqueidentifier] NULL,
	[MaterialCoreID] [uniqueidentifier] NULL,
	[MaterialID] [uniqueidentifier] NOT NULL,
	[MaterialColorID] [uniqueidentifier] NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[LinePlanMultiCloth2ColorTempID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pLinePlanMultiCloth2MaterialGroupItemTemp] PRIMARY KEY CLUSTERED 
(
	[LinePlanMultiCloth2MaterialGroupItemTempID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[pLinePlanMultiCloth2MaterialGroupTemp]    Script Date: 06/14/2010 11:06:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pLinePlanMultiCloth2MaterialGroupTemp](
	[LinePlanMultiCloth2MaterialGroupID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[LinePlanColorGroupID] [uniqueidentifier] NOT NULL,
	[LinePlanMaterialGroupID] [uniqueidentifier] NOT NULL,
	[LinePlanRangeID] [uniqueidentifier] NOT NULL,
	[LinePlanID] [uniqueidentifier] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[LinePlanQueued] [int] NOT NULL,
 CONSTRAINT [PK_pLinePlanMultiCloth2MaterialGroupTemp] PRIMARY KEY CLUSTERED 
(
	[LinePlanMultiCloth2MaterialGroupID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Table [dbo].[pLinePlanMultiCloth2ColorTemp]    Script Date: 06/14/2010 11:06:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pLinePlanMultiCloth2ColorTemp](
	[LinePlanMultiCloth2ColorTempID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[LinePlanColorGroupID] [uniqueidentifier] NULL,
	[LinePlanColorItemID] [uniqueidentifier] NULL,
	[LinePlanRangeID] [uniqueidentifier] NULL,
	[LinePlanID] [uniqueidentifier] NULL,
	[MaterialColorID] [uniqueidentifier] NULL,
	[MaterialID] [uniqueidentifier] NULL,
	[ColorPaletteID] [uniqueidentifier] NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MaterialCoreColorID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pLinePlanMultiCloth2ColorTemp] PRIMARY KEY CLUSTERED 
(
	[LinePlanMultiCloth2ColorTempID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


/****** Object:  Table [dbo].[pLinePlanMultiCloth2MaterialTemp]    Script Date: 06/14/2010 11:06:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pLinePlanMultiCloth2MaterialTemp](
	[LinePlanMultiCloth2MaterialTempID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[LinePlanColorGroupID] [uniqueidentifier] NOT NULL,
	[LinePlanMaterialItemID] [uniqueidentifier] NOT NULL,
	[LinePlanRangeID] [uniqueidentifier] NOT NULL,
	[LinePlanID] [uniqueidentifier] NOT NULL,
	[MaterialID] [uniqueidentifier] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[LinePlanMultiCloth2Queued] [int] NOT NULL,
 CONSTRAINT [PK_pLinePlanMultiCloth2MaterialTemp] PRIMARY KEY CLUSTERED 
(
	[LinePlanMultiCloth2MaterialTempID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pLinePlanMultiCloth2BodyTemp] ADD  CONSTRAINT [DF_pLinePlanMultiCloth2BodyTemp_LinePlanMultiCloth2BodyTempID]  DEFAULT (newsequentialid()) FOR [LinePlanMultiCloth2BodyTempID]
GO

ALTER TABLE [dbo].[pLinePlanMultiCloth2MaterialGroupItemTemp] ADD  CONSTRAINT [DF_pLinePlanMultiCloth2MaterialGroupItemTemp_LinePlanMultiCloth2MaterialGroupItemTempID]  DEFAULT (newsequentialid()) FOR [LinePlanMultiCloth2MaterialGroupItemTempID]
GO

ALTER TABLE [dbo].[pLinePlanMultiCloth2MaterialGroupTemp] ADD  CONSTRAINT [DF_pLinePlanMultiCloth2MaterialGroupTemp_LinePlanMultiCloth2MaterialGroupID]  DEFAULT (newsequentialid()) FOR [LinePlanMultiCloth2MaterialGroupID]
GO

ALTER TABLE [dbo].[pLinePlanMultiCloth2MaterialGroupTemp] ADD  CONSTRAINT [DF_pLinePlanMultiCloth2MaterialGroupTemp_LinePlanQueued]  DEFAULT ((0)) FOR [LinePlanQueued]
GO

ALTER TABLE [dbo].[pLinePlanMultiCloth2ColorTemp] ADD  CONSTRAINT [DF_pLinePlanMultiCloth2ColorTemp_LinePlanMultiCloth2ColorTempID]  DEFAULT (newsequentialid()) FOR [LinePlanMultiCloth2ColorTempID]
GO

ALTER TABLE [dbo].[pLinePlanMultiCloth2ColorTemp] ADD  CONSTRAINT [DF_pLinePlanMultiCloth2ColorTemp_MaterialCoreColorID]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [MaterialCoreColorID]
GO

ALTER TABLE [dbo].[pLinePlanMultiCloth2MaterialTemp] ADD  CONSTRAINT [DF_pLinePlanMultiCloth2MaterialTemp_LinePlanMultiCloth2MaterialTempID]  DEFAULT (newsequentialid()) FOR [LinePlanMultiCloth2MaterialTempID]
GO

ALTER TABLE [dbo].[pLinePlanMultiCloth2MaterialTemp] ADD  CONSTRAINT [DF_pLinePlanMultiCloth2MaterialTemp_LinePlanMultiCloth2Queued]  DEFAULT ((0)) FOR [LinePlanMultiCloth2Queued]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '158', GetDate())
GO