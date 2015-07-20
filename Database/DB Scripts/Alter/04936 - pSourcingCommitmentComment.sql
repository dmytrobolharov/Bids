/****** Object:  Table [dbo].[pStyleQuoteComment]    Script Date: 01/28/2013 16:18:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCommitmentComment]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingCommitmentComment]
GO

/****** Object:  Table [dbo].[pStyleQuoteComment]    Script Date: 01/28/2013 16:18:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingCommitmentComment](
	[SourcingCommitmentCommentID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SourcingCommitmentItemID] [uniqueidentifier] NULL,
	[CommentType] [nvarchar](2) NULL,
	[StyleID] [uniqueidentifier] NULL,
	[CTeamID] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[SourcingCommitmentComment] [nvarchar](max) NULL,
 CONSTRAINT [PK_pSourcingCommitmentComment] PRIMARY KEY CLUSTERED 
(
	[SourcingCommitmentCommentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04936', GetDate())
GO