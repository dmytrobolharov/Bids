IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_uTradePartnerComplinaceDocument_ComplianceDocumentId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[uTradePartnerComplianceDocument] DROP CONSTRAINT [DF_uTradePartnerComplinaceDocument_ComplianceDocumentId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_uTradePartnerComplinaceDocument_SystemServerStorageId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[uTradePartnerComplianceDocument] DROP CONSTRAINT [DF_uTradePartnerComplinaceDocument_SystemServerStorageId]
END

GO

/****** Object:  Table [dbo].[uTradePartnerComplianceDocument]    Script Date: 09/25/2012 15:26:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerComplianceDocument]') AND type in (N'U'))
DROP TABLE [dbo].[uTradePartnerComplianceDocument]
GO

/****** Object:  Table [dbo].[uTradePartnerComplianceDocument]    Script Date: 09/25/2012 15:26:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[uTradePartnerComplianceDocument](
	[ComplianceDocumentId] [uniqueidentifier] NOT NULL,
	[TradePartnerComplianceId] [uniqueidentifier] NULL,
	[TradePartnerId] [uniqueidentifier] NULL,
	[DocumentName] [nvarchar](500) NULL,
	[DocumentDesc] [nvarchar](4000) NULL,
	[DocumentExt] [nvarchar](10) NULL,
	[DocumentSize] [nvarchar](50) NULL,
	[DocumentShared] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[SystemServerStorageId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_uTradePartnerComplinaceDocument] PRIMARY KEY CLUSTERED 
(
	[ComplianceDocumentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[uTradePartnerComplianceDocument] ADD  CONSTRAINT [DF_uTradePartnerComplinaceDocument_ComplianceDocumentId]  DEFAULT (newsequentialid()) FOR [ComplianceDocumentId]
GO

ALTER TABLE [dbo].[uTradePartnerComplianceDocument] ADD  CONSTRAINT [DF_uTradePartnerComplinaceDocument_SystemServerStorageId]  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [SystemServerStorageId]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03981', GetDate())
GO