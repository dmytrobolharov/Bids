IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleCostingDuty_DutyId_1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleCostingDuty] DROP CONSTRAINT [DF_pStyleCostingDuty_DutyId_1]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleCostingDuty_DutyId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleCostingDuty] DROP CONSTRAINT [DF_pStyleCostingDuty_DutyId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleCostingDuty_CustomKey]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleCostingDuty] DROP CONSTRAINT [DF_pStyleCostingDuty_CustomKey]
END

GO

/****** Object:  Table [dbo].[pStyleCostingDuty]    Script Date: 11/05/2012 11:20:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleCostingDuty]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleCostingDuty]
GO


/****** Object:  Table [dbo].[pStyleCostingDuty]    Script Date: 11/02/2012 11:11:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleCostingDuty](
	[CustomID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[CustomKey] [nvarchar](5) NULL,
	[Custom] [nvarchar](225) NULL,
	[DutyFiber] [nvarchar](255) NULL,
	[DutyItem] [nvarchar](255) NULL,
	[DutyCategory] [nvarchar](255) NULL,
	[DutyPerc] [decimal](18, 3) NULL,
	[DutySurcharge] [decimal](18, 3) NULL,
	[DutyCountry] [nvarchar](255) NULL,
	[DutyMaterialType] [nvarchar](255) NULL,
	[DutyGender] [nvarchar](255) NULL,
	[DutyCustom1] [nvarchar](255) NULL,
	[DutyCustom2] [nvarchar](255) NULL,
	[Active] [bit] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[TempNo] [nvarchar](50) NULL,
	[TempID] [nvarchar](50) NULL,
	[CustomSort] [nvarchar](50) NULL,
 CONSTRAINT [PK_pStyleCostingDuty] PRIMARY KEY CLUSTERED 
(
	[CustomID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleCostingDuty] ADD  CONSTRAINT [DF_pStyleCostingDuty_DutyId]  DEFAULT (newid()) FOR [CustomID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04288', GetDate())
GO
