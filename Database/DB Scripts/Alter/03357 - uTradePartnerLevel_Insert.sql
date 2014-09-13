IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerLevel]') AND type in (N'U'))
DROP TABLE [dbo].[uTradePartnerLevel]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[uTradePartnerLevel](
	[TradePartnerLevelID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[TradePartnerLevel] [int] NULL,
 CONSTRAINT [PK_uTradePartnerLevel] PRIMARY KEY CLUSTERED 
(
	[TradePartnerLevelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[uTradePartnerLevel] ADD  CONSTRAINT [DF_uTradePartnerLevel_TradePartnerLevelID]  DEFAULT (newid()) FOR [TradePartnerLevelID]
GO

IF NOT EXISTS (select * from  uTradePartnerLevel  where TradePartnerLevel = 1)
	BEGIN
		INSERT INTO uTradePartnerLevel
				   (TradePartnerLevel)
			 VALUES
				   (1)
	END
	
IF NOT EXISTS (select * from  uTradePartnerLevel  where TradePartnerLevel = 2)
	BEGIN
		INSERT INTO uTradePartnerLevel
				   (TradePartnerLevel)
			 VALUES
				   (2)
	END
	
IF NOT EXISTS (select * from  uTradePartnerLevel  where TradePartnerLevel = 3)
	BEGIN          
		INSERT INTO uTradePartnerLevel
				   (TradePartnerLevel)
			 VALUES
				   (3)
	END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03357'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03357', GetDate())

END

GO