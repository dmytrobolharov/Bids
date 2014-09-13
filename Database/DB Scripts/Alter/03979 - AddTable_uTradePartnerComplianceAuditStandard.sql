IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_uTradePartnerComplianceAuditStandard_AuditStandardId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[uTradePartnerComplianceAuditStandard] DROP CONSTRAINT [DF_uTradePartnerComplianceAuditStandard_AuditStandardId]
END

GO


/****** Object:  Table [dbo].[uTradePartnerComplianceAuditStandard]    Script Date: 09/25/2012 15:21:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerComplianceAuditStandard]') AND type in (N'U'))
DROP TABLE [dbo].[uTradePartnerComplianceAuditStandard]
GO

/****** Object:  Table [dbo].[uTradePartnerComplianceAuditStandard]    Script Date: 09/25/2012 15:21:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[uTradePartnerComplianceAuditStandard](
	[AuditStandardId] [uniqueidentifier] NOT NULL,
	[AuditStandardCode] [nvarchar](50) NULL,
	[AuditStandardDesc] [nvarchar](100) NULL,
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
 CONSTRAINT [PK_uTradePartnerComplianceAuditStandard] PRIMARY KEY CLUSTERED 
(
	[AuditStandardId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[uTradePartnerComplianceAuditStandard] ADD  CONSTRAINT [DF_uTradePartnerComplianceAuditStandard_AuditStandardId]  DEFAULT (newsequentialid()) FOR [AuditStandardId]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03979', GetDate())
GO



