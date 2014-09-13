IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningBusiness_PlanningBusinessID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningBusiness] DROP CONSTRAINT [DF_pPlanningBusiness_PlanningBusinessID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningBusiness_PlanningFinancialID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningBusiness] DROP CONSTRAINT [DF_pPlanningBusiness_PlanningFinancialID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningBusiness_PlanningBusLYCh1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningBusiness] DROP CONSTRAINT [DF_pPlanningBusiness_PlanningBusLYCh1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningBusiness_PlanningBusPnCh1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningBusiness] DROP CONSTRAINT [DF_pPlanningBusiness_PlanningBusPnCh1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningBusiness_PlanningBusCuCh1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningBusiness] DROP CONSTRAINT [DF_pPlanningBusiness_PlanningBusCuCh1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningBusiness_PlanningBusWpCh1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningBusiness] DROP CONSTRAINT [DF_pPlanningBusiness_PlanningBusWpCh1]
END

GO

/****** Object:  Table [dbo].[pPlanningBusiness]    Script Date: 03/20/2013 12:19:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningBusiness]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanningBusiness]
GO

/****** Object:  Table [dbo].[pPlanningBusiness]    Script Date: 03/20/2013 12:19:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pPlanningBusiness](
	[PlanningBusinessID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
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
	[PlanningBus1] [nvarchar](50) NULL,
	[PlanningBus2] [nvarchar](50) NULL,
	[PlanningBus3] [nvarchar](50) NULL,
	[PlanningBus4] [nvarchar](50) NULL,
	[PlanningBus5] [nvarchar](50) NULL,
	[PlanningBus6] [nvarchar](50) NULL,
	[PlanningBus7] [nvarchar](50) NULL,
	[PlanningBus8] [nvarchar](50) NULL,
	[PlanningBus9] [nvarchar](50) NULL,
	[PlanningBus10] [nvarchar](50) NULL,
	[PlanningBus11] [nvarchar](50) NULL,
	[PlanningBus12] [nvarchar](50) NULL,
	[PlanningBus13] [nvarchar](50) NULL,
	[PlanningBus14] [nvarchar](50) NULL,
	[PlanningBus15] [nvarchar](50) NULL,
	[PlanningBus16] [nvarchar](50) NULL,
	[PlanningBus17] [nvarchar](50) NULL,
	[PlanningBus18] [nvarchar](50) NULL,
	[PlanningBus19] [nvarchar](50) NULL,
	[PlanningBus20] [nvarchar](50) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pPlanningBusiness] PRIMARY KEY CLUSTERED 
(
	[PlanningBusinessID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pPlanningBusiness] ADD  CONSTRAINT [DF_pPlanningBusiness_PlanningBusinessID]  DEFAULT (newid()) FOR [PlanningBusinessID]
GO

ALTER TABLE [dbo].[pPlanningBusiness] ADD  CONSTRAINT [DF_pPlanningBusiness_PlanningFinancialID]  DEFAULT (newid()) FOR [PlanningFinancialID]
GO

ALTER TABLE [dbo].[pPlanningBusiness] ADD  CONSTRAINT [DF_pPlanningBusiness_PlanningBusLYCh1]  DEFAULT ((0)) FOR [PlanningLastYearCh]
GO

ALTER TABLE [dbo].[pPlanningBusiness] ADD  CONSTRAINT [DF_pPlanningBusiness_PlanningBusPnCh1]  DEFAULT ((0)) FOR [PlanningPlanningCh]
GO

ALTER TABLE [dbo].[pPlanningBusiness] ADD  CONSTRAINT [DF_pPlanningBusiness_PlanningBusCuCh1]  DEFAULT ((0)) FOR [PlanningDIPCh]
GO

ALTER TABLE [dbo].[pPlanningBusiness] ADD  CONSTRAINT [DF_pPlanningBusiness_PlanningBusWpCh1]  DEFAULT ((0)) FOR [PlanningActualCh]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06171', GetDate())
GO
