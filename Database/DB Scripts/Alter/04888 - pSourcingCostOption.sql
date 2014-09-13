IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingCostOption_SourcingCostOptionID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCostOption] DROP CONSTRAINT [DF_pSourcingCostOption_SourcingCostOptionID]
END

GO

/****** Object:  Table [dbo].[pSourcingCostOption]    Script Date: 01/24/2013 19:08:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCostOption]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingCostOption]
GO


/****** Object:  Table [dbo].[pSourcingCostOption]    Script Date: 01/24/2013 19:08:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingCostOption](
	[SourcingCostOptionID] [uniqueidentifier] NOT NULL,
	[StyleQuoteItemID] [uniqueidentifier] NOT NULL,
	[OptionNo] [int] NULL,
	[OptionName] [nchar](200) NULL,
	[MinQuantity] [decimal](18, 4) NULL,
	[MaxQuantity] [decimal](18, 4) NULL,
	[CostUnit] [decimal](18, 4) NULL,
	[BOMOption] [uniqueidentifier] NULL,
	[XFactoryDate] [datetime] NULL,
	[ValidTill] [datetime] NULL,
	[CUser] [nchar](200) NULL,
	[CDate] [datetime] NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSourcingCostOption] ADD  CONSTRAINT [DF_pSourcingCostOption_SourcingCostOptionID]  DEFAULT (newid()) FOR [SourcingCostOptionID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04888', GetDate())
GO

