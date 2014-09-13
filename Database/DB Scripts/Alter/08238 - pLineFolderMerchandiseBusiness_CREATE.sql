IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pLineFold__Plann__17B170E9]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderMerchandiseBusiness] DROP CONSTRAINT [DF__pLineFold__Plann__17B170E9]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pLineFold__Plann__18A59522]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderMerchandiseBusiness] DROP CONSTRAINT [DF__pLineFold__Plann__18A59522]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pLineFold__Plann__1999B95B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderMerchandiseBusiness] DROP CONSTRAINT [DF__pLineFold__Plann__1999B95B]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pLineFold__Plann__1A8DDD94]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderMerchandiseBusiness] DROP CONSTRAINT [DF__pLineFold__Plann__1A8DDD94]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pLineFold__Plann__1B8201CD]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderMerchandiseBusiness] DROP CONSTRAINT [DF__pLineFold__Plann__1B8201CD]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pLineFold__Plann__1C762606]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderMerchandiseBusiness] DROP CONSTRAINT [DF__pLineFold__Plann__1C762606]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pLineFold__Activ__1D6A4A3F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderMerchandiseBusiness] DROP CONSTRAINT [DF__pLineFold__Activ__1D6A4A3F]
END

GO

/****** Object:  Table [dbo].[pLineFolderMerchandiseBusiness]    Script Date: 07/07/2014 15:08:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLineFolderMerchandiseBusiness]') AND type in (N'U'))
DROP TABLE [dbo].[pLineFolderMerchandiseBusiness]
GO

/****** Object:  Table [dbo].[pLineFolderMerchandiseBusiness]    Script Date: 07/07/2014 15:08:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pLineFolderMerchandiseBusiness](
	[PlanningBusinessID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[LineFolderID] [uniqueidentifier] NOT NULL,
	[PlanningID] [uniqueidentifier] NULL,
	[PlanningFinancialID] [uniqueidentifier] NULL,
	[PlanningFinancialText] [nvarchar](100) NULL,
	[PlanningFinancialSort] [varchar](5) NULL,
	[PlanningDivisionID] [uniqueidentifier] NULL,
	[PlanningStyleTypeID] [int] NULL,
	[PlanningStyleCategoryID] [uniqueidentifier] NULL,
	[PlanningDivision] [nvarchar](100) NULL,
	[PlanningStyleTypeDescription] [nvarchar](100) NULL,
	[PlanningStyleCategory] [nvarchar](100) NULL,
	[PlanningDivisionSort] [varchar](5) NULL,
	[PlanningStyleTypeSort] [varchar](5) NULL,
	[PlanningStyleCategorySort] [varchar](5) NULL,
	[PlanningLastYearCh] [decimal](18, 5) NULL,
	[PlanningPlanningCh] [decimal](18, 5) NULL,
	[PlanningDIPCh] [decimal](18, 5) NULL,
	[PlanningActualCh] [decimal](18, 5) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[PlanningBrandID] [uniqueidentifier] NULL,
	[PlanningBrand] [nvarchar](200) NULL,
	[SeasonYearID] [uniqueidentifier] NULL,
	[PlanningSubCategoryID] [uniqueidentifier] NULL,
	[PlanningSubCategory] [nvarchar](200) NULL,
	[Active] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PlanningBusinessID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pLineFolderMerchandiseBusiness] ADD  DEFAULT (newid()) FOR [PlanningBusinessID]
GO

ALTER TABLE [dbo].[pLineFolderMerchandiseBusiness] ADD  DEFAULT (newid()) FOR [PlanningFinancialID]
GO

ALTER TABLE [dbo].[pLineFolderMerchandiseBusiness] ADD  DEFAULT ((0)) FOR [PlanningLastYearCh]
GO

ALTER TABLE [dbo].[pLineFolderMerchandiseBusiness] ADD  DEFAULT ((0)) FOR [PlanningPlanningCh]
GO

ALTER TABLE [dbo].[pLineFolderMerchandiseBusiness] ADD  DEFAULT ((0)) FOR [PlanningDIPCh]
GO

ALTER TABLE [dbo].[pLineFolderMerchandiseBusiness] ADD  DEFAULT ((0)) FOR [PlanningActualCh]
GO

ALTER TABLE [dbo].[pLineFolderMerchandiseBusiness] ADD  DEFAULT ((1)) FOR [Active]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08238', GetDate())
GO
