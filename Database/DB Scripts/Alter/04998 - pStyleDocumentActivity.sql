IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleDocumentActivity_StyleDocumentActivityRepId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleDocumentActivity] DROP CONSTRAINT [DF_pStyleDocumentActivity_StyleDocumentActivityRepId]
END

GO
/****** Object:  Table [dbo].[pStyleDocumentActivity]    Script Date: 02/07/2013 17:14:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleDocumentActivity]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleDocumentActivity]
GO

/****** Object:  Table [dbo].[pStyleDocumentActivity]    Script Date: 02/07/2013 17:14:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pStyleDocumentActivity](
	[StyleDocumentActivityID] [int] IDENTITY(1,1) NOT NULL,
	[StyleDocumentID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[TeamID] [uniqueidentifier] NULL,
	[TradePartner] [int] NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](150) NULL,
	[StyleDocumentActivity] [nvarchar](200) NULL,
	[ActivityType] [varchar](2) NULL,
	[StyleDocumentActivityRepId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
 CONSTRAINT [PK__pStyleDocumentActivit__5D784BAE] PRIMARY KEY CLUSTERED 
(
	[StyleDocumentActivityID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pStyleDocumentActivity] ADD  CONSTRAINT [DF_pStyleDocumentActivity_StyleDocumentActivityRepId]  DEFAULT (newid()) FOR [StyleDocumentActivityRepId]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04998', GetDate())
GO
