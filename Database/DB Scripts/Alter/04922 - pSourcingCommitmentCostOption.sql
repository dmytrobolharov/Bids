/****** Object:  Table [dbo].[pSourcingCommitmentCostOption]    Script Date: 01/30/2013 16:17:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCommitmentCostOption]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingCommitmentCostOption]
GO

/****** Object:  Table [dbo].[pSourcingCommitmentCostOption]    Script Date: 01/30/2013 16:17:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingCommitmentCostOption](
	[SourcingCommitmentCostOptionID] [uniqueidentifier] NOT NULL,
	[CommitmentItemID] [uniqueidentifier] NOT NULL,
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


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04922', GetDate())
GO
