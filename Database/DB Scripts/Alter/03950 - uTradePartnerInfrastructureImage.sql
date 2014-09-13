
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_uTradePartnerInfrastructureImage_uTradePartnerInfrastructure]') AND parent_object_id = OBJECT_ID(N'[dbo].[uTradePartnerInfrastructureImage]'))
ALTER TABLE [dbo].[uTradePartnerInfrastructureImage] DROP CONSTRAINT [FK_uTradePartnerInfrastructureImage_uTradePartnerInfrastructure]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_uTradePartnerInfrastructureImage_TradePartnerInfrastructureImageID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[uTradePartnerInfrastructureImage] DROP CONSTRAINT [DF_uTradePartnerInfrastructureImage_TradePartnerInfrastructureImageID]
END

GO


/****** Object:  Table [dbo].[uTradePartnerInfrastructureImage]    Script Date: 09/24/2012 01:19:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerInfrastructureImage]') AND type in (N'U'))
DROP TABLE [dbo].[uTradePartnerInfrastructureImage]
GO


/****** Object:  Table [dbo].[uTradePartnerInfrastructureImage]    Script Date: 09/24/2012 01:19:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[uTradePartnerInfrastructureImage](
	[TradePartnerInfrastructureImageID] [uniqueidentifier] NOT NULL,
	[TradePartnerInfrastructureID] [uniqueidentifier] NULL,
	[ImageID] [uniqueidentifier] NULL,
	[ImageDescription] [nvarchar](200) NULL,
	[ImageName] [nvarchar](100) NULL,
	[ImageSize] [int] NULL,
	[ImageType] [nvarchar](50) NULL,
	[ImageVersion] [int] NULL,
	[Sort] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_uTradePartnerInfrastructureImage] PRIMARY KEY CLUSTERED 
(
	[TradePartnerInfrastructureImageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[uTradePartnerInfrastructureImage]  WITH CHECK ADD  CONSTRAINT [FK_uTradePartnerInfrastructureImage_uTradePartnerInfrastructure] FOREIGN KEY([TradePartnerInfrastructureID])
REFERENCES [dbo].[uTradePartnerInfrastructure] ([TradePartnerInfrastructureID])
GO

ALTER TABLE [dbo].[uTradePartnerInfrastructureImage] CHECK CONSTRAINT [FK_uTradePartnerInfrastructureImage_uTradePartnerInfrastructure]
GO

ALTER TABLE [dbo].[uTradePartnerInfrastructureImage] ADD  CONSTRAINT [DF_uTradePartnerInfrastructureImage_TradePartnerInfrastructureImageID]  DEFAULT (newsequentialid()) FOR [TradePartnerInfrastructureImageID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03950', GetDate())
GO
