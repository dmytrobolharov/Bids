/****** Object:  Table [dbo].[pMaterialTradePartnerShare]    Script Date: 01/23/2013 16:03:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pMaterialTradePartnerShare]') AND type in (N'U'))
DROP TABLE [dbo].[pMaterialTradePartnerShare]
GO


/****** Object:  Table [dbo].[pMaterialTradePartnerShare]    Script Date: 01/23/2013 16:03:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pMaterialTradePartnerShare](
	[TradePartnerID] [uniqueidentifier] NOT NULL,
	[MaterialTradePartnerID] [uniqueidentifier] NOT NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
 CONSTRAINT [PK_pMaterialTradePartnerShare] PRIMARY KEY CLUSTERED 
(
	[TradePartnerID] ASC,
	[MaterialTradePartnerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04860', GetDate())
GO
