IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'DF_uTradePartnerTemplateItemShare_Share') AND type = 'D')
ALTER TABLE dbo.uTradePartnerTemplateItemShare DROP CONSTRAINT DF_uTradePartnerTemplateItemShare_Share
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.uTradePartnerTemplateItemShare') AND type in (N'U'))
DROP TABLE dbo.uTradePartnerTemplateItemShare
GO

CREATE TABLE dbo.uTradePartnerTemplateItemShare (
	TradePartnerID UNIQUEIDENTIFIER NOT NULL
	, TradePartnerTemplateItemID UNIQUEIDENTIFIER NOT NULL
	, Share BIT NOT NULL
	, CONSTRAINT PK_uTradePartnerTemplateItemShare PRIMARY KEY CLUSTERED (TradePartnerID ASC, TradePartnerTemplateItemID ASC) WITH (
		PAD_INDEX = OFF
		, STATISTICS_NORECOMPUTE = OFF
		, IGNORE_DUP_KEY = OFF
		, ALLOW_ROW_LOCKS = ON
		, ALLOW_PAGE_LOCKS = ON
		) ON [PRIMARY]
	) ON [PRIMARY]
GO

ALTER TABLE dbo.uTradePartnerTemplateItemShare ADD CONSTRAINT DF_uTradePartnerTemplateItemShare_Share DEFAULT (0) FOR Share
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06316', GetDate())
GO
