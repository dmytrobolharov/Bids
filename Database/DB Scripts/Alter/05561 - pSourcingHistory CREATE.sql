/****** Object:  Table [dbo].[pSourcingHistory]    Script Date: 04/15/2013 11:17:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingHistory]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingHistory]
GO

/****** Object:  Table [dbo].[pSourcingHistory]    Script Date: 04/15/2013 11:17:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingHistory](
	[SourcingHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[SourcingHeaderID] [uniqueidentifier] NULL,
	[TeamID] [uniqueidentifier] NULL,
	[CDate] [datetime] NULL,
 CONSTRAINT [PK_pSourcingHistory] PRIMARY KEY CLUSTERED 
(
	[SourcingHistoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05561', GetDate())
GO
