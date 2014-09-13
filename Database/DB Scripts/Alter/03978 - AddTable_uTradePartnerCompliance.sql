IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_uTradePartnerCompliance_TradePartnerCompliance]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[uTradePartnerCompliance] DROP CONSTRAINT [DF_uTradePartnerCompliance_TradePartnerCompliance]
END

GO


/****** Object:  Table [dbo].[uTradePartnerCompliance]    Script Date: 09/25/2012 15:07:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerCompliance]') AND type in (N'U'))
DROP TABLE [dbo].[uTradePartnerCompliance]
GO

/****** Object:  Table [dbo].[uTradePartnerCompliance]    Script Date: 09/25/2012 15:07:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[uTradePartnerCompliance](
	[TradePartnerComplianceId] [uniqueidentifier] NOT NULL,
	[TradePartnerId] [uniqueidentifier] NULL,
	[ComplianceName] [nvarchar](100) NULL,
	[ComplianceType] [nvarchar](100) NULL,
	[Auditors] [nvarchar](200) NULL,
	[AuditStandardId] [uniqueidentifier] NULL,
	[RecurrenceDays] [int] NULL,
	[AlertDays] [int] NULL,
	[AlertDate] [datetime] NULL,
	[PlannedDate] [datetime] NULL,
	[ActualDate] [datetime] NULL,
	[FinalDate] [datetime] NULL,
	[ScheduleDate] [datetime] NULL,
	[ReauditDate] [datetime] NULL,
	[StatusId] [uniqueidentifier] NULL,
	[Sort] [int] NULL,
	[Active] [int] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[Custom1] [nvarchar](200) NULL,
	[Custom2] [nvarchar](200) NULL,
	[Custom3] [nvarchar](200) NULL,
	[Custom4] [nvarchar](200) NULL,
	[Custom5] [nvarchar](200) NULL,
 CONSTRAINT [PK_uTradePartnerCompliance] PRIMARY KEY CLUSTERED 
(
	[TradePartnerComplianceId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[uTradePartnerCompliance] ADD  CONSTRAINT [DF_uTradePartnerCompliance_TradePartnerCompliance]  DEFAULT (newsequentialid()) FOR [TradePartnerComplianceId]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03978', GetDate())
GO
