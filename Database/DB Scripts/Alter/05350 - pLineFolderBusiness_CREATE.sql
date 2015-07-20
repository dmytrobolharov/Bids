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

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderBusLYCh2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusLYCh2]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderBusLYCh3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusLYCh3]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderBusLYCh4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusLYCh4]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderBusLYCh5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusLYCh5]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderBusPnCh1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusPnCh1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderBusPnCh2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusPnCh2]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderBusPnCh3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusPnCh3]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderBusPnCh4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusPnCh4]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderBusPnCh5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusPnCh5]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderBusCuCh1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusCuCh1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderBusCuCh2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusCuCh2]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderBusCuCh3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusCuCh3]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderBusCuCh4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusCuCh4]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderBusCuCh5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusCuCh5]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderBusWpCh1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusWpCh1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderBusWpCh2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusWpCh2]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderBusLWpCh3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusLWpCh3]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderBusWpCh4]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusWpCh4]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pLineFolderBusiness_LineFolderBusWpCh5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pLineFolderBusiness] DROP CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusWpCh5]
END

GO

/****** Object:  Table [dbo].[pLineFolderBusiness]    Script Date: 03/19/2013 17:46:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pLineFolderBusiness]') AND type in (N'U'))
DROP TABLE [dbo].[pLineFolderBusiness]
GO

/****** Object:  Table [dbo].[pLineFolderBusiness]    Script Date: 03/19/2013 17:46:11 ******/
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
	[LineFolderBusLYCh1] [decimal](18, 5) NULL,
	[LineFolderBusLYCh2] [decimal](18, 5) NULL,
	[LineFolderBusLYCh3] [decimal](18, 5) NULL,
	[LineFolderBusLYCh4] [decimal](18, 5) NULL,
	[LineFolderBusLYCh5] [decimal](18, 5) NULL,
	[LineFolderBusPnCh1] [decimal](18, 5) NULL,
	[LineFolderBusPnCh2] [decimal](18, 5) NULL,
	[LineFolderBusPnCh3] [decimal](18, 5) NULL,
	[LineFolderBusPnCh4] [decimal](18, 5) NULL,
	[LineFolderBusPnCh5] [decimal](18, 5) NULL,
	[LineFolderBusCuCh1] [decimal](18, 5) NULL,
	[LineFolderBusCuCh2] [decimal](18, 5) NULL,
	[LineFolderBusCuCh3] [decimal](18, 5) NULL,
	[LineFolderBusCuCh4] [decimal](18, 5) NULL,
	[LineFolderBusCuCh5] [decimal](18, 5) NULL,
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
	[LineFolderBusWpCh1] [decimal](18, 5) NULL,
	[LineFolderBusWpCh2] [decimal](18, 5) NULL,
	[LineFolderBusWpCh3] [decimal](18, 5) NULL,
	[LineFolderBusWpCh4] [decimal](18, 5) NULL,
	[LineFolderBusWpCh5] [decimal](18, 5) NULL,
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

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusLYCh1]  DEFAULT ((0)) FOR [LineFolderBusLYCh1]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusLYCh2]  DEFAULT ((0)) FOR [LineFolderBusLYCh2]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusLYCh3]  DEFAULT ((0)) FOR [LineFolderBusLYCh3]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusLYCh4]  DEFAULT ((0)) FOR [LineFolderBusLYCh4]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusLYCh5]  DEFAULT ((0)) FOR [LineFolderBusLYCh5]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusPnCh1]  DEFAULT ((0)) FOR [LineFolderBusPnCh1]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusPnCh2]  DEFAULT ((0)) FOR [LineFolderBusPnCh2]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusPnCh3]  DEFAULT ((0)) FOR [LineFolderBusPnCh3]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusPnCh4]  DEFAULT ((0)) FOR [LineFolderBusPnCh4]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusPnCh5]  DEFAULT ((0)) FOR [LineFolderBusPnCh5]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusCuCh1]  DEFAULT ((0)) FOR [LineFolderBusCuCh1]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusCuCh2]  DEFAULT ((0)) FOR [LineFolderBusCuCh2]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusCuCh3]  DEFAULT ((0)) FOR [LineFolderBusCuCh3]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusCuCh4]  DEFAULT ((0)) FOR [LineFolderBusCuCh4]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusCuCh5]  DEFAULT ((0)) FOR [LineFolderBusCuCh5]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusWpCh1]  DEFAULT ((0)) FOR [LineFolderBusWpCh1]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusWpCh2]  DEFAULT ((0)) FOR [LineFolderBusWpCh2]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusLWpCh3]  DEFAULT ((0)) FOR [LineFolderBusWpCh3]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusWpCh4]  DEFAULT ((0)) FOR [LineFolderBusWpCh4]
GO

ALTER TABLE [dbo].[pLineFolderBusiness] ADD  CONSTRAINT [DF_pLineFolderBusiness_LineFolderBusWpCh5]  DEFAULT ((0)) FOR [LineFolderBusWpCh5]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05350', GetDate())
GO
