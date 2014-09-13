IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestShare_PartnerView]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestShare] DROP CONSTRAINT [DF_pSampleRequestShare_PartnerView]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestShare]') AND type in (N'U'))
DROP TABLE [dbo].[pSampleRequestShare]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSampleRequestShare](
	[SampleRequestTradeID] [uniqueidentifier] NOT NULL,
	[TradePartnerID] [uniqueidentifier] NOT NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[PartnerView] [int] NULL,
 CONSTRAINT [PK_pSampleRequestShare] PRIMARY KEY CLUSTERED 
(
	[SampleRequestTradeID] ASC,
	[TradePartnerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSampleRequestShare] ADD  CONSTRAINT [DF_pSampleRequestShare_PartnerView]  DEFAULT ((0)) FOR [PartnerView]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04876', GetDate())
GO
