
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingAgentVendor_SourcingTradePartnerID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingAgentVendor] DROP CONSTRAINT [DF_pSourcingAgentVendor_SourcingTradePartnerID]
END

GO

/****** Object:  Table [dbo].[pSourcingAgentVendor]    Script Date: 10/12/2012 15:35:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingAgentVendor]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingAgentVendor]
GO



/****** Object:  Table [dbo].[pSourcingAgentVendor]    Script Date: 10/12/2012 15:35:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingAgentVendor](
	[SourcingTradePartnerID] [uniqueidentifier] NOT NULL,
	[SourcingHeaderID] [uniqueidentifier] NULL,
	[TradePartnerVendorID] [uniqueidentifier] NULL,
	[TradePartnerID] [uniqueidentifier] NULL,
	[TradePartnerTypeID] [uniqueidentifier] NULL,
	[ProductTypes] [nvarchar](400) NULL,
	[Active] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Custom1] [nvarchar](200) NULL,
	[Custom2] [nvarchar](200) NULL,
	[Custom3] [nvarchar](200) NULL,
	[Custom4] [nvarchar](200) NULL,
	[Custom5] [nvarchar](200) NULL,
 CONSTRAINT [PK_pSourcingAgentVendor] PRIMARY KEY CLUSTERED 
(
	[SourcingTradePartnerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSourcingAgentVendor] ADD  CONSTRAINT [DF_pSourcingAgentVendor_SourcingTradePartnerID]  DEFAULT (newsequentialid()) FOR [SourcingTradePartnerID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04168', GetDate())
GO

