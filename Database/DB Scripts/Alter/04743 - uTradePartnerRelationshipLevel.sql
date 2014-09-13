IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_uTradePartnerRelationshipLevel_TradePartnerRelationshipLevelID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[uTradePartnerRelationshipLevel] DROP CONSTRAINT [DF_uTradePartnerRelationshipLevel_TradePartnerRelationshipLevelID]
END

GO

/****** Object:  Table [dbo].[uTradePartnerRelationshipLevel]    Script Date: 01/11/2013 10:24:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerRelationshipLevel]') AND type in (N'U'))
DROP TABLE [dbo].[uTradePartnerRelationshipLevel]
GO

/****** Object:  Table [dbo].[uTradePartnerRelationshipLevel]    Script Date: 01/11/2013 10:24:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[uTradePartnerRelationshipLevel](
	[TradePartnerRelationshipLevelID] [uniqueidentifier] NOT NULL,
	[TradePartnerID] [uniqueidentifier] NULL,
	[TradePartnerMasterID] [uniqueidentifier] NULL,
	[TradePartnerRelationshipParentLevelID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_uTradePartnerRelationshipLevel] PRIMARY KEY CLUSTERED 
(
	[TradePartnerRelationshipLevelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[uTradePartnerRelationshipLevel] ADD  CONSTRAINT [DF_uTradePartnerRelationshipLevel_TradePartnerRelationshipLevelID]  DEFAULT (newid()) FOR [TradePartnerRelationshipLevelID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04743', GetDate())
GO
