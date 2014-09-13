/****** Object:  Table [dbo].[uTradePartnerStatus]    Script Date: 11/27/2012 17:33:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerStatus]') AND type in (N'U'))
DROP TABLE [dbo].[uTradePartnerStatus]
GO

/****** Object:  Table [dbo].[uTradePartnerStatus]    Script Date: 11/27/2012 17:33:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[uTradePartnerStatus](
	[StatusID] [int] NOT NULL,
	[Status] [nvarchar](200) NULL,
	[StatusOrder] [varchar](5) NULL,
 CONSTRAINT [PK_uTradePartnerStatus] PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '04465', GetDate())
GO