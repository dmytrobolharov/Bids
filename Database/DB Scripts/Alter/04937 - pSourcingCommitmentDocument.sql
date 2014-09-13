/****** Object:  Table [dbo].[pSourcingCommitmentDocument]    Script Date: 01/28/2013 16:58:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCommitmentDocument]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingCommitmentDocument]
GO

/****** Object:  Table [dbo].[pSourcingCommitmentDocument]    Script Date: 01/28/2013 16:58:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingCommitmentDocument](
	[SourcingCommitmentDocumentID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SourcingCommitmentItemID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[DocumentName] [nvarchar](500) NULL,
	[DocumentDescription] [nvarchar](4000) NULL,
	[DocumentExt] [nvarchar](50) NULL,
	[DocumentSize] [nvarchar](50) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pSourcingCommitmentDocument] PRIMARY KEY CLUSTERED 
(
	[SourcingCommitmentDocumentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04937', GetDate())
GO