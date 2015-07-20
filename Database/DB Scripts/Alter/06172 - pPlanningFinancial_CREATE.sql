IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningFinancial_PlanningFinancialID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningFinancial] DROP CONSTRAINT [DF_pPlanningFinancial_PlanningFinancialID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningFinancial_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningFinancial] DROP CONSTRAINT [DF_pPlanningFinancial_Active]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pPlanningFinancial_Editable]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pPlanningFinancial] DROP CONSTRAINT [DF_pPlanningFinancial_Editable]
END

GO

/****** Object:  Table [dbo].[pPlanningFinancial]    Script Date: 08/15/2013 12:41:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pPlanningFinancial]') AND type in (N'U'))
DROP TABLE [dbo].[pPlanningFinancial]
GO

/****** Object:  Table [dbo].[pPlanningFinancial]    Script Date: 08/15/2013 12:41:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pPlanningFinancial](
	[PlanningFinancialID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[PlanningTemplateItemID] [uniqueidentifier] NULL,
	[PlanningFinancialDataType] [varchar](50) NULL,
	[PlanningFinancialDataFormat] [varchar](50) NULL,
	[PlanningFinancialCssClass] [varchar](100) NULL,
	[PlanningFinancialText] [nvarchar](100) NULL,
	[PlanningFinancialValue] [nvarchar](50) NULL,
	[PlanningFinancialGroup] [varchar](50) NULL,
	[PlanningFinancialSort] [varchar](5) NULL,
	[PlanningFinancialDelivery] [nvarchar](50) NULL,
	[PlanningFinancialChannel1] [nvarchar](100) NULL,
	[PlanningFinancialChannel2] [nvarchar](100) NULL,
	[PlanningFinancialChannel3] [nvarchar](100) NULL,
	[PlanningFinancialChannel4] [nvarchar](100) NULL,
	[PlanningFinancialChannel5] [nvarchar](100) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[LinePlanFinancialViewRollup] [nvarchar](500) NULL,
	[BlankIfNull] [int] NULL,
	[Active] [int] NULL,
	[Editable] [int] NULL,
	[AllowPercentInput] [int] NULL,
 CONSTRAINT [PK_pPlanningFinancial] PRIMARY KEY CLUSTERED 
(
	[PlanningFinancialID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pPlanningFinancial] ADD  CONSTRAINT [DF_pPlanningFinancial_PlanningFinancialID]  DEFAULT (newid()) FOR [PlanningFinancialID]
GO

ALTER TABLE [dbo].[pPlanningFinancial] ADD  CONSTRAINT [DF_pPlanningFinancial_Active]  DEFAULT ((1)) FOR [Active]
GO

ALTER TABLE [dbo].[pPlanningFinancial] ADD  CONSTRAINT [DF_pPlanningFinancial_Editable]  DEFAULT ((0)) FOR [Editable]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06172', GetDate())
GO
