IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderBusinessID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusinessID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderFinancialID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderFinancialID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_RangePlan]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_RangePlan]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderBusLYCh1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusLYCh1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderBusPnCh1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusPnCh1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderBusCuCh1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusCuCh1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderBusWpCh1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusWpCh1]
END

GO

/****** Object:  Table [dbo].[pLineFolderBusiness]    Script Date: 03/20/2013 12:19:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLineFolderBusiness]') AND type in (N'U'))
DROP TABLE [dbo].[pLineFolderBusiness]
GO

/****** Object:  Table [dbo].[pLineFolderBusiness]    Script Date: 03/20/2013 12:19:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pLineFolderBusiness](
	[LineFolderBusinessID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[LineFolderID] [uniqueidentifier] NULL,
	[LineFolderFinancialID] [uniqueidentifier] NULL,
	[LineFolderFinancialText] [nvarchar](100) NULL,
	[LineFolderFinancialSort] [varchar](5) NULL,
	[RangePlan] [int] NULL,
	[LineFolderDivisionID] [uniqueidentifier] NULL,
	[LineFolderStyleTypeID] [int] NULL,
	[LineFolderStyleCategoryID] [uniqueidentifier] NULL,
	[LineFolderDivision] [nvarchar](100) NULL,
	[LineFolderStyleTypeDescription] [nvarchar](100) NULL,
	[LineFolderStyleCategory] [nvarchar](100) NULL,
	[LineFolderDivisionSort] [varchar](5) NULL,
	[LineFolderStyleTypeSort] [varchar](5) NULL,
	[LineFolderStyleCategorySort] [varchar](5) NULL,
	[LineFolderLastYearCh] [decimal](18, 5) NULL,
	[LineFolderPlanningCh] [decimal](18, 5) NULL,
	[LineFolderDIPCh] [decimal](18, 5) NULL,
	[LineFolderActualCh] [decimal](18, 5) NULL,
	[LineFolderBus1] [nvarchar](50) NULL,
	[LineFolderBus2] [nvarchar](50) NULL,
	[LineFolderBus3] [nvarchar](50) NULL,
	[LineFolderBus4] [nvarchar](50) NULL,
	[LineFolderBus5] [nvarchar](50) NULL,
	[LineFolderBus6] [nvarchar](50) NULL,
	[LineFolderBus7] [nvarchar](50) NULL,
	[LineFolderBus8] [nvarchar](50) NULL,
	[LineFolderBus9] [nvarchar](50) NULL,
	[LineFolderBus10] [nvarchar](50) NULL,
	[LineFolderBus11] [nvarchar](50) NULL,
	[LineFolderBus12] [nvarchar](50) NULL,
	[LineFolderBus13] [nvarchar](50) NULL,
	[LineFolderBus14] [nvarchar](50) NULL,
	[LineFolderBus15] [nvarchar](50) NULL,
	[LineFolderBus16] [nvarchar](50) NULL,
	[LineFolderBus17] [nvarchar](50) NULL,
	[LineFolderBus18] [nvarchar](50) NULL,
	[LineFolderBus19] [nvarchar](50) NULL,
	[LineFolderBus20] [nvarchar](50) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pLineFolderBusiness] PRIMARY KEY CLUSTERED 
(
	[LineFolderBusinessID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusinessID]  DEFAULT (newid()) FOR [LineFolderBusinessID]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderFinancialID]  DEFAULT (newid()) FOR [LineFolderFinancialID]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_RangePlan]  DEFAULT ((0)) FOR [RangePlan]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusLYCh1]  DEFAULT ((0)) FOR [LineFolderLastYearCh]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusPnCh1]  DEFAULT ((0)) FOR [LineFolderPlanningCh]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusCuCh1]  DEFAULT ((0)) FOR [LineFolderDIPCh]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusWpCh1]  DEFAULT ((0)) FOR [LineFolderActualCh]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05360', GetDate())
GO
