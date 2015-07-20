IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_hCommitmentHistory_CDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[hCommitmentHistory] DROP CONSTRAINT [DF_hCommitmentHistory_CDate]
END

GO

/****** Object:  Table [dbo].[hCommitmentHistory]    Script Date: 01/31/2013 15:51:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[hCommitmentHistory]') AND type in (N'U'))
DROP TABLE [dbo].[hCommitmentHistory]
GO

/****** Object:  Table [dbo].[hCommitmentHistory]    Script Date: 01/31/2013 15:51:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[hCommitmentHistory](
	[CommitmentHistoryId] [bigint] IDENTITY(1,1) NOT NULL,
	[CommitmentItemId] [uniqueidentifier] NULL,
	[StyleId] [uniqueidentifier] NULL,
	[TeamId] [uniqueidentifier] NULL,
	[CDate] [datetime] NOT NULL,
 CONSTRAINT [PK_hCommitmentHistory] PRIMARY KEY CLUSTERED 
(
	[CommitmentHistoryId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[hCommitmentHistory] ADD  CONSTRAINT [DF_hCommitmentHistory_CDate]  DEFAULT (getdate()) FOR [CDate]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04946', GetDate())
GO