IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_uTradePartnerComments_TradePartnerCommentId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[uTradePartnerComments] DROP CONSTRAINT [DF_uTradePartnerComments_TradePartnerCommentId]
END

GO

/****** Object:  Table [dbo].[uTradePartnerComments]    Script Date: 09/25/2012 15:03:51 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerComments]') AND type in (N'U'))
DROP TABLE [dbo].[uTradePartnerComments]
GO


/****** Object:  Table [dbo].[uTradePartnerComments]    Script Date: 09/25/2012 15:03:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[uTradePartnerComments](
	[TradePartnerCommentId] [uniqueidentifier] NOT NULL,
	[TradePartnerId] [uniqueidentifier] NULL,
	[TradePartnerComplianceId] [uniqueidentifier] NULL,
	[CommentType] [nvarchar](2) NULL,
	[TradePartnerComment] [nvarchar](max) NULL,
	[CTeamID] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[MUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_uTradePartnerComments] PRIMARY KEY CLUSTERED 
(
	[TradePartnerCommentId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[uTradePartnerComments] ADD  CONSTRAINT [DF_uTradePartnerComments_TradePartnerCommentId]  DEFAULT (newsequentialid()) FOR [TradePartnerCommentId]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03977', GetDate())
GO
