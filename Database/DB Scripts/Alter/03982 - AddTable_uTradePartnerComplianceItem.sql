IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_uTradePartnerComplianceItem_TradePartnerComplianceItemId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[uTradePartnerComplianceItem] DROP CONSTRAINT [DF_uTradePartnerComplianceItem_TradePartnerComplianceItemId]
END

GO

/****** Object:  Table [dbo].[uTradePartnerComplianceItem]    Script Date: 09/25/2012 15:27:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerComplianceItem]') AND type in (N'U'))
DROP TABLE [dbo].[uTradePartnerComplianceItem]
GO


/****** Object:  Table [dbo].[uTradePartnerComplianceItem]    Script Date: 09/25/2012 15:27:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[uTradePartnerComplianceItem](
	[TradePartnerComplianceItemId] [uniqueidentifier] NOT NULL,
	[TradePartnerComplianceId] [uniqueidentifier] NULL,
	[TradePartnerId] [uniqueidentifier] NULL,
	[AuditStandardId] [uniqueidentifier] NULL,
	[AuditStandardItemId] [uniqueidentifier] NULL,
	[ItemDesc] [nvarchar](300) NULL,
	[StatusId] [uniqueidentifier] NULL,
	[Active] [int] NULL,
	[Sort] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Custom1] [nvarchar](200) NULL,
	[Custom2] [nvarchar](200) NULL,
	[Custom3] [nvarchar](200) NULL,
	[Custom4] [nvarchar](200) NULL,
	[Custom5] [nvarchar](200) NULL,
 CONSTRAINT [PK_uTradePartnerComplianceItem] PRIMARY KEY CLUSTERED 
(
	[TradePartnerComplianceItemId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[uTradePartnerComplianceItem] ADD  CONSTRAINT [DF_uTradePartnerComplianceItem_TradePartnerComplianceItemId]  DEFAULT (newsequentialid()) FOR [TradePartnerComplianceItemId]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03982', GetDate())
GO