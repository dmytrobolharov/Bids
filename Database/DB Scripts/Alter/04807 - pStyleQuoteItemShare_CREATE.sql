IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleQuoteItemShare]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleQuoteItemShare]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleQuoteItemShare](
	[StyleQouteItemID] [uniqueidentifier] NOT NULL,
	[TradePartnerID] [uniqueidentifier] NOT NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pStyleQuoteShare] PRIMARY KEY CLUSTERED 
(
	[StyleQouteItemID] ASC,
	[TradePartnerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04807', GetDate())
GO
