IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_uTradePartnerComplianceStatus_StatusId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[uTradePartnerComplianceStatus] DROP CONSTRAINT [DF_uTradePartnerComplianceStatus_StatusId]
END

GO


/****** Object:  Table [dbo].[uTradePartnerComplianceStatus]    Script Date: 09/25/2012 15:32:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerComplianceStatus]') AND type in (N'U'))
DROP TABLE [dbo].[uTradePartnerComplianceStatus]
GO

/****** Object:  Table [dbo].[uTradePartnerComplianceStatus]    Script Date: 09/25/2012 15:32:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[uTradePartnerComplianceStatus](
	[StatusId] [uniqueidentifier] NOT NULL,
	[StatusCode] [nvarchar](20) NULL,
	[StatusDesc] [nvarchar](100) NULL,
	[Sort] [int] NULL,
	[Active] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_uTradePartnerComplianceStatus] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[uTradePartnerComplianceStatus] ADD  CONSTRAINT [DF_uTradePartnerComplianceStatus_StatusId]  DEFAULT (newsequentialid()) FOR [StatusId]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03983', GetDate())
GO