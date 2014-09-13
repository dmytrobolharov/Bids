IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_uTradePartnerAuditStandardItem_AuditStandardItemId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[uTradePartnerComplianceAuditStandardItem] DROP CONSTRAINT [DF_uTradePartnerAuditStandardItem_AuditStandardItemId]
END

GO

/****** Object:  Table [dbo].[uTradePartnerComplianceAuditStandardItem]    Script Date: 09/25/2012 15:23:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerComplianceAuditStandardItem]') AND type in (N'U'))
DROP TABLE [dbo].[uTradePartnerComplianceAuditStandardItem]
GO

/****** Object:  Table [dbo].[uTradePartnerComplianceAuditStandardItem]    Script Date: 09/25/2012 15:23:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[uTradePartnerComplianceAuditStandardItem](
	[AuditStandardItemId] [uniqueidentifier] NOT NULL,
	[AuditStandardId] [uniqueidentifier] NULL,
	[AuditStandardItemCode] [nvarchar](50) NULL,
	[AuditStandardItemName] [nvarchar](200) NULL,
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
 CONSTRAINT [PK_uTradePartnerAuditStandardItem] PRIMARY KEY CLUSTERED 
(
	[AuditStandardItemId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[uTradePartnerComplianceAuditStandardItem] ADD  CONSTRAINT [DF_uTradePartnerAuditStandardItem_AuditStandardItemId]  DEFAULT (newsequentialid()) FOR [AuditStandardItemId]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03980', GetDate())
GO
