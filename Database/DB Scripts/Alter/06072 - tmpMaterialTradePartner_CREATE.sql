IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tmpMaterialTradePartner]') AND type in (N'U'))
DROP TABLE [dbo].[tmpMaterialTradePartner]
GO

CREATE TABLE [dbo].[tmpMaterialTradePartner](
	[MaterialID] [uniqueidentifier] NOT NULL,
	[TradePartnerRelationshipLevelID] [uniqueidentifier] NOT NULL,
	[MaterialRequestWorkflowTempID] [uniqueidentifier] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[CDate] [datetime] NULL,
 CONSTRAINT [PK_tmpMaterialTradePartner] PRIMARY KEY CLUSTERED 
(
	[MaterialID] ASC,
	[TradePartnerRelationshipLevelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06072', GetDate())
GO
