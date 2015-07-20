/****** Object:  Table [dbo].[pStyleRemovalReason]    Script Date: 02/05/2013 12:27:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleRemovalReason]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleRemovalReason]
GO

/****** Object:  Table [dbo].[pStyleRemovalReason]    Script Date: 02/05/2013 12:27:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleRemovalReason](
	[RemovalReasonID] [uniqueidentifier] NOT NULL,
	[RemovalReasonCode] [int] NULL,
	[RemovalReason] [nvarchar](500) NULL,
	[CDate] [datetime] NULL,
	[MDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MUser] [nvarchar](200) NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pStyleRemovalReason] PRIMARY KEY CLUSTERED 
(
	[RemovalReasonID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04971', GetDate())
GO
